return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	branch = "stable",
	cmd = "Fyler",
	keys = {
		{
			"-",
			"<Cmd>Fyler kind=split_left_most<CR>",
			desc = "Open fyler at the current file",
		},
		{
			"_",
			"<Cmd>Fyler kind=float<CR>",
			desc = "Open fyler in floating window",
		},
	},
	opts = {},
}
