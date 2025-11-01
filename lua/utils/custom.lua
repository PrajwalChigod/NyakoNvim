local uv = vim.uv
local api = vim.api

local M = {}

local config_root = vim.fn.stdpath("config")

M.paths = {
	root = config_root .. "/custom",
	overrides = config_root .. "/custom/overrides",
	extras = config_root .. "/custom/extras",
	init = config_root .. "/custom/init.lua",
	disabled = config_root .. "/custom/disabled.lua",
}

local module_roots = {
	{ dir = config_root .. "/lua/config", prefix = "config." },
	{ dir = config_root .. "/lua/plugins", prefix = "plugins." },
	{ dir = config_root .. "/lua/utils", prefix = "utils." },
}

-- Cache to improve startup performance
local _cache = {
	module_lookup = nil,
	dirs_exist = nil,
}

local function path_exists(path)
	local stat = uv.fs_stat(path)
	return stat ~= nil
end

local function ensure_dir(path)
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		return true
	end
	return false
end

local function write_file_if_missing(path, lines)
	if vim.fn.filereadable(path) == 1 then
		return false
	end
	vim.fn.writefile(lines, path)
	return true
end

local function notify(msg, level)
	vim.schedule(function()
		vim.notify(msg, level or vim.log.levels.INFO)
	end)
end

local function execute_lua(path)
	local chunk, err = loadfile(path)
	if not chunk then
		return false, ("Failed to parse %s: %s"):format(path, err)
	end
	local ok, result = pcall(chunk)
	if not ok then
		return false, ("Error while executing %s: %s"):format(path, result)
	end
	return true, result
end

-- Build module lookup table once to avoid repeated fs_stat calls
local function build_module_lookup()
	if _cache.module_lookup then
		return _cache.module_lookup
	end

	_cache.module_lookup = {}

	for _, root in ipairs(module_roots) do
		local handle = uv.fs_scandir(root.dir)
		if handle then
			while true do
				local name, t = uv.fs_scandir_next(handle)
				if not name then
					break
				end
				if t ~= "directory" and name:match("%.lua$") then
					local stem = name:gsub("%.lua$", "")
					_cache.module_lookup[name] = root.prefix .. stem
				end
			end
		end
	end

	return _cache.module_lookup
end

local function resolve_module_name(file_name)
	local lookup = build_module_lookup()
	return lookup[file_name]
end

local function iter_lua_files(dir)
	local handle = uv.fs_scandir(dir)
	if not handle then
		return function()
			return nil
		end
	end

	return function()
		while true do
			local name, t = uv.fs_scandir_next(handle)
			if not name then
				return nil
			end
			if t == "directory" then
				goto continue
			end
			if name:sub(-4) == ".lua" then
				return name, dir .. "/" .. name
			end
			::continue::
		end
	end
end

local function register_override(module_name, path)
	package.preload[module_name] = function()
		local ok, result = execute_lua(path)
		if not ok then
			error(result)
		end
		-- Return the result as-is, even if nil
		-- Lua's module system handles nil returns correctly
		return result
	end
	package.loaded[module_name] = nil
end

-- Find similar module names for better error messages
local function find_similar_modules(file_name)
	local lookup = build_module_lookup()
	local suggestions = {}
	local stem = file_name:gsub("%.lua$", "")

	-- Simple substring matching for suggestions
	for available_file, module_name in pairs(lookup) do
		local available_stem = available_file:gsub("%.lua$", "")
		if available_stem:find(stem, 1, true) or stem:find(available_stem, 1, true) then
			table.insert(suggestions, available_file)
		end
	end

	return suggestions
end

local function apply_override_preloads()
	if not path_exists(M.paths.overrides) then
		return {}
	end

	local applied = {}
	local failed = {}

	for name, path in iter_lua_files(M.paths.overrides) do
		local module_name = resolve_module_name(name)

		if module_name then
			register_override(module_name, path)
			applied[module_name] = path
		else
			table.insert(failed, name)
		end
	end

	-- Show helpful error messages with suggestions
	if #failed > 0 then
		for _, name in ipairs(failed) do
			local suggestions = find_similar_modules(name)
			local msg = ("No matching core module found for override file '%s'"):format(name)

			if #suggestions > 0 then
				msg = msg .. ("\nDid you mean: %s?"):format(table.concat(suggestions, ", "))
			end

			notify(msg, vim.log.levels.WARN)
		end
	end

	return applied
end

local function append_spec(target, spec, source)
	if type(spec) ~= "table" then
		notify(("Custom file %s must return a table; received %s"):format(source, type(spec)), vim.log.levels.WARN)
		return
	end

	if vim.tbl_islist(spec) then
		for _, entry in ipairs(spec) do
			table.insert(target, entry)
		end
	else
		table.insert(target, spec)
	end
end

local function collect_extra_specs()
	if not path_exists(M.paths.extras) then
		return {}
	end

	local extras = {}

	for name, path in iter_lua_files(M.paths.extras) do
		-- Don't load the file now! Let lazy.nvim handle it via lazy imports
		local stem = name:gsub("%.lua$", "")
		local module_name = "custom.extras." .. stem

		-- Register the module loader
		package.preload[module_name] = function()
			local ok, result = execute_lua(path)
			if not ok then
				error(result)
			end
			return result
		end

		-- Add as lazy import spec (defers loading)
		table.insert(extras, { import = module_name })
	end

	return extras
end

local function collect_disabled_specs()
	if not path_exists(M.paths.disabled) then
		return {}
	end

	local ok, entries = execute_lua(M.paths.disabled)
	if not ok then
		notify(entries, vim.log.levels.ERROR)
		return {}
	end

	if type(entries) ~= "table" then
		notify(("custom/disabled.lua must return a table; received %s"):format(type(entries)), vim.log.levels.WARN)
		return {}
	end

	local disabled = {}

	-- Support two simple formats:
	-- 1. List of strings: { "plugin/name", ... }
	-- 2. List of lazy.nvim specs: { { "plugin/name", opts = {} }, ... }
	for _, item in ipairs(entries) do
		if type(item) == "string" then
			-- Format 1: Simple plugin name
			table.insert(disabled, { item, enabled = false })
		elseif type(item) == "table" then
			-- Format 2: Plugin spec table
			-- Create a copy to avoid mutating the user's original table
			local copy = vim.tbl_extend("force", {}, item)
			copy.enabled = false
			table.insert(disabled, copy)
		else
			notify(("Unsupported entry in custom/disabled.lua: %s"):format(type(item)), vim.log.levels.WARN)
		end
	end

	return disabled
end

local function run_custom_init()
	if not path_exists(M.paths.init) then
		return
	end
	local ok, err = execute_lua(M.paths.init)
	if not ok then
		notify(err, vim.log.levels.ERROR)
	end
end

function M.setup_custom_dir()
	local created = {}

	if ensure_dir(M.paths.root) then
		table.insert(created, "custom/")
	end

	if ensure_dir(M.paths.overrides) then
		table.insert(created, "custom/overrides/")
	end

	if ensure_dir(M.paths.extras) then
		table.insert(created, "custom/extras/")
	end

	if write_file_if_missing(M.paths.init, {
		"-- This file is sourced automatically after NyakoNvim bootstraps.",
		"-- Use it to run custom Lua that does not belong in overrides or extras.",
		"",
		"-- Example:",
		"-- vim.g.mapleader = ' '",
	}) then
		table.insert(created, "custom/init.lua")
	end

	if write_file_if_missing(M.paths.disabled, {
		"return {",
		"\t-- Example:",
		"\t-- \"folke/trouble.nvim\",",
		"}",
	}) then
		table.insert(created, "custom/disabled.lua")
	end

	if #created == 0 then
		return false
	end

	local message = "Created: " .. table.concat(created, ", ")
	notify(message, vim.log.levels.INFO)
	return true
end

local function register_setup_command()
	local ok, commands = pcall(api.nvim_get_commands, { builtin = false })
	if ok and commands["SetupCustom"] then
		return
	end

	pcall(api.nvim_create_user_command, "SetupCustom", function()
		if not M.setup_custom_dir() then
			notify("Custom setup already initialized.", vim.log.levels.INFO)
		end
	end, { desc = "Create local NyakoNvim customisation scaffolding." })
end

function M.build_lazy_spec()
	local spec = {
		{ import = "plugins" },
	}

	local extras = collect_extra_specs()
	if #extras > 0 then
		vim.list_extend(spec, extras)
	end

	local disabled = collect_disabled_specs()
	if #disabled > 0 then
		vim.list_extend(spec, disabled)
	end

	return spec
end

function M.bootstrap()
	if M._bootstrapped then
		return
	end
	M._bootstrapped = true

	M._applied_overrides = apply_override_preloads()

	register_setup_command()
	run_custom_init()
end

return M
