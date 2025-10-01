return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "v0.*",
		opts = {
			keymap = { preset = "default" },
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
