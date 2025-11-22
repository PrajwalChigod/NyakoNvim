return {
	"mikavilpas/yazi.nvim",
	cmd = "Yazi",
	event = "VeryLazy",
	keys = {
		{
			"-",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"~",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi in current working directory",
		},
	},
	opts = {
		open_for_directories = false,
		keymaps = {
			show_help = "?",
		},
	},
}
