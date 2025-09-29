return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "v0.*",
		opts = {
			keymap = {
				preset = "default",
				["<C-Space>"] = { "accept", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono"
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				menu = {
					border = "rounded",
				},
				ghost_text = {
					enabled = true,
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
		},
	},
}
