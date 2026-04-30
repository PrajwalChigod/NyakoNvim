return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>gg",
				function()
					vim.cmd("LazyGit")
				end,
				desc = "Open LazyGit",
			},
		},
	},
}
