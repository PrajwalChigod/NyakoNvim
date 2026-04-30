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
}
