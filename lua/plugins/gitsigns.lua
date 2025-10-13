return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cond = function()
		-- Only load in git repositories
		local function is_git_repo()
			local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
			return git_dir ~= ""
		end
		return is_git_repo()
	end,
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "+" },
				change = { text = "|" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "|" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 2000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 500,
			status_formatter = nil,
			max_file_length = 5000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end


				-- Git Actions - Hunk Operations
				map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
				map("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Hunk" })
				map("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
				map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
				map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })

				-- Git Actions - Blame & Diff
				map("n", "<leader>gb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame Line" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff This" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff This ~" })

				-- Git Toggles
				map("n", "<leader>gt", gitsigns.toggle_signs, { desc = "Toggle Signs" })
				map("n", "<leader>glb", gitsigns.toggle_current_line_blame, { desc = "Toggle Line Blame" })
				map("n", "<leader>gld", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		})
	end,
}
