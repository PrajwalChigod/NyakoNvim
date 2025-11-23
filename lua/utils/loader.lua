local uv = vim.uv
local api = vim.api

local M = {}

local config_root = vim.fn.stdpath("config")

M.paths = {
	extras = config_root .. "/lua/plugins/extras",
	disabled = config_root .. "/lua/config/disabled.lua",
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

-- Validate plugin name format (owner/repo)
local function is_valid_plugin_name(name)
	if type(name) ~= "string" or name == "" then
		return false
	end
	-- Basic format: owner/repo or owner/repo.nvim
	return name:match("^[%w%-%.]+/[%w%-%.]+$") ~= nil
end

function M.collect_disabled_specs()
	if not path_exists(M.paths.disabled) then
		return {}
	end

	local ok, entries = execute_lua(M.paths.disabled)
	if not ok then
		notify(entries, vim.log.levels.ERROR)
		return {}
	end

	if type(entries) ~= "table" then
		notify(("config/disabled.lua must return a table; received %s"):format(type(entries)), vim.log.levels.WARN)
		return {}
	end

	local disabled = {}

	-- Support two simple formats:
	-- 1. List of strings: { "plugin/name", ... }
	-- 2. List of lazy.nvim specs: { { "plugin/name", opts = {} }, ... }
	for _, item in ipairs(entries) do
		if type(item) == "string" then
			-- Format 1: Simple plugin name
			if not is_valid_plugin_name(item) then
				notify(
					("Invalid plugin name in config/disabled.lua: '%s' (expected format: 'owner/repo')"):format(item),
					vim.log.levels.WARN
				)
			else
				table.insert(disabled, { item, enabled = false })
			end
		elseif type(item) == "table" then
			-- Format 2: Plugin spec table
			-- Create a copy to avoid mutating the user's original table
			local copy = vim.tbl_extend("force", {}, item)
			copy.enabled = false
			table.insert(disabled, copy)
		else
			notify(("Unsupported entry in config/disabled.lua: %s"):format(type(item)), vim.log.levels.WARN)
		end
	end

	return disabled
end

function M.setup_custom_dir()
	local created = {}

	if ensure_dir(M.paths.extras) then
		table.insert(created, "lua/plugins/extras/")
	end

	if write_file_if_missing(M.paths.disabled, {
		"-- Disable plugins by adding them to this list",
		"-- Examples:",
		'--   "folke/noice.nvim",',
		'--   { "folke/flash.nvim", opts = {} },',
		"return {}",
	}) then
		table.insert(created, "lua/config/disabled.lua")
	end

	if #created == 0 then
		return false
	end

	local message = "Created: " .. table.concat(created, ", ")
	notify(message, vim.log.levels.INFO)
	return true
end

local function register_setup_command()
	-- Check if command already exists
	if vim.fn.exists(":SetupCustom") == 2 then
		return
	end

	-- Register the command with error handling
	local ok, err = pcall(api.nvim_create_user_command, "SetupCustom", function()
		if not M.setup_custom_dir() then
			notify("Custom setup already initialized.", vim.log.levels.INFO)
		end
	end, { desc = "Create user customization structure (extras and disabled.lua)" })

	if not ok then
		notify("Failed to register SetupCustom command: " .. tostring(err), vim.log.levels.ERROR)
	end
end

function M.bootstrap()
	if M._bootstrapped then
		return
	end
	M._bootstrapped = true

	register_setup_command()
end

return M
