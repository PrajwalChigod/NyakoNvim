-- lua/plugins/catppuccin.lua
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
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
				mocha = {
					base = "#11111b", -- This sets the background to crust color
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
		})

		-- Setup the colorscheme here
		vim.cmd.colorscheme("catppuccin")
	end,
}
