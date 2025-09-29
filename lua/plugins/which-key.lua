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
			-- NORMAL MODE KEYMAPS
			-- ===============================================

			-- ===============================================
			-- LSP & DEVELOPMENT (g* prefix)
			-- ===============================================

			-- LSP Navigation
			{ "gd", desc = "Go to Definition (fzf)" },
			{ "gD", desc = "Go to Declaration (fzf)" },
			{ "gS", desc = "Document Symbols (fzf)" },
			{ "gW", desc = "Workspace Symbols (fzf)" },

			-- LSP References & Actions (gr* group)
			{ "gr", group = "LSP References/Actions" },
			{ "grr", desc = "References (fzf)" },
			{ "gra", desc = "Code Actions (fzf)" },
			{ "grn", desc = "Rename Symbol" },
			{ "gri", desc = "Implementations (fzf)" },
			{ "grt", desc = "Type Definitions (fzf)" },

			-- LSP Information
			{ "K", desc = "Hover Documentation" },
			{ "gs", desc = "Signature Help" },

			-- Code Tools
			{ "gf", desc = "Format (file/range)" },
			{ "gl", desc = "Run linter" },

			-- Comment Operations (gc* group)
			{ "gc", group = "Comment Operations" },
			{ "gcc", desc = "Toggle line comment" },
			{ "gcf", desc = "Comment function" },
			{ "gbc", desc = "Toggle block comment" },
			{ "gcO", desc = "Add comment above" },
			{ "gco", desc = "Add comment below" },
			{ "gcA", desc = "Add comment at end of line" },

			-- ===============================================
			-- NAVIGATION & MOVEMENT
			-- ===============================================

			-- Flash Navigation
			{ "s", desc = "Flash jump", mode = { "n", "x", "o" } },
			{ "S", desc = "Flash treesitter", mode = { "n", "x", "o" } },
			{ "r", desc = "Remote flash", mode = "o" },
			{ "R", desc = "Treesitter search", mode = { "o", "x" } },

			-- Window Navigation
			{ "<C-h>", desc = "Go to left split" },
			{ "<C-j>", desc = "Go to bottom split" },
			{ "<C-k>", desc = "Go to top split" },
			{ "<C-l>", desc = "Go to right split" },

			-- Enhanced Movement
			{ "n", desc = "Next search result (centered)" },
			{ "N", desc = "Previous search result (centered)" },
			{ "<C-d>", desc = "Page down (centered)" },
			{ "<C-u>", desc = "Page up (centered)" },
			{ "J", desc = "Join lines (keep cursor position)" },

			-- File Explorer
			{ "-", desc = "Open parent directory (Oil)" },

			-- ===============================================
			-- TEXT OBJECTS
			-- ===============================================
			{ "ih", desc = "Select git hunk", mode = { "o", "x" } },

			-- ===============================================
			-- TREESITTER SELECTIONS
			-- ===============================================
			{ "<C-space>", desc = "Init/Increment selection" },
			{ "<C-S-space>", desc = "Scope incremental" },
			{ "<M-space>", desc = "Node decremental" },

			-- ===============================================
			-- VISUAL MODE KEYMAPS
			-- ===============================================
			-- Movement & Editing
			{ "J", desc = "Move line down", mode = "v" },
			{ "K", desc = "Move line up", mode = "v" },
			{ "<", desc = "Indent left", mode = "v" },
			{ ">", desc = "Indent right", mode = "v" },

			-- Comments
			{ "gc", desc = "Comment selection", mode = "v" },
			{ "gb", desc = "Block comment selection", mode = "v" },

			-- Treesitter (visual mode)
			{ "<C-space>", desc = "Increment selection", mode = "v" },
			{ "<C-S-space>", desc = "Scope incremental", mode = "v" },
			{ "<M-space>", desc = "Node decremental", mode = "v" },


			-- ===============================================
			-- INSERT MODE KEYMAPS
			-- ===============================================

			-- Mode Switch
			{ "jj", desc = "Exit insert mode", mode = "i" },

			-- LSP Actions (<C-g>* group)
			{ "<C-g>K", desc = "Hover Documentation", mode = "i" },
			{ "<C-g>s", desc = "Signature Help", mode = "i" },
			{ "<C-g>f", desc = "Format File", mode = "i" },
			{ "<C-g>l", desc = "Run Linter", mode = "i" },

			-- Surround (<C-s>* group)
			{ "<C-s>s", desc = "Surround selection", mode = "i" },
			{ "<C-s>S", desc = "Surround line", mode = "i" },

			-- Completion (Blink.cmp)
			{ "<C-n>", desc = "Next completion item", mode = "i" },
			{ "<C-p>", desc = "Previous completion item", mode = "i" },
			{ "<C-d>", desc = "Scroll documentation down", mode = "i" },
			{ "<C-f>", desc = "Scroll documentation up", mode = "i" },
			{ "<CR>", desc = "Accept completion", mode = "i" },
			{ "<C-Space>", desc = "Accept completion", mode = "i" },
			{ "<Tab>", desc = "Next snippet/completion", mode = "i" },
			{ "<S-Tab>", desc = "Previous snippet/completion", mode = "i" },

			-- ===============================================
			-- COMMAND MODE KEYMAPS
			-- ===============================================

			-- Flash in command mode
			{ "<c-s>", desc = "Toggle flash search", mode = "c" },

			-- ===============================================
			-- TERMINAL MODE KEYMAPS
			-- ===============================================

			{ "<Esc>", desc = "Exit terminal mode", mode = "t" },

			-- ===============================================
			-- LEADER KEYMAPS
			-- ===============================================

			-- File & Navigation
			{ "<leader>e", desc = "Open file explorer (Oil)" },

			-- FZF Find Operations
			{ "<leader>f", group = "Fzf Find" },

			-- Tab Management
			{ "<leader>t", group = "Tabs" },
			{ "<leader>tt", desc = "New tab" },
			{ "<leader>tf", desc = "New tab with file picker" },
			{ "<leader>tx", desc = "Close current tab" },
			{ "<leader>tb", desc = "Open buffer in new tab" },

			-- Buffer Management
			{ "<leader>b", group = "Buffer" },
			{ "<leader>bi", desc = "Toggle Pin Buffer" },
			{ "<leader>bn", desc = "Go to Right Buffer" },
			{ "<leader>bp", desc = "Go to Left Buffer" },
			{ "<leader>bd", group = "Buffer Delete" },
			{ "<leader>bdd", desc = "Delete Current Buffer" },
			{ "<leader>bdi", desc = "Delete Non-pinned Buffers" },
			{ "<leader>bds", desc = "Delete All Non-active Buffers" },
			{ "<leader>bs", group = "Buffer Split" },
			{ "<leader>bsv", desc = "Split Vertically" },
			{ "<leader>bsh", desc = "Split Horizontally" },

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

			-- Treesitter Text Objects (Swap/Rearrange)
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
			{ "<localleader>tt", desc = "Toggle tab terminal" },

		})
	end,
}
