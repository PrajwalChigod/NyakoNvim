-- Check Neovim version requirement
if vim.fn.has("nvim-0.12") == 0 then
	vim.api.nvim_echo({ { "This configuration requires Neovim 0.12 or later" } }, true, { err = true })
	vim.cmd("cquit") -- Exit with error code
end

require("config.options")
require("config.lazy")
require("config.diagnostics")
require("config.quickfix")
require("config.lsp")

require("config.keymaps")
require("config.autocmds")
require("config.session")
require("config.neovide")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local ok, loader = pcall(require, "utils.loader")
		if ok then
			loader.bootstrap()
		end
	end,
})

local utils = require("utils")

local preferred = utils.load_colorscheme()
local fallback = "kanagawa-tora"

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
