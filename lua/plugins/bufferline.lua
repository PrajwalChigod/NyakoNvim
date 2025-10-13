return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	keys = {
		{ "<leader>bi", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer", mode = "n" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer", mode = "n" },
		{ "<leader>bdd", "<cmd>bp|sp|bn|bd!<CR>", desc = "Delete current buffer (keep tab)" },
		{ "<leader>bdi", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		{ "<leader>bsv", "<cmd>vsplit<CR>", desc = "Split current buffer vertically" },
		{ "<leader>bsh", "<cmd>split<CR>", desc = "Split current buffer horizontally" },
		{ "<leader>bds", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete all non-active buffers" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				style_preset = require("bufferline").style_preset.default,
				themable = true,
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30,
				truncate_names = true,
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if context.buffer:current() then
						return ""
					end
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				custom_filter = function(buf_number, buf_numbers)
					if vim.bo[buf_number].filetype ~= "oil" then
						return true
					end
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
					{
						filetype = "oil",
						text = "File Manager",
						text_align = "left",
						separator = true,
					},
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,
				move_wraps_at_ends = false,
				separator_style = "thick",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				sort_by = "insert_after_current",
			},
		})
	end,
}
