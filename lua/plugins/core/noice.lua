return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		cmdline = {
			view = "cmdline_popup",
		},
		views = {
			cmdline_popup = {
				position = {
					row = 5,
					col = "50%",
				},
			},
		},
	},
}
