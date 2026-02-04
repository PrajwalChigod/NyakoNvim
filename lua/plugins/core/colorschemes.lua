return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
        term_colors = true,
				compile = {
					enabled = true,
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
				color_overrides = {
					macchiato = {
						base = "#000000",
						mantle = "#181825",
						crust = "#11111b",
					},
				},
				custom_highlights = function(colors)
					return {
						String = { fg = colors.teal },
						["@string"] = { fg = colors.teal },
						Comment = { fg = colors.overlay0, style = { "italic" } },
						["@comment"] = { fg = colors.overlay0, style = { "italic" } },
					}
				end,
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
		"vague2k/vague.nvim",
		lazy = true,
		opts = {},
	},
	{
		"slugbyte/lackluster.nvim",
		lazy = true,
		opts = {},
	},
}
