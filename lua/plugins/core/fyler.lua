return {
	"A7Lavinraj/fyler.nvim",
	branch = "stable",
	cmd = "Fyler",
	keys = {
		{
			"-",
			function()
				-- fyler defaults root_path to getcwd(-1, -1), the GLOBAL cwd, which ignores
				-- :tcd. Pass the effective (tab/window-aware) cwd explicitly so fyler opens
				-- rooted at whichever project/worktree the current tab is scoped to.
				require("fyler").open({ kind = "split_left_most", root_path = vim.fn.getcwd() })
			end,
			desc = "Open fyler at the current file",
		},
		{
			"_",
			function()
				require("fyler").open({ kind = "floating", root_path = vim.fn.getcwd() })
			end,
			desc = "Open fyler in floating window",
		},
	},
	opts = {
		extensions = {
			git = { enabled = true },
		},
	},
}
