return {
	{
		"nvim-mini/mini-git",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "Git" },
		config = function()
			local git = require("mini.git")

			git.setup()

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc })
			end

			map("n", "<leader>gb", function()
				local line = vim.api.nvim_win_get_cursor(0)[1]
				vim.cmd(("vertical Git blame -L %d,+1 -- %%"):format(line))
			end, "Blame Line")
			map("n", "<leader>gd", "<cmd>vertical Git diff -- %<CR>", "Diff This")
			map("n", "<leader>gD", "<cmd>vertical Git diff HEAD~ -- %<CR>", "Diff This ~")
			map("n", "<leader>glb", "<cmd>vertical Git blame -- %<CR>", "Blame Buffer")
		end,
	},
}
