local terminals = {}

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{
			"<localleader>tb",
			function()
				vim.cmd("term")
			end,
			desc = "Toggle terminal buffer",
		},
		{
			"<localleader>tf",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				terminals.float = terminals.float or Terminal:new({ direction = "float", float_opts = { border = "curved" } })
				terminals.float:toggle()
			end,
			desc = "Toggle floating terminal",
		},
		{
			"<localleader>th",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				terminals.horizontal = terminals.horizontal or Terminal:new({ direction = "horizontal" })
				terminals.horizontal:toggle()
			end,
			desc = "Toggle horizontal terminal",
		},
		{
			"<localleader>tv",
			function()
				vim.cmd("ToggleTerm size=80 direction=vertical")
			end,
			desc = "Toggle vertical terminal",
		},
		{
			"<localleader>tt",
			function()
			vim.cmd("ToggleTerm direction=tab")
			end,
			desc = "Toggle tab terminal",
		},
	},
	opts = {
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = false,
		terminal_mappings = true,
		persist_size = false,
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
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
	end,
}
