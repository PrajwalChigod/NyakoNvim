-- ============================================================================
-- Diagnostics Configuration for Neovim 0.11
-- Diagnostics are DISABLED by default and must be explicitly enabled
-- ============================================================================

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = {
		enabled = false,
		source = "if_many",
		prefix = "●",
	},
	float = {
		enabled = false,
		source = "if_many",
		border = "rounded",
	},
	signs = {
		enabled = false,
	},
	underline = {
		enabled = false,
	},
	update_in_insert = false,
	severity_sort = true,
})

-- Diagnostic signs (modern approach)
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

-- Track diagnostics state
local diagnostics_enabled = false

-- Disable diagnostics globally on startup
vim.diagnostic.config({
	virtual_text = false,
	float = { enabled = false },
	signs = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
})

-- Toggle diagnostics function
local function toggle_diagnostics()
	if diagnostics_enabled then
		-- Disable diagnostics
		vim.diagnostic.config({
			virtual_text = false,
			float = { enabled = false },
			signs = false,
			underline = false,
			update_in_insert = false,
			severity_sort = true,
		})
		diagnostics_enabled = false
		vim.notify("Diagnostics disabled", vim.log.levels.INFO)
	else
		-- Enable diagnostics
		vim.diagnostic.config({
			virtual_text = {
				enabled = true,
				source = "if_many",
				prefix = "●",
			},
			float = {
				enabled = true,
				source = "if_many",
				border = "rounded",
			},
			signs = {
				enabled = true,
			},
			underline = {
				enabled = true,
			},
			update_in_insert = false,
			severity_sort = true,
		})
		diagnostics_enabled = true
		vim.notify("Diagnostics enabled", vim.log.levels.INFO)
	end
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
		return diagnostics_enabled
	end,
}

