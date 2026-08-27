local M = {}

local session_dir = vim.fn.stdpath("state") .. "/sessions/"
local stopped = false

vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

-- Check if opened with a directory argument
local function is_directory_launch()
	return vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
end

local function sanitize(cwd)
	return (cwd:gsub("[\\/:]+", "%%"))
end

local function session_file(cwd)
	return session_dir .. sanitize(cwd) .. ".vim"
end

local function last_session()
	local files = vim.fn.glob(session_dir .. "*.vim", false, true)
	if type(files) ~= "table" or #files == 0 then
		return nil
	end

	table.sort(files, function(a, b)
		return vim.fn.getftime(a) > vim.fn.getftime(b)
	end)

	return files[1]
end

function M.current()
	local file = session_file(vim.fn.getcwd())
	return vim.fn.filereadable(file) == 1 and file or nil
end

function M.save()
	if stopped then
		return
	end
	if #vim.api.nvim_list_uis() == 0 then
		return -- headless, nothing to persist
	end

	vim.fn.mkdir(session_dir, "p")
	pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(session_file(vim.fn.getcwd())))
end

function M.load(opts)
	opts = opts or {}

	local file = opts.last and last_session() or session_file(vim.fn.getcwd())
	if not file or vim.fn.filereadable(file) ~= 1 then
		return false
	end

	pcall(vim.cmd, "silent! source " .. vim.fn.fnameescape(file))
	return true
end

function M.stop()
	stopped = true
end

function M.delete()
	local file = M.current()
	if file then
		vim.fn.delete(file)
	end
	stopped = true
end

-- Check if a session file exists for current directory
local function has_session()
	return M.current() ~= nil
end

-- Must run before sourcing a session file: mksession's "silent only" only
-- reaps normal windows, so a focused float (e.g. lazy.nvim's install UI)
-- survives as the current window and gets hijacked by the restore script's
-- subsequent "edit" commands instead of being closed.
local function close_floats()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			pcall(vim.api.nvim_win_close, win, true)
		end
	end
end

-- Remove directory buffer and trigger filetype detection
local function cleanup_after_session()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name ~= "" and vim.fn.isdirectory(name) == 1 then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
	end

	-- Defensive: catch lazy.nvim re-rendering its window after close_floats() ran.
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.bo[buf].filetype
			if ft == "lazy" or ft == "lazy_backdrop" then
				pcall(vim.api.nvim_win_close, win, true)
			end
		end
	end

	pcall(vim.cmd, "filetype detect")
	pcall(vim.cmd, "doautocmd BufRead")

	local minidiff = package.loaded["mini.diff"]
	local minigit = package.loaded["mini.git"]
	if minidiff or minigit then
		vim.schedule(function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
					if minidiff and type(minidiff.enable) == "function" then
						pcall(minidiff.enable, buf)
					end
					if minigit and type(minigit.enable) == "function" then
						pcall(minigit.enable, buf)
					end
				end
			end
		end)
	end
end

-- Load session and cleanup
local function load_session()
	close_floats()
	M.load()
	vim.schedule(cleanup_after_session)
end

-- Replace directory buffer with scratch buffer and open fyler
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
		lazy.load({ plugins = { "fyler.nvim" } })
	end

	vim.schedule(function()
		if vim.fn.exists(":Fyler") == 2 then
			vim.cmd("Fyler")
		end
	end)
end

function M.setup()
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = M.save,
	})

	if not is_directory_launch() then
		return
	end

	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			close_floats()

			if not has_session() then
				open_file_explorer()
				return
			end

			load_session()
		end,
	})
end

M.setup()

return M
