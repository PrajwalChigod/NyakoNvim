return {
	{
		"nvim-mini/mini.diff",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local diff = require("mini.diff")

			diff.setup({
				view = {
					style = "number",
					signs = { add = "| ", change = "| ", delete = "| " },
				},
				delay = {
					text_change = 1000,
				},
				mappings = {
					apply = "",
					reset = "",
					textobject = "",
					goto_first = "",
					goto_prev = "",
					goto_next = "",
					goto_last = "",
				},
			})

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc })
			end

			local function get_visual_range()
				local line_start = vim.fn.line("v")
				local line_end = vim.fn.line(".")
				if line_start > line_end then
					line_start, line_end = line_end, line_start
				end
				return line_start, line_end
			end

			local function do_hunks(action, opts)
				diff.do_hunks(0, action, opts or {})
			end

			map("n", "<leader>gs", function()
				do_hunks("apply", { line_start = vim.fn.line("."), line_end = vim.fn.line(".") })
			end, "Stage Hunk")
			map("n", "<leader>gr", function()
				do_hunks("reset", { line_start = vim.fn.line("."), line_end = vim.fn.line(".") })
			end, "Reset Hunk")
			map("x", "<leader>gs", function()
				local line_start, line_end = get_visual_range()
				do_hunks("apply", { line_start = line_start, line_end = line_end })
			end, "Stage Hunk")
			map("x", "<leader>gr", function()
				local line_start, line_end = get_visual_range()
				do_hunks("reset", { line_start = line_start, line_end = line_end })
			end, "Reset Hunk")
			map("n", "<leader>gS", function()
				do_hunks("apply")
			end, "Stage Buffer")
			map("n", "<leader>gR", function()
				do_hunks("reset")
			end, "Reset Buffer")
			map("n", "<leader>gp", diff.toggle_overlay, "Toggle Diff Overlay")
			map("n", "<leader>gt", diff.toggle, "Toggle Signs")
			map({ "o", "x" }, "ih", diff.textobject, "Select Hunk")
		end,
	},
	{
		"nvim-mini/mini-git",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "Git" },
		config = function()
			local git = require("mini.git")

			git.setup()

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc })
			end

			map("n", "<leader>gb", function()
				local line = vim.api.nvim_win_get_cursor(0)[1]
				vim.cmd(("vertical Git blame -L %d,+1 -- %%"):format(line))
			end, "Blame Line")
			map("n", "<leader>gd", "<cmd>vertical Git diff -- %<CR>", "Diff This")
			map("n", "<leader>gD", "<cmd>vertical Git diff HEAD~ -- %<CR>", "Diff This ~")
			map("n", "<leader>glb", "<cmd>vertical Git blame -- %<CR>", "Blame Buffer")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		cmd = {
			"GitConflictChooseOurs",
			"GitConflictChooseTheirs",
			"GitConflictChooseBoth",
			"GitConflictChooseNone",
			"GitConflictNextConflict",
			"GitConflictPrevConflict",
		},
		keys = {
			{ "<leader>gco", "<cmd>GitConflictChooseOurs<CR>", desc = "Conflict choose ours" },
			{ "<leader>gct", "<cmd>GitConflictChooseTheirs<CR>", desc = "Conflict choose theirs" },
			{ "<leader>gcb", "<cmd>GitConflictChooseBoth<CR>", desc = "Conflict choose both" },
			{ "<leader>gcn", "<cmd>GitConflictChooseNone<CR>", desc = "Conflict choose none" },
			{ "]x", "<cmd>GitConflictNextConflict<CR>", desc = "Next conflict" },
			{ "[x", "<cmd>GitConflictPrevConflict<CR>", desc = "Previous conflict" },
		},
		config = function()
			require("git-conflict").setup({
				default_mappings = false,
				disable_diagnostics = true,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>gg",
				function()
					vim.cmd("LazyGit")
				end,
				desc = "Open LazyGit",
			},
		},
	},
}
