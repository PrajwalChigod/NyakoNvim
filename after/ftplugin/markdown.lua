local function collect_headings(bufnr)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
	if not ok or not parser then
		return nil
	end

	local query = vim.treesitter.query.parse("markdown", "[(atx_heading) (setext_heading)] @heading")
	local headings = {}

	parser:parse(true)
	parser:for_each_tree(function(tree)
		for _, node in query:iter_captures(tree:root(), bufnr) do
			local row = node:range()
			local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
			local level = #(line:match("^(#+)") or "#")
			table.insert(headings, { row = row, level = level, text = line:gsub("^#+%s*", "") })
		end
	end)

	table.sort(headings, function(a, b)
		return a.row < b.row
	end)

	return headings
end

local function jump_heading(forward)
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1

	local headings = collect_headings(bufnr)
	if not headings then
		-- Fallback if treesitter is unavailable: plain ATX heading search.
		-- Stop at the first/last match rather than wrapping.
		local start_pos = vim.api.nvim_win_get_cursor(0)
		local flags = forward and "W" or "bW"
		local found_row = vim.fn.search([[^#\+\s]], flags)
		if found_row > 0 then
			local target_pos = vim.api.nvim_win_get_cursor(0)
			vim.api.nvim_win_set_cursor(0, start_pos)
			vim.cmd("normal! m'") -- push a jumplist entry so <C-o>/<C-i> can retrace it
			vim.api.nvim_win_set_cursor(0, target_pos)
		end
		return
	end

	local target
	for _, h in ipairs(headings) do
		if forward and h.row > cursor_row then
			target = (target == nil or h.row < target) and h.row or target
		elseif not forward and h.row < cursor_row then
			target = (target == nil or h.row > target) and h.row or target
		end
	end

	-- No further heading in that direction: stay put, matching vim's ]] / [[.
	if target then
		vim.cmd("normal! m'") -- push a jumplist entry so <C-o>/<C-i> can retrace it
		vim.api.nvim_win_set_cursor(0, { target + 1, 0 })
	end
end

local function pick_heading()
	local bufnr = vim.api.nvim_get_current_buf()
	local headings = collect_headings(bufnr)
	if not headings or #headings == 0 then
		vim.notify("No headings found", vim.log.levels.WARN)
		return
	end

	local ok_fzf, fzf = pcall(require, "fzf-lua")
	if not ok_fzf then
		vim.notify("fzf-lua not available", vim.log.levels.WARN)
		return
	end

	local entries = {}
	for _, h in ipairs(headings) do
		entries[#entries + 1] = string.format("%4d  %s%s", h.row + 1, string.rep("  ", h.level - 1), h.text)
	end

	fzf.fzf_exec(entries, {
		prompt = "Headings❯ ",
		actions = {
			["default"] = function(selected)
				local row = tonumber(selected[1]:match("^%s*(%d+)"))
				if row then
					vim.cmd("normal! m'") -- push a jumplist entry so <C-o>/<C-i> can retrace it
					vim.api.nvim_win_set_cursor(0, { row, 0 })
				end
			end,
		},
	})
end

vim.keymap.set("n", "]]", function()
	jump_heading(true)
end, { buffer = true, desc = "Next heading" })

vim.keymap.set("n", "[[", function()
	jump_heading(false)
end, { buffer = true, desc = "Previous heading" })

vim.keymap.set("n", "<localleader>rh", pick_heading, { buffer = true, desc = "Jump to heading" })
