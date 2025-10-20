return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "v0.*",
		opts = {
			keymap = {
				["<Tab>"] = { "accept", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
			},
			sources = {
				providers = {
					buffer = {
						min_keyword_length = 4,
						max_items = 5,
						score_offset = -3,
					},
					lsp = {
						max_items = 15,
						score_offset = 10,
					},
					path = {
						score_offset = 5,
					},
				},
			},
			cmdline = {
				enabled = false,
			},
			completion = {
				menu = {
					border = "rounded",
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 500,
				},
			},
		},
	},
}
