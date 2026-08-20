return {
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
		},
		keys = {
			{
				"<leader>gm",
				function()
					local files = vim.tbl_filter(function(f)
						return f ~= ""
					end, vim.fn.systemlist("git diff --name-only --diff-filter=U"))

					if vim.v.shell_error ~= 0 then
						vim.notify("Not inside a git repo (or git error)", vim.log.levels.ERROR)
						return
					end
					if #files == 0 then
						vim.notify("No conflicted files", vim.log.levels.INFO)
						return
					end

					-- fzf-lua is only added to the runtimepath by lazy.nvim once one of
					-- its own `keys` is pressed; force-load it since we're calling it
					-- programmatically here instead.
					require("lazy").load({ plugins = { "fzf-lua" } })
					require("fzf-lua").fzf_exec(files, {
						prompt = "Conflicts❯ ",
						actions = {
							["default"] = function(selected)
								vim.cmd("edit " .. vim.fn.fnameescape(selected[1]))
								vim.cmd("DiffviewOpen --merge-tool")
							end,
						},
					})
				end,
				desc = "Git: pick conflicted file (3-pane merge tool)",
			},
			{ "<leader>gM", "<cmd>DiffviewClose<CR>",         desc = "Git: Close diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git: File history" },
		},
		config = function()
			local actions = require("diffview.actions")

			require("diffview").setup({
				view = {
					merge_tool = {
						-- LOCAL | BASE | REMOTE on top, MERGED on bottom
						layout = "diff4_mixed",
						disable_diagnostics = true,
					},
				},
				keymaps = {
					disable_defaults = false,
					-- Active in all diff view panels (LOCAL / BASE / REMOTE panels)
					view = {
						{ "n", "q",          "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
						{ "n", "<leader>gM", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
					},
					-- Active in the MERGED (bottom) panel of the 4-way merge editor
					diff4 = {
						{ "n", "co",  actions.diffget("ours"),   { desc = "Merge: take LOCAL (ours)" } },
						{ "n", "ct",  actions.diffget("theirs"), { desc = "Merge: take REMOTE (theirs)" } },
						{ "n", "cb",  actions.diffget("base"),   { desc = "Merge: take BASE" } },
						{ "n", "]x",  actions.next_conflict,     { desc = "Next conflict" } },
						{ "n", "[x",  actions.prev_conflict,     { desc = "Prev conflict" } },
						{ "n", "q",   "<cmd>DiffviewClose<CR>",  { desc = "Close diffview" } },
					},
					file_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
					},
				},
			})
		end,
	},
}
