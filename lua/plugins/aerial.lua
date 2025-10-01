return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	keys = {
		{ "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial outline" },
		{ "<leader>aA", "<cmd>AerialNavToggle<cr>", desc = "Toggle Aerial nav window" },
		{ "[s", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
		{ "]s", "<cmd>AerialNext<cr>", desc = "Next symbol" },
	},
	opts = {
		-- Use treesitter first, fallback to LSP
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

		-- How to open aerial window
		layout = {
			-- Options: "prefer_right", "prefer_left", "right", "left", "float"
			default_direction = "prefer_right",
			placement = "edge", -- "edge" or "window"
			resize_to_content = false, -- Set to false to use width setting
			preserve_equality = false,
			width = 0.3, -- 30% of screen width
		},

		-- Keymaps in aerial window
		keymaps = {
			["?"] = "actions.show_help",
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			["<C-s>"] = "actions.jump_split",
			["p"] = "actions.scroll",
			["<C-j>"] = "actions.down_and_scroll",
			["<C-k>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			["[["] = "actions.prev_up",
			["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["za"] = "actions.tree_toggle",
			["O"] = "actions.tree_toggle_recursive",
			["zA"] = "actions.tree_toggle_recursive",
			["l"] = "actions.tree_open",
			["zo"] = "actions.tree_open",
			["L"] = "actions.tree_open_recursive",
			["zO"] = "actions.tree_open_recursive",
			["h"] = "actions.tree_close",
			["zc"] = "actions.tree_close",
			["H"] = "actions.tree_close_recursive",
			["zC"] = "actions.tree_close_recursive",
			["zr"] = "actions.tree_increase_fold_level",
			["zR"] = "actions.tree_open_all",
			["zm"] = "actions.tree_decrease_fold_level",
			["zM"] = "actions.tree_close_all",
			["zx"] = "actions.tree_sync_folds",
			["zX"] = "actions.tree_sync_folds",
		},

		-- Disable aerial on files with this many lines
		disable_max_lines = 10000,
		disable_max_size = 2000000, -- 2MB

		-- Use nerdfont icons
		icons = {},

		-- Highlight the closest symbol
		highlight_closest = true,
		highlight_on_hover = true,

		-- Highlight the symbol in the source buffer when cursor is in the aerial window
		highlight_on_jump = 300,

		-- Show box drawing characters for the tree hierarchy
		show_guides = true,

		-- Filtering options
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},

		-- Customize the characters used when show_guides = true
		guides = {
			mid_item = "├─",
			last_item = "└─",
			nested_top = "│ ",
			whitespace = "  ",
		},

		-- Options for opening aerial in a floating window
		float = {
			border = "rounded",
			relative = "win",
			max_height = 0.9,
			height = nil,
			min_height = { 8, 0.1 },
		},

		-- Options for the floating nav windows
		nav = {
			border = "rounded",
			max_height = 0.9,
			min_height = { 10, 0.1 },
			max_width = 0.5,
			min_width = { 0.2, 20 },
			win_opts = {
				cursorline = true,
				winblend = 10,
			},
		},

		-- Enable automatic update when cursor moves
		update_events = "TextChanged,InsertLeave",

		-- Automatically open aerial when entering supported buffers
		-- You can customize this per-filetype in after/ftplugin/*.lua
		on_attach = function(bufnr)
			-- Optional: Auto-open aerial for certain filetypes
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = { "python", "rust", "go", "typescript", "javascript" },
			-- 	callback = function()
			-- 		require("aerial").open()
			-- 	end,
			-- })
		end,

		-- Use symbol tree for fzf-lua integration
		manage_folds = false,

		-- Integration with other plugins
		-- Links the aerial window with the source window
		link_tree_to_folds = true,
		link_folds_to_tree = false,

		-- Set to false to not open aerial window automatically when calling aerial.open()
		-- or aerial.toggle()
		open_automatic = false,

		-- Post parse symbol callback
		post_parse_symbol = function(bufnr, item, ctx)
			return true
		end,

		-- Post add all symbols callback
		post_add_all_symbols = function(bufnr, items, ctx)
			return items
		end,

		-- Call this function when aerial attaches to a buffer
		on_first_symbols = function(bufnr)
			-- Example: Auto-open for large files
			-- local line_count = vim.api.nvim_buf_line_count(bufnr)
			-- if line_count > 300 then
			-- 	require("aerial").open()
			-- end
		end,

		-- Fold code based on aerial's tree
		close_behavior = "auto", -- "auto", "persist", "close"

		-- Set to true to ignore aerial's suggestions when closing windows
		ignore_aerial = false,
	},
	config = function(_, opts)
		require("aerial").setup(opts)

		-- Integration with fzf-lua
		local has_fzf = pcall(require, "fzf-lua")
		if has_fzf then
			-- Add custom fzf-lua aerial picker
			vim.keymap.set("n", "<leader>fa", function()
				require("fzf-lua").lsp_document_symbols()
			end, { desc = "Aerial symbols (fzf)" })

			-- Workspace symbols
			vim.keymap.set("n", "<leader>fA", function()
				require("fzf-lua").lsp_workspace_symbols()
			end, { desc = "Aerial workspace symbols (fzf)" })
		end
	end,
}
