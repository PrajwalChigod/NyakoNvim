return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
			signcolumn = false,
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
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
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
				map("n", "<localleader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
				map("n", "<localleader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
				map("v", "<localleader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Hunk" })
				map("v", "<localleader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Hunk" })
				map("n", "<localleader>gS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
				map("n", "<localleader>gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
				map("n", "<localleader>gR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
				map("n", "<localleader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })

				-- Git Actions - Blame & Diff
				map("n", "<localleader>gb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame Line" })
				map("n", "<localleader>gd", gitsigns.diffthis, { desc = "Diff This" })
				map("n", "<localleader>gD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff This ~" })

				-- Git Toggles
				map("n", "<localleader>gt", gitsigns.toggle_signs, { desc = "Toggle Signs" })
				map("n", "<localleader>glb", gitsigns.toggle_current_line_blame, { desc = "Toggle Line Blame" })
				map("n", "<localleader>gld", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
			end,
		})
	end,
}
