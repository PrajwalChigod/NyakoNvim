local M = {}

local default_session_dir = vim.fn.stdpath("state") .. "/sessions/"

-- Check if opened with a directory argument
local function is_directory_launch()
	return vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
end

local function with_trailing_sep(dir)
	if dir:sub(-1) ~= "/" and dir:sub(-1) ~= "\\" then
		return dir .. "/"
	end
	return dir
end

local function session_dir()
	local config = package.loaded["persistence.config"]
	if config and config.options and config.options.dir then
		return with_trailing_sep(config.options.dir)
	end
	return with_trailing_sep(default_session_dir)
end

local function session_candidates()
	local cwd = vim.fn.getcwd()
	if cwd == "" then
		return {}
	end

	local sanitized = cwd:gsub("[\\/:]+", "%%")
	local pattern = session_dir() .. sanitized .. "*.vim"
	local matches = vim.fn.glob(pattern, false, true)

	if type(matches) == "table" then
		return matches
	end

	return {}
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
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name ~= "" and vim.fn.isdirectory(name) == 1 then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
	end

	pcall(vim.cmd, "filetype detect")
	pcall(vim.cmd, "doautocmd BufRead")

	local gitsigns = package.loaded["gitsigns"]
	if gitsigns and type(gitsigns.refresh) == "function" then
		vim.schedule(function()
			pcall(gitsigns.refresh)
		end)
	end
end

-- Load session and cleanup
local function load_session(persistence)
	persistence.load()
	vim.schedule(cleanup_after_session)
end

-- Replace directory buffer with scratch buffer and open yazi
local function open_file_explorer()
	local dir_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf)) == 1 then
			dir_buf = buf
			break
		end
	end

	if dir_buf then
		local scratch_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, scratch_buf)
		vim.api.nvim_buf_delete(dir_buf, { force = true })
	end

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
			local sessions = session_candidates()
			if sessions[1] == nil then
				open_file_explorer()
				return
			end

			local persistence = get_persistence()
			if not persistence or not has_session(persistence) then
				open_file_explorer()
				return
			end

			load_session(persistence)
		end,
	})
end

M.setup()

return M
