return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Pin/unpin buffer" },
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer", mode = "n" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer", mode = "n" },
		{ "<leader>bd", "<cmd>bp|sp|bn|bd!<CR>", desc = "Delete current buffer" },
		{ "<leader>bx", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
	},
	config = function()
		local COLORSCHEME_REFRESH_DELAY = 100 -- Wait for colorscheme to fully reload
		require("bufferline").setup({
			options = {
				themable = true,
				indicator = {
					icon = "▎",
					style = "icon",
				},
				max_name_length = 20,
				max_prefix_length = 20,
				tab_size = 12,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if context.buffer:current() then
						return ""
					end
					return count > 0 and " " .. count or ""
				end,
				custom_filter = function(buf_number)
					return vim.bo[buf_number].filetype ~= "fyler"
				end,
				offsets = {
					{
						filetype = "fyler",
						text = "Fyler",
						text_align = "left",
						separator = true,
					},
				},
				show_duplicate_prefix = false,
				separator_style = "thick",
				hover = {
					enabled = true,
					delay = 300,
					reveal = { "close" },
				},
				sort_by = "insert_after_current",
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("BufferlineColorschemeRefresh", { clear = true }),
			pattern = "*",
			callback = function()
				vim.defer_fn(function()
					pcall(vim.cmd, "redrawtabline")
				end, COLORSCHEME_REFRESH_DELAY)
			end,
		})
	end,
}
