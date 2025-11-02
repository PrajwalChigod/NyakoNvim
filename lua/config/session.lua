local M = {}

-- Check if opened with a directory argument
local function is_directory_launch()
	return vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
end

-- Get persistence plugin (assume it's installed)
local function get_persistence()
	local ok, persistence = pcall(require, "persistence")
	if ok then
		return persistence
	end

	-- Lazy load if not already loaded
	local lazy_ok, lazy = pcall(require, "lazy")
	if lazy_ok then
		lazy.load({ plugins = { "persistence.nvim" } })
		ok, persistence = pcall(require, "persistence")
		if ok then
			return persistence
		end
	end

	return nil
end

-- Check if a session file exists for current directory
local function has_session(persistence)
	if not persistence then
		return false
	end

	local session_file = persistence.current()
	return session_file and vim.fn.filereadable(session_file) == 1
end

-- Remove directory buffer and trigger filetype detection
local function cleanup_after_session()
	-- Remove directory buffers
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf)) == 1 then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end

	-- Ensure filetype and LSP attach for current buffer
	vim.cmd("filetype detect")
	vim.cmd("doautocmd BufRead")

	-- Refresh GitSigns for all loaded buffers to detect changes after session restore
	local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
	if gitsigns_ok then
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
				-- Schedule refresh to ensure it happens after all autocmds
				vim.schedule(function()
					pcall(gitsigns.refresh)
				end)
			end
		end
	end
end

-- Load session and cleanup
local function load_session(persistence)
	persistence.load()
	vim.schedule(cleanup_after_session)
end

-- Replace directory buffer with scratch buffer and open yazi
local function open_file_explorer()
	-- Find directory buffer
	local dir_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf)) == 1 then
			dir_buf = buf
			break
		end
	end

	-- Replace with scratch buffer
	if dir_buf then
		local scratch_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, scratch_buf)
		vim.api.nvim_buf_delete(dir_buf, { force = true })
	end

	-- Load and open yazi
	local lazy_ok, lazy = pcall(require, "lazy")
	if lazy_ok then
		lazy.load({ plugins = { "yazi.nvim" } })
	end

	vim.schedule(function()
		if vim.fn.exists(":Yazi") == 2 then
			vim.cmd("Yazi cwd")
		end
	end)
end

function M.setup()
	if not is_directory_launch() then
		return
	end

	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			local persistence = get_persistence()

			if has_session(persistence) then
				load_session(persistence)
			else
				open_file_explorer()
			end
		end,
	})
end

M.setup()

return M
