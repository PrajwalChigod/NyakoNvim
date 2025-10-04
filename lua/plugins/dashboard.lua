return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	cond = function()
		-- Only load dashboard if nvim was opened without arguments
		return vim.fn.argc() == 0
	end,
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					"",
					"",
					"",
					" ███╗   ██╗ ███████╗ ██╗  ██╗  ██████╗  ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝ ██║ ██╔╝ ██╔═══██╗ ████╗  ██║ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗   █████╔╝  ██║   ██║ ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝   ██╔═██╗  ██║   ██║ ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗ ██║  ██╗ ╚██████╔╝ ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═╝  ╚═╝  ╚═════╝  ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"",
					"",
				},
				center = {
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Find File           ",
						desc_hl = "String",
						key = "f",
						key_hl = "Number",
						action = "lua require('fzf-lua').files()",
					},
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Recent Files        ",
						desc_hl = "String",
						key = "r",
						key_hl = "Number",
						action = "lua require('fzf-lua').oldfiles()",
					},
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Find Text           ",
						desc_hl = "String",
						key = "g",
						key_hl = "Number",
						action = "lua require('fzf-lua').live_grep()",
					},
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Restore Session     ",
						desc_hl = "String",
						key = "s",
						key_hl = "Number",
						action = "lua require('persistence').load()",
					},
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Config              ",
						desc_hl = "String",
						key = "c",
						key_hl = "Number",
						action = "lua vim.cmd('cd ~/.config/nvim') require('fzf-lua').files({ cwd = '~/.config/nvim' })",
					},
					{
						icon = "  ",
						icon_hl = "Title",
						desc = "Quit                ",
						desc_hl = "String",
						key = "q",
						key_hl = "Number",
						action = "qa",
					},
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"⚡ NekoVim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
					}
				end,
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}