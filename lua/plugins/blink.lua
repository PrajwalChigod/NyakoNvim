return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		version = "v0.*",
		config = function()
			-- Set up toggle keymaps separately
			vim.keymap.set("i", "<C-c>", function()
				require("blink.cmp").enable()
				require("blink.cmp").show()
				vim.notify("Completion enabled", vim.log.levels.INFO)
			end, { desc = "Enable completion" })

			vim.keymap.set("i", "<C-x>", function()
				require("blink.cmp").hide()
				require("blink.cmp").disable()
				vim.notify("Completion disabled", vim.log.levels.INFO)
			end, { desc = "Disable completion" })
		end,
		opts = {
			keymap = {
				preset = "none",
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-f>"] = { "scroll_documentation_up", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono"
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
					},
				},
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
					show_on_keyword = false,
					show_on_trigger_character = false,
				},
				documentation = {
					auto_show = false,
					window = {
						border = "rounded",
					},
				},
				menu = {
					auto_show = false,
					border = "rounded",
					draw = {
						treesitter = { "lsp" },
					},
				},
				ghost_text = {
					enabled = false,
				},
			},
			signature = {
				enabled = true,
				trigger = {
					blocked_trigger_characters = {},
					blocked_retrigger_characters = {},
					show_on_insert_on_trigger_character = false,
				},
				window = {
					border = "rounded",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
