require("config.options")
require("config.lazy")
require("config.diagnostics")

require("config.keymaps")
require("config.autocmds")

local utils = require("utils")
local colorscheme = utils.load_colorscheme()

local available_colorschemes = vim.fn.getcompletion("", "color")
if not vim.tbl_contains(available_colorschemes, colorscheme) then
	vim.notify(
		string.format("Colorscheme '%s' not available. Using default 'catppuccin'.", colorscheme),
		vim.log.levels.WARN
	)
	colorscheme = "catppuccin"
end

local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
	vim.notify("Failed to load colorscheme: " .. tostring(err), vim.log.levels.ERROR)
	pcall(vim.cmd.colorscheme, "catppuccin") -- fallback colorscheme
end
