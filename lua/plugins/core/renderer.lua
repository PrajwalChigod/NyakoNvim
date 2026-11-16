-- renderer.nvim: render markdown, HTML and CSV/TSV/PSV inside buffers (treesitter + extmarks).
-- Replaces render-markdown.nvim (markdown.lua was removed).
-- <localleader>rm toggles rendering in markdown, html, csv, tsv and psv buffers (off by default).
-- csv, tsv and psv need their parsers: :TSInstall csv tsv psv

return {
	"PrajwalChigod/renderer.nvim",
	ft = { "markdown", "html", "csv", "tsv", "psv" },
	cmd = "Renderer",
	init = function()
		-- neovim does not detect .psv by default
		vim.filetype.add({ extension = { psv = "psv" } })
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{
			"<localleader>rm",
			"<cmd>Renderer toggle<cr>",
			ft = { "markdown", "html", "csv", "tsv", "psv" },
			desc = "Toggle Rendering",
		},
	},
	opts = {
		-- Off by default: buffers open with plain markdown, rendering is
		-- opt-in via <localleader>rm.
		enabled = false,
		file_types = { "markdown", "html", "csv", "tsv", "psv" },
		-- Keep rendering on the cursor line / active node instead of
		-- reverting to raw markdown while navigating.
		anti_conceal = { enabled = false },
		-- Show a mermaid block's source under the cursor so it can be edited,
		-- even though anti_conceal is off. Needs mermaid-ascii on PATH.
		mermaid = { always_reveal = true },
	},
	config = function(_, opts)
		require("renderer").setup(opts)
	end,
}
