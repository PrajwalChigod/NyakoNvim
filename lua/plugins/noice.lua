return {
	"folke/noice.nvim",
	event = { "CmdlineEnter", "VimEnter" },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = {},
				},
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
				kind_icons = {},
			},
			redirect = {
				view = "popup",
				filter = { event = "msg_show" },
			},
			commands = {
				history = {
					view = "split",
					opts = { enter = true, format = "details" },
					-- Remove filter to show ALL messages
					filter = {},
				},
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			views = {
				notify = {
					timeout = 1500, -- 1.5 seconds for regular notifications
				},
				mini = {
					timeout = 1500, -- 1.5 seconds for mini view
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "echo",
					},
					opts = { timeout = 1500 },
					view = "notify",
				},
				{
					filter = {
						event = "msg_show",
						kind = "echomsg",
					},
					opts = { timeout = 1500 },
					view = "notify",
				},
				{
					filter = { error = true },
					opts = { timeout = 1500 }, -- 1.5 seconds for errors
					view = "notify",
				},
				{
					filter = { warning = true },
					opts = { timeout = 1500 }, -- 1.5 seconds for warnings
					view = "notify",
				},
			},
			health = {
				checker = false,
			},
		})
	end,
}
