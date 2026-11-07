-- ============================================================================
-- Diagnostics Configuration
-- Diagnostics are DISABLED by default and must be explicitly enabled
-- ============================================================================

-- How diagnostics look when shown. One config call: later calls replace whole
-- keys (e.g. `signs`), which is what used to drop the custom sign icons.
vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = "●",
	},
	float = {
		source = "if_many",
		border = "rounded",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Hidden on startup. Diagnostics are still collected, so ]d / [d, gel and geq
-- keep working while they're hidden.
vim.diagnostic.enable(false)

local function toggle_diagnostics()
	local enable = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(enable)
	vim.notify("Diagnostics " .. (enable and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- Diagnostics keymaps with ge* pattern (diagnostic errors/issues)
-- Note: ]d, [d, and <C-w>d are built-in Neovim defaults for diagnostic navigation
vim.keymap.set("n", "get", toggle_diagnostics, { desc = "Toggle diagnostics (enable/disable)" })
vim.keymap.set("n", "gel", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })
vim.keymap.set("n", "geq", vim.diagnostic.setqflist, { desc = "Set quickfix with diagnostics" })

-- Return the toggle function for external use
return {
	toggle_diagnostics = toggle_diagnostics,
	is_enabled = function()
		return vim.diagnostic.is_enabled()
	end,
}

