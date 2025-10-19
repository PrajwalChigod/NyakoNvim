return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "macchiato",
			background = {
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {
				macchiato = {
					base = "#000000", -- This sets the background to black
					mantle = "#181825",
					crust = "#11111b",
				},
			},
			custom_highlights = function(colors)
				return {
					-- String literals (text within quotes)
					String = { fg = colors.teal }, -- Change this to any color you like
					["@string"] = { fg = colors.teal }, -- Treesitter version
					-- Comments
					Comment = { fg = colors.overlay0, style = { "italic" } }, -- Change color here
					["@comment"] = { fg = colors.overlay0, style = { "italic" } }, -- Treesitter version
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				bufferline = true,
				-- For more integrations: https://github.com/catppuccin/nvim#integrations
			},
		},
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 999,
		opts = {
			style = "storm", -- storm, moon, night, day
			light_style = "day",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help" },
			day_brightness = 0.3,
			hide_inactive_statusline = false,
			dim_inactive = false,
			lualine_bold = false,
		},
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 999,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		priority = 999,
		opts = {
			variant = "main", -- auto, main, moon, or dawn
			dark_variant = "main",
			dim_inactive_windows = false,
			extend_background_behind_borders = true,
			enable = {
				terminal = true,
				legacy_highlights = true,
				migrations = true,
			},
			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		},
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 999,
		opts = {
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			theme = "wave", -- wave, dragon, lotus
			background = {
				dark = "wave",
				light = "lotus",
			},
		},
	},

	{
		"navarasu/onedark.nvim",
		lazy = true, -- Load on-demand
		priority = 999,
		opts = {
			style = "dark", -- dark, darker, cool, deep, warm, warmer, light
			transparent = false,
			term_colors = true,
			ending_tildes = false,
			cmp_itemkind_reverse = false,
			toggle_style_key = nil,
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
			lualine = {
				transparent = false,
			},
			colors = {},
			highlights = {},
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		},
	},
}
