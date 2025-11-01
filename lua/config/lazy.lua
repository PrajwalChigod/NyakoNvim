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

local custom = require("utils.custom")
local spec = custom.build_lazy_spec()

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
		colorscheme = { "catppuccin" },
	},
	concurrency = 10, -- Faster parallel plugin loading (default is 5)
})
