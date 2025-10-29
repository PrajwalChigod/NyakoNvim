return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
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
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "storm",
			light_style = "day",
			transparent = false,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help" },
			day_brightness = 0.3,
		},
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			italic = {
				strings = false,
			},
		},
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		opts = {
			variant = "main",
			extend_background_behind_borders = true,
		},
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {},
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		opts = {},
	},

	{
		"sainnhe/everforest",
		lazy = true,
		opts = {},
	},

	{
		"shaunsingh/nord.nvim",
		lazy = true,
		config = function()
			vim.g.nord_contrast = true
			vim.g.nord_borders = false
			vim.g.nord_disable_background = false
			vim.g.nord_italic = false
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = false
		end,
	},

	{
		"loctvl842/monokai-pro.nvim",
		lazy = true,
		opts = {
			filter = "pro",
		},
	},

	{
		"vague2k/vague.nvim",
		lazy = true,
		opts = {},
	},

	{
		"zenbones-theme/zenbones.nvim",
		lazy = true,
		dependencies = { "rktjmp/lush.nvim" },
	},
}
