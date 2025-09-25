return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 250
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "classic",
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
		})

		wk.add({
			-- ===============================================
			-- G-PREFIX KEYMAPS (LSP, Formatting, Linting)
			-- ===============================================

			-- LSP Navigation & Actions
			{ "gd", desc = "Go to Definition (fzf)" },
			{ "gD", desc = "Go to Declaration (fzf)" },
			{ "gr", group = "LSP References/Actions", icon = " " },
			{ "grr", desc = "References (fzf)" },
			{ "gra", desc = "Code Actions (fzf)" },
			{ "grn", desc = "Rename Symbol" },
			{ "gri", desc = "Implementations (fzf)" },
			{ "grt", desc = "Type Definitions (fzf)" },
			{ "gS", desc = "Document Symbols (fzf)" },
			{ "gW", desc = "Workspace Symbols (fzf)" },
			{ "gs", desc = "Signature Help" },
			{ "K", desc = "Hover Documentation" },

			-- Formatting Operations
			{ "gf", desc = "Format (file/range)" },

			-- Linting Operations
			{ "gl", desc = "Run linter" },

			-- ===============================================
			-- LEADER KEYMAPS
			-- ===============================================

			-- File & Navigation Operations
			{ "<leader>e", desc = "Open file explorer (Oil)" },
			{ "<leader>nh", desc = "Clear search highlights" },

			-- Tab Operations
			{ "<leader>t", group = "Tabs" },
			{ "<leader>tt", desc = "New tab" },
			{ "<leader>tf", desc = "New tab with file picker" },
			{ "<leader>tx", desc = "Close current tab" },
			{ "<leader>tb", desc = "Open buffer in new tab" },

			-- Debug Operations
			{ "<leader>d", group = "Debug" },
			{ "<leader>db", desc = "Toggle breakpoint" },
			{ "<leader>dB", desc = "Set conditional breakpoint" },
			{ "<leader>dc", desc = "Continue" },
			{ "<leader>di", desc = "Step into" },
			{ "<leader>do", desc = "Step over" },
			{ "<leader>dO", desc = "Step out" },
			{ "<leader>dr", desc = "Run/Start debugging" },
			{ "<leader>dt", desc = "Terminate debug session" },
			{ "<leader>du", desc = "Toggle DAP UI" },
			{ "<leader>de", desc = "Evaluate expression" },

			-- Diagnostics Operations
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>xt", desc = "Toggle diagnostics (enable/disable)" },
			{ "<leader>xn", desc = "Next diagnostic" },
			{ "<leader>xp", desc = "Previous diagnostic" },
			{ "<leader>xf", desc = "Open diagnostic float" },
			{ "<leader>xl", desc = "Set loclist with diagnostics" },
			{ "<leader>xq", desc = "Set quickfix with diagnostics" },

			-- Git Operations
			{ "<leader>g", group = "Git" },
			{ "<leader>gs", desc = "Stage Hunk" },
			{ "<leader>gr", desc = "Reset Hunk" },
			{ "<leader>gp", desc = "Preview Hunk" },
			{ "<leader>gb", desc = "Blame Line" },
			{ "<leader>gd", desc = "Diff This" },
			{ "<leader>gS", desc = "Stage Buffer" },
			{ "<leader>gR", desc = "Reset Buffer" },
			{ "<leader>gu", desc = "Undo Stage Hunk" },
			{ "<leader>gD", desc = "Diff This ~" },
			{ "<leader>gt", desc = "Toggle Signs" },
			{ "<leader>glb", desc = "Toggle Line Blame" },
			{ "<leader>gld", desc = "Toggle Deleted" },

			-- ===============================================
			-- LOCALLEADER KEYMAPS
			-- ===============================================

			-- Swap/Rearrange Operations (Treesitter)
			{ "<localleader>s", group = "Swap" },
			{ "<localleader>sp", desc = "Swap next parameter" },
			{ "<localleader>sP", desc = "Swap previous parameter" },
			{ "<localleader>sf", desc = "Swap next function" },
			{ "<localleader>sF", desc = "Swap previous function" },

			-- Terminal Operations
			{ "<localleader>t", group = "Terminal" },
			{ "<localleader>tf", desc = "Toggle floating terminal" },
			{ "<localleader>th", desc = "Toggle horizontal terminal" },
			{ "<localleader>tv", desc = "Toggle vertical terminal" },

			-- Buffer Management
			{ "<localleader>b", group = "Buffer" },
			{ "<localleader>bd", desc = "Delete Current Buffer" },
			{ "<localleader>bo", desc = "Delete Other Buffers" },
			{ "<localleader>bi", desc = "Toggle Pin" },
			{ "<localleader>bI", desc = "Delete Non-pinned Buffers" },
		})
	end,
}
