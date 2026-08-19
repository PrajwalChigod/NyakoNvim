return {
	{
		"nvim-mini/mini.diff",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "▎", change = "▎", delete = "▁" },
				},
				-- Default `apply`/`reset` are "gh"/"gH", which collide with the
				-- LSP hover keymap (also "gh") set in lsp.lua. Moved to
				-- <leader>gs / <leader>gr to match the existing "Stage hunk" /
				-- "Reset hunk" labels already documented in which-key.lua.
				mappings = {
					apply = "<leader>gs",
					reset = "<leader>gr",
				},
			})
			-- Defaults (unchanged): ]h / [h jump to next/prev changed hunk,
			-- ]H / [H jump to last/first hunk in the buffer.
		end,
	},
}
