local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Build plugin spec
local spec = {
	{ import = "plugins.core" },
}

local function path_exists(path)
	return vim.uv.fs_stat(path) ~= nil
end

local function dir_has_lua_files(path)
	local matches = vim.fs.find(function(name, file_path)
		return name:match("%.lua$") and name ~= "README.lua" and vim.fn.isdirectory(file_path) == 0
	end, {
		path = path,
		limit = 1,
		type = "file",
		upward = false,
	})

	return #matches > 0
end

local function is_valid_plugin_name(name)
	return type(name) == "string" and name:match("^[%w%-%.]+/[%w%-%.]+$") ~= nil
end

local function load_disabled_specs(path)
	if not path_exists(path) then
		return {}
	end

	local ok, disabled = pcall(dofile, path)
	if not ok or type(disabled) ~= "table" then
		return {}
	end

	local normalized = {}
	for _, item in ipairs(disabled) do
		if type(item) == "string" then
			if is_valid_plugin_name(item) then
				table.insert(normalized, { item, enabled = false })
			end
		elseif type(item) == "table" then
			local copy = vim.tbl_deep_extend("force", {}, item)
			copy.enabled = false
			table.insert(normalized, copy)
		end
	end

	return normalized
end

-- Add extras import if directory exists
local config_root = vim.fn.stdpath("config")
local extras_path = config_root .. "/lua/plugins/extras"
if dir_has_lua_files(extras_path) then
	table.insert(spec, { import = "plugins.extras" })
end

local disabled = load_disabled_specs(config_root .. "/lua/config/disabled.lua")
if #disabled > 0 then
	vim.list_extend(spec, disabled)
end

require("lazy").setup(spec, {
	change_detection = {
		notify = false,
	},
	checker = {
		enabled = false, -- Disable automatic update checking for better performance
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			paths = {}, -- add any custom paths here that you want to includes in the rtp
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"man",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
			},
		},
	},
	ui = {
		border = "rounded",
	},
	install = {
    missing = false,
		colorscheme = { "kanagawa" },
	},
	concurrency = 10, -- Faster parallel plugin loading (default is 5)
})
