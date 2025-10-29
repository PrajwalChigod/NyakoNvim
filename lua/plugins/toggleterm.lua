local terminals = {}

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{
			"<localleader>t",
			function()
				vim.cmd("term")
			end,
			desc = "Toggle last terminal",
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
				local Terminal = require("toggleterm.terminal").Terminal
				terminals.vertical = terminals.vertical or Terminal:new({ direction = "vertical", size = 60 })
				terminals.vertical:toggle()
			end,
			desc = "Toggle vertical terminal",
		},
		{
			"<localleader>tt",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				terminals.tab = terminals.tab or Terminal:new({ direction = "tab" })
				terminals.tab:toggle()
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
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
	end,
}
