return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Delay in milliseconds to wait for colorscheme to fully load before refreshing UI
		local COLORSCHEME_REFRESH_DELAY = 100
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true, -- Single statusline = better performance
				refresh = {
					statusline = 2000, -- Reduce refresh frequency for better performance
					tabline = 2000,
					winbar = 2000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" }, -- Removed diagnostics (shown in signs)
				lualine_c = { { "filename", path = 2 } },
				lualine_x = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"filetype" -- Removed fileformat (rarely needed)
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("LualineColorschemeRefresh", { clear = true }),
			pattern = "*",
			callback = function()
				vim.defer_fn(function()
					pcall(vim.cmd, "redrawstatus")
				end, COLORSCHEME_REFRESH_DELAY)
			end,
		})
	end,
}

