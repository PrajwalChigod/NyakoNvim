-- Check Neovim version requirement
if vim.fn.has("nvim-0.11") == 0 then
	vim.api.nvim_err_writeln("This configuration requires Neovim 0.11 or later")
	vim.cmd("cquit") -- Exit with error code
end

-- Bootstrap loader with error handling
local ok, loader = pcall(require, "utils.loader")
if not ok then
	vim.api.nvim_err_writeln("Failed to load utils.loader: " .. tostring(loader))
	vim.cmd("cquit")
end
loader.bootstrap()

require("config.options")
require("config.lazy")
require("config.diagnostics")
require("config.quickfix")

require("config.keymaps")
require("config.autocmds")
require("config.session")
require("config.neovide")

local utils = require("utils")

local preferred = utils.load_colorscheme()
local fallback = "catppuccin"

local ok, err = pcall(vim.cmd.colorscheme, preferred)
if not ok then
	local message = string.format("Colorscheme '%s' failed: %s", preferred, err)
	vim.schedule(function()
		vim.notify(message, vim.log.levels.WARN)
	end)

	if preferred ~= fallback then
		local fallback_ok, fallback_err = pcall(vim.cmd.colorscheme, fallback)
		if not fallback_ok then
			vim.schedule(function()
				vim.notify("Failed to load fallback colorscheme: " .. tostring(fallback_err), vim.log.levels.ERROR)
			end)
		end
	end
end
