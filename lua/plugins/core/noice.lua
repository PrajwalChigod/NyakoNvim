return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	keys = {
		{ "<localleader>nd", "<cmd>Noice dismiss<CR>", desc = "Noice: dismiss visible messages" },
	},
	config = function()
		vim.schedule(function()
			require("noice").setup({
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
			})
		end)
	end,
}
