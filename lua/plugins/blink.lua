return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "v0.*",
		opts = function()
			-- Check if current buffer is large (>50KB)
			local function is_large_file()
				local buf = vim.api.nvim_get_current_buf()
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > 50 * 1024 then
					return true
				end
				return false
			end

			return {
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
				default = { "lsp", "path", "buffer", "snippets" },
				providers = {
					buffer = {
						max_items = 4, -- Limit buffer completions
						min_keyword_length = 3, -- Require at least 3 characters
						score_offset = -3, -- Deprioritize buffer vs LSP
					},
				},
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
					enabled = not is_large_file(), -- Disable for large files to prevent lag
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			}
		end,
	},
}
