return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<localleader>t]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- Terminal keymaps
		local Terminal = require("toggleterm.terminal").Terminal

		-- Floating terminal
		local float_term = Terminal:new({
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})

		-- Horizontal terminal
		local horizontal_term = Terminal:new({
			direction = "horizontal",
		})

		-- Vertical terminal
		local vertical_term = Terminal:new({
			direction = "vertical",
		})

		-- Tab terminal
		local tab_term = Terminal:new({
			direction = "tab",
		})

		function _FLOAT_TOGGLE()
			float_term:toggle()
		end

		function _HORIZONTAL_TOGGLE()
			horizontal_term:toggle()
		end

		function _VERTICAL_TOGGLE()
			vertical_term:toggle()
		end

		function _TAB_TOGGLE()
			tab_term:toggle()
		end

		vim.keymap.set("n", "<localleader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
		vim.keymap.set("n", "<localleader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
		vim.keymap.set("n", "<localleader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "Toggle vertical terminal" })
		vim.keymap.set("n", "<localleader>tt", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Toggle tab terminal" })
	end,
}

