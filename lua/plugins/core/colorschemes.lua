return {
	{
		"PrajwalChigod/kanagawa.nvim",
		lazy = true,
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
		"PrajwalChigod/catppuccin",
		name = "catppuccin",
		lazy = true,
		config = function()
			require("catppuccin").setup({
				flavour = "espresso",
				term_colors = true,
				background = {
					light = "latte",
					dark = "espresso",
				},
				dim_inactive = {
					enabled = true,
					shade = "light",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				lsp_styles = {
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
						ok = { "undercurl" },
					},
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
