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
		{ "<leader>ap", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
		{ "<leader>an", "<cmd>AerialNext<cr>", desc = "Next symbol" },
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown" },

		layout = {
			default_direction = "prefer_right",
			placement = "edge",
			resize_to_content = true,
		},

		disable_max_lines = 5000,
		disable_max_size = 1000000, -- 1MB

		highlight_closest = true,
		highlight_on_hover = false,
		highlight_on_jump = 300,

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

		float = {
			border = "rounded",
			relative = "win",
			max_height = 0.9,
			min_height = { 8, 0.1 },
		},

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

		update_events = "InsertLeave,BufWritePost",
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
