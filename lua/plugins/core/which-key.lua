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
			-- NORMAL MODE
			-- ===============================================


			-- LSP Information
			{ "gh", desc = "Hover Documentation" },
			{ "gs", desc = "Signature Help" },

			-- Enhanced Movement
			{ "gG", desc = "Go to end of file" },
			{ "J", desc = "Join lines (keep cursor)" },
			{ "n", desc = "Next search (centered)" },
			{ "N", desc = "Previous search (centered)" },
			{ "<C-d>", desc = "Page down (centered)" },
			{ "<C-u>", desc = "Page up (centered)" },

			-- Window Navigation
			{ "<C-h>", desc = "Left split" },
			{ "<C-j>", desc = "Bottom split" },
			{ "<C-k>", desc = "Top split" },
			{ "<C-l>", desc = "Right split" },

			-- Flash Navigation
			{ "s", desc = "Flash jump", mode = { "n", "x" } },
			{ "S", desc = "Flash treesitter", mode = "n" },
			{ "r", desc = "Remote flash", mode = "o" },
			{ "R", desc = "Treesitter search", mode = { "o", "x" } },

			-- Treesitter Selection
			{ "<C-space>", desc = "Init/Increment selection" },
			{ "<C-S-space>", desc = "Scope incremental" },
			{ "<M-space>", desc = "Node decremental" },

			-- Text Objects
			{ "ih", desc = "Git hunk", mode = { "o", "x" } },

			-- File Explorer
			{ "-", desc = "Open file explorer" },
			{ "_", desc = "Open file explorer (float)" },

			-- Buffer Navigation
			{ "<Tab>", desc = "Next buffer" },
			{ "<S-Tab>", desc = "Previous buffer" },


			-- Ergonomic Line Navigation
			{ "H", desc = "First non-blank character", mode = { "n", "v" } },
			{ "L", desc = "End of line", mode = { "n", "v" } },

			-- ===============================================
			-- LSP & DEVELOPMENT (g* prefix)
			-- ===============================================

			-- Navigation
			{ "gd", desc = "Definition" },
			{ "gD", desc = "Declaration" },
			{ "gO", desc = "Document Symbols" },
			{ "gW", desc = "Workspace Symbols" },

			-- References & Actions (gr*)
			{ "gr", group = "References/Actions" },
			{ "grr", desc = "References" },
			{ "gra", desc = "Code Actions" },
			{ "grn", desc = "Rename" },
			{ "gri", desc = "Implementations" },
			{ "grt", desc = "Type Definitions" },

			-- Code Tools
			{ "gf", desc = "Format" },
			{ "gl", desc = "Lint" },

			-- Diagnostics (ge*)
			{ "ge", group = "Diagnostics" },
			{ "get", desc = "Toggle" },
			{ "gel", desc = "Loclist" },
			{ "geq", desc = "Quickfix" },

			-- Built-in diagnostic navigation
			{ "]d", desc = "Next diagnostic" },
			{ "[d", desc = "Previous diagnostic" },
			{ "]D", desc = "Last diagnostic" },
			{ "[D", desc = "First diagnostic" },
			{ "<C-w>d", desc = "Diagnostic float" },

			-- Comments (gc*)
			{ "gc", group = "Comment" },
			{ "gcc", desc = "Toggle line" },
			{ "gcf", desc = "Function" },
			{ "gcO", desc = "Above" },
			{ "gco", desc = "Below" },
			{ "gcA", desc = "End of line" },

			-- ===============================================
			-- VISUAL MODE
			-- ===============================================

			{ "J", desc = "Move line down", mode = "v" },
			{ "K", desc = "Move line up", mode = "v" },
			{ "<", desc = "Indent left", mode = "v" },
			{ ">", desc = "Indent right", mode = "v" },
			{ "gc", desc = "Comment", mode = "v" },
			{ "S", desc = "Surround selection", mode = "v" },
			{ "gS", desc = "Surround selection (linewise)", mode = "v" },
			{ "<C-space>", desc = "Increment selection", mode = "v" },
			{ "<C-S-space>", desc = "Scope incremental", mode = "v" },
			{ "<M-space>", desc = "Node decremental", mode = "v" },

			-- ===============================================
			-- INSERT MODE
			-- ===============================================

			{ "jj", desc = "Exit insert", mode = "i" },

			-- Editor Alt Keys
			{ "<A-D>", desc = "Delete to end of line", mode = "i" },
			{ "<A-c>", desc = "Yank/copy current line", mode = "i" },
			{ "<A-p>", desc = "Paste after cursor", mode = "i" },

			-- Surround
			{ "<C-g>s", desc = "Surround selection", mode = "i" },
			{ "<C-g>S", desc = "Surround line (linewise)", mode = "i" },

			-- Completion
			{ "<C-n>", desc = "Next completion", mode = "i" },
			{ "<C-p>", desc = "Previous completion", mode = "i" },
			{ "<C-d>", desc = "Scroll doc down", mode = "i" },
			{ "<C-f>", desc = "Scroll doc up", mode = "i" },
			{ "<Tab>", desc = "Accept completion", mode = "i" },
			{ "<CR>", desc = "Accept completion", mode = "i" },
			{ "<C-Space>", desc = "Accept completion", mode = "i" },
			{ "<S-Tab>", desc = "Previous snippet", mode = "i" },

			-- ===============================================
			-- COMMAND MODE
			-- ===============================================

			{ "<c-s>", desc = "Toggle flash search", mode = "c" },

			-- ===============================================
			-- TERMINAL MODE
			-- ===============================================

			{ "<Esc>", desc = "Exit terminal", mode = "t" },

			-- ===============================================
			-- LEADER (<leader>)
			-- ===============================================

			-- Config (<leader>c)
			{ "<leader>c", group = "Config" },
			{ "<leader>ce", desc = "Edit config" },
			{ "<leader>cr", desc = "Reload config & sync plugins" },
			{ "<leader>cp", desc = "Colorscheme Picker" },


			-- Find (<leader>f)
			{ "<leader>f", group = "Find" },
			{ "<leader>ff", desc = "Find files" },
			{ "<leader>fg", desc = "Find git files" },
			{ "<leader>fo", desc = "Find recent files" },
			{ "<leader>fb", desc = "Find buffers" },
			{ "<leader>fh", desc = "Help tags" },
			{ "<leader>fk", desc = "Keymaps" },
			{ "<leader>fc", desc = "Commands" },
			{ "<leader>fm", desc = "Marks" },
			{ "<leader>fj", desc = "Jumps" },
			{ "<leader>fl", desc = "Resume last search" },
			{ "<leader>fa", desc = "Symbols (current file)" },
			{ "<leader>fA", desc = "Symbols (workspace)" },

			-- Search (<leader>s)
			{ "<leader>s", group = "Search" },
			{ "<leader>sb", desc = "Grep current buffer" },
			{ "<leader>sw", desc = "Search word under cursor" },
			{ "<leader>sW", desc = "Search WORD under cursor" },
			{ "<leader>sg", desc = "Live grep" },
			{ "<leader>sc", desc = "Command history" },
			{ "<leader>sh", desc = "Search history" },

			-- Projects (<leader>p)
			{ "<leader>p", group = "Projects" },
			{ "<leader>p", desc = "Open project in new tab" },
			{ "<leader>ph", desc = "Open in left split" },
			{ "<leader>pj", desc = "Open in bottom split" },
			{ "<leader>pk", desc = "Open in top split" },
			{ "<leader>pl", desc = "Open in right split" },
			{ "<leader>pa", desc = "Add project" },
			{ "<leader>pr", desc = "Remove project" },

			-- Tabs (<leader>t)
			{ "<leader>t", group = "Tabs" },
			{ "<leader>tn", desc = "New tab" },
			{ "<leader>tf", desc = "New tab with picker" },
			{ "<leader>tc", desc = "Close tab" },
			{ "<leader>tb", desc = "Buffer in new tab" },

			-- Buffer (<leader>b)
			{ "<leader>b", group = "Buffer" },
			{ "<leader>bp", desc = "Pin/unpin" },
			{ "<leader>bd", desc = "Delete current" },
			{ "<leader>bx", desc = "Delete non-pinned" },
			{ "<leader>bo", desc = "Delete others" },

			-- Debug (<leader>d)
			{ "<leader>d", group = "Debug" },
			{ "<leader>db", desc = "Breakpoint" },
			{ "<leader>dB", desc = "Conditional breakpoint" },
			{ "<leader>dc", desc = "Continue" },
			{ "<leader>di", desc = "Step into" },
			{ "<leader>do", desc = "Step over" },
			{ "<leader>dO", desc = "Step out" },
			{ "<leader>dr", desc = "Run" },
			{ "<leader>dt", desc = "Terminate" },
			{ "<leader>du", desc = "UI" },
			{ "<leader>de", desc = "Evaluate" },

			-- Git (<leader>g)
			{ "<leader>g", desc = "Open LazyGit" },
			{ "<leader>gs", desc = "Stage hunk" },
			{ "<leader>gr", desc = "Reset hunk" },
			{ "<leader>gp", desc = "Preview hunk" },
			{ "<leader>gb", desc = "Blame line" },
			{ "<leader>gd", desc = "Diff this" },
			{ "<leader>gS", desc = "Stage buffer" },
			{ "<leader>gR", desc = "Reset buffer" },
			{ "<leader>gu", desc = "Undo stage" },
			{ "<leader>gD", desc = "Diff this ~" },
			{ "<leader>gt", desc = "Toggle signs" },
			{ "<leader>glb", desc = "Toggle line blame" },
			{ "<leader>gld", desc = "Toggle deleted" },

			-- Session (<leader>q)
			{ "<leader>q", group = "Session" },
			{ "<leader>qs", desc = "Restore session" },
			{ "<leader>ql", desc = "Restore last session" },
			{ "<leader>qd", desc = "Stop session recording" },

			-- Surround (native nvim-surround keymaps)
			-- Normal mode: ys{motion}{char}, yss, yS, ySS
			-- Visual mode: S, gS
			-- Change: cs{old}{new}, cS{old}{new}
			-- Delete: ds{char}
			-- See KEYMAPS.md for full documentation

			-- Zen Mode
			{ "<leader>z", desc = "Toggle Zen Mode" },

			-- ===============================================
			-- LOCALLEADER (<localleader>)
			-- ===============================================

			-- Swap
			{ "]S", desc = "Swap with next parameter" },
			{ "[S", desc = "Swap with previous parameter" },
			{ "]s", desc = "Swap with next function" },
			{ "[s", desc = "Swap with previous function" },

			-- Terminal (<localleader>t)
			{ "<localleader>t", group = "Terminal" },
			{ "<localleader>tf", desc = "Floating" },
			{ "<localleader>th", desc = "Horizontal" },
			{ "<localleader>tv", desc = "Vertical" },
			{ "<localleader>tt", desc = "Tab" },
		})
	end,
}
