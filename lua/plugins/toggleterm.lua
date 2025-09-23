return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
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

		function _FLOAT_TOGGLE()
			float_term:toggle()
		end

		vim.keymap.set("n", "<localleader>tf", "<cmd>lua _FLOAT_TOGGLE()<CR>", { desc = "Toggle floating terminal" })
	end,
}

