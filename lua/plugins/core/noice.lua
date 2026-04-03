return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- Removed cmp override (using blink.cmp)
			},
			progress = {
				enabled = true,
				throttle = 1000 / 30, -- 30fps max for progress updates
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
				filter = {},
			},
		},
		notify = {
			enabled = true,
			view = "notify",
		},
		views = {
			notify = {
				timeout = 2000,
				fps = 30,
			},
			mini = {
				timeout = 2000,
				fps = 30,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "echo",
				},
				opts = { timeout = 2000 },
				view = "notify",
			},
			{
				filter = {
					event = "msg_show",
					kind = "echomsg",
				},
				opts = { timeout = 2000 },
				view = "notify",
			},
			{
				filter = { error = true },
				opts = { timeout = 2000 },
				view = "notify",
			},
			{
				filter = { warning = true },
				opts = { timeout = 2000 },
				view = "notify",
			},
		},
		health = {
			checker = false,
		},
	},
}
