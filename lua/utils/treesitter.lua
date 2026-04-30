local M = {}

function M.is_large_file(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name ~= "" then
		local ok, stats = pcall(vim.uv.fs_stat, name)
		if ok and stats and stats.size > 50 * 1024 then
			return true
		end
	end

	return vim.api.nvim_buf_line_count(bufnr) > 5000
end

function M.start(opts)
	local bufnr = vim.api.nvim_get_current_buf()
	if M.is_large_file(bufnr) then
		return
	end

	local ok = pcall(vim.treesitter.start, bufnr)

	if ok and opts and opts.indent then
		vim.b[bufnr].did_indent = 1
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(bufnr) and not M.is_large_file(bufnr) then
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end)
	end
end

return M
