local M = {}

function M.is_open()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return true
		end
	end
	return false
end

function M.toggle()
	if M.is_open() then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

function M.add_line()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	if filename == "" then
		vim.notify("Save the buffer before adding it to quickfix.", vim.log.levels.WARN)
		return
	end

	local cursor = vim.api.nvim_win_get_cursor(0)
	local lnum = cursor[1]
	local col = cursor[2] + 1
	local text = vim.api.nvim_get_current_line()

	for _, item in ipairs(vim.fn.getqflist()) do
		if item.bufnr == bufnr and item.lnum == lnum and (item.col or 1) == col then
			vim.notify("Quickfix already tracks this location.", vim.log.levels.INFO)
			return
		end
	end

	local entry = {
		bufnr = bufnr,
		lnum = lnum,
		col = col,
		text = text,
	}

	vim.fn.setqflist({ entry }, "a")
	vim.notify(
		string.format("Added to quickfix: %s:%d", vim.fn.fnamemodify(filename, ":."), lnum),
		vim.log.levels.INFO
	)
end

function M.remove_line()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	if filename == "" then
		vim.notify("Current buffer is unnamed; nothing to remove from quickfix.", vim.log.levels.INFO)
		return
	end

	local cursor = vim.api.nvim_win_get_cursor(0)
	local lnum = cursor[1]
	local col = cursor[2] + 1
	local remaining, removed = {}, false

	for _, item in ipairs(vim.fn.getqflist()) do
		if item.bufnr == bufnr and item.lnum == lnum and (item.col or 1) == col then
			removed = true
		else
			table.insert(remaining, item)
		end
	end

	if not removed then
		vim.notify("Current line is not in the quickfix list.", vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist(remaining, "r")

	if M.is_open() and #remaining == 0 then
		vim.cmd("cclose")
	end

	vim.notify(
		string.format("Removed from quickfix: %s:%d", vim.fn.fnamemodify(filename, ":."), lnum),
		vim.log.levels.INFO
	)
end

function M.clear()
	if vim.tbl_isempty(vim.fn.getqflist()) then
		vim.notify("Quickfix list is already empty.", vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist({}, "r")

	if M.is_open() then
		vim.cmd("cclose")
	end

	vim.notify("Cleared quickfix list.", vim.log.levels.INFO)
end

return M
