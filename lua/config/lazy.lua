local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Check if directory has .lua files (recursively)
local function has_lua_files(dir_path)
	local ok, iter = pcall(vim.fs.dir, dir_path)
	if not ok then
		return false
	end

	for name, type in iter do
		-- Skip hidden files and README
		if type == "file" and name:match("%.lua$") and name ~= "README.lua" then
			return true
		elseif type == "directory" and not name:match("^%.") then
			-- Recursively check subdirectories
			if has_lua_files(dir_path .. "/" .. name) then
				return true
			end
		end
	end
	return false
end

-- Build plugin spec
local spec = {
	{ import = "plugins.core" },
}

-- Add extras import if directory has .lua files
local config_root = vim.fn.stdpath("config")
local extras_path = config_root .. "/lua/plugins/extras"
if has_lua_files(extras_path) then
	table.insert(spec, { import = "plugins.extras" })
end

-- Load disabled plugins
local loader = require("utils.loader")
local disabled = loader.collect_disabled_specs()
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
		colorscheme = { "catppuccin" },
	},
	concurrency = 10, -- Faster parallel plugin loading (default is 5)
})
