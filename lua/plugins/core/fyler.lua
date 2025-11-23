return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	branch = "stable",
	cmd = "Fyler",
	event = "VeryLazy",
	keys = {
		{
			"-",
			function()
				require("fyler").open({ kind = "split_left_most" })
			end,
			desc = "Open fyler at the current file",
		},
		{
			"_",
			function()
				require("fyler").open({ kind = "float" })
			end,
			desc = "Open fyler in floating window",
		},
	},
	opts = {},
}
