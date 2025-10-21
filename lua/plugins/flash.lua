return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				config = function(opts)
					opts.autohide = opts.autohide or (vim.fn.mode(true):find("o") and vim.v.operator == "y")
					opts.jump_labels = opts.jump_labels
						and vim.v.count == 0
						and vim.fn.reg_executing() == ""
						and vim.fn.reg_recording() == ""
					opts.jump_labels = vim.fn.mode(true):find("o")
				end,
				label = { exclude = "hjkliardc" },
				search = { wrap = false },
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
	},
}