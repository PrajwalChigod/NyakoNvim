require("config.options")
require("config.lazy")
require("config.diagnostics")
require("config.quickfix")

require("config.keymaps")
require("config.autocmds")

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
