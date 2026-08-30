return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{
			"<localleader>rm",
			"<cmd>RenderMarkdown toggle<cr>",
			ft = "markdown",
			desc = "Toggle Markdown Rendering",
		},
	},
	opts = {
		-- Off by default: buffers open with plain markdown, rendering is
		-- opt-in via <localleader>rm.
		enabled = false,
		-- Keep rendering on the cursor line / active node instead of
		-- reverting to raw markdown while navigating.
		anti_conceal = { enabled = false },
	},
}
