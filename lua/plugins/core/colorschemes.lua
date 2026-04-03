return {
	{
		"PrajwalChigod/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "tora",
			background = {
				dark = "tora",
				light = "lotus",
			},
			compile = false,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				term_colors = true,
				compile = {
					enabled = false,
					path = vim.fn.stdpath("cache") .. "/catppuccin",
					suffix = "_compiled",
				},
				background = {
					light = "latte",
					dark = "macchiato",
				},
				dim_inactive = {
					enabled = false,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				integrations = {
					cmp = false,
					mini = {
						indentscope_color = "",
					},
				},
			})
		end,
	},
	{
		"slugbyte/lackluster.nvim",
		lazy = true,
		opts = {},
	},
}
