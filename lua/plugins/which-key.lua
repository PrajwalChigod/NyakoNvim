return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
			-- your configuration comes here
		})

		-- Leader keymaps
		wk.add({
			-- LSP keymaps (using default Neovim pattern)
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
			{ "ge", desc = "Show Diagnostics" },
			{ "K", desc = "Hover Documentation" },

			-- Swap/Rearrange operations (Treesitter)
			{ "<leader>s", group = "Swap" },
			{ "<leader>sp", desc = "Swap next parameter" },
			{ "<leader>sP", desc = "Swap previous parameter" },
			{ "<leader>sf", desc = "Swap next function" },
			{ "<leader>sF", desc = "Swap previous function" },

			-- Linting operations
			{ "<leader>l", group = "Lint" },
			{ "<leader>ll", desc = "Run linter" },
			{ "<leader>lt", desc = "Toggle auto-lint on save" },
			{ "<leader>lr", desc = "Reset/clear lint messages" },
			{ "<leader>ln", desc = "Next lint issue" },
			{ "<leader>lp", desc = "Previous lint issue" },
			{ "<leader>li", desc = "Show linter info" },

			-- Formatting operations
			{ "<leader>m", group = "Format" },
			{ "<leader>mf", desc = "Format file" },
			{ "<leader>mr", desc = "Format range" },
			{ "<leader>mt", desc = "Toggle format on save" },
			{ "<leader>mi", desc = "Show formatter info" },
			{ "<leader>mc", desc = "Conform info" },

			-- Debug operations
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

			-- Diagnostics operations
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>xt", desc = "Toggle diagnostics (enable/disable)" },
			{ "<leader>xn", desc = "Next diagnostic" },
			{ "<leader>xp", desc = "Previous diagnostic" },
			{ "<leader>xf", desc = "Open diagnostic float" },
			{ "<leader>xl", desc = "Set loclist with diagnostics" },
			{ "<leader>xq", desc = "Set quickfix with diagnostics" },
		})

		-- Local Leader keymaps
		wk.add({
			-- Git Operations
			{ "<localleader>g", group = "Git" },
			{ "<localleader>gg", desc = "LazyGit" },
			{ "<localleader>gs", desc = "Stage Hunk" },
			{ "<localleader>gr", desc = "Reset Hunk" },
			{ "<localleader>gp", desc = "Preview Hunk" },
			{ "<localleader>gb", desc = "Blame Line" },
			{ "<localleader>gd", desc = "Diff This" },
			{ "<localleader>gS", desc = "Stage Buffer" },
			{ "<localleader>gR", desc = "Reset Buffer" },
			{ "<localleader>gu", desc = "Undo Stage Hunk" },
			{ "<localleader>gD", desc = "Diff This ~" },
			{ "<localleader>gt", desc = "Toggle Signs" },
			{ "<localleader>glb", desc = "Toggle Line Blame" },
			{ "<localleader>gld", desc = "Toggle Deleted" },

			-- Tab Operations
			{ "<leader>t", group = "Tabs" },
			{ "<leader>tt", desc = "New tab" },
			{ "<leader>tf", desc = "New tab with file picker" },
			{ "<leader>tx", desc = "Close current tab" },
			{ "<leader>tb", desc = "Open buffer in new tab" },

			-- Terminal Operations
			{ "<localleader>t", group = "Terminal" },
			{ "<localleader>t", desc = "Toggle main terminal" },
			{ "<localleader>tf", desc = "Toggle floating terminal" },
			{ "<localleader>th", desc = "Toggle horizontal terminal" },
			{ "<localleader>tv", desc = "Toggle vertical terminal" },

			-- Buffer Management
			{ "<localleader>b", group = "Buffer" },
			{ "<localleader>bd", desc = "Delete Current Buffer" },
			{ "<localleader>bo", desc = "Delete Other Buffers" },
			{ "<localleader>bi", desc = "Toggle Pin" },
			{ "<localleader>bI", desc = "Delete Non-pinned Buffers" },

			-- File Explorer
			{ "<leader>e", desc = "Open file explorer (Oil)" },

		})
	end,
}
