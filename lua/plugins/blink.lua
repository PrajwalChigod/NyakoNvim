return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "v0.*",
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "accept", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "buffer" },
				providers = {
					buffer = {
						min_keyword_length = 3,
					},
				},
			},
			cmdline = {
				enabled = false,
			},
			completion = {
				trigger = {
					show_on_keyword = true,
				},
				menu = {
					border = "rounded",
					auto_show = true,
				},
				list = {
					selection = {
						preselect = true, -- auto-select first item
						auto_insert = true, -- insert preview on selection
					},
				},
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				documentation = {
					auto_show = false,
				},
				ghost_text = {
					enabled = false,
				},
			},
		},
	},
}
