-- ===============================================
-- FILE HANDLING & EDITOR BEHAVIOR
-- ===============================================

local general_group = vim.api.nvim_create_augroup("GeneralSettings", { clear = true })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_group,
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Helper: Check if buffer is too large (>512KB or >3000 lines)
local function is_large_buffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size > 512 * 1024 then
		return true
	end
	-- Also check line count
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if line_count > 3000 then
		return true
	end
	return false
end

-- Remove undofiles older than 10 days
local function clean_old_undofiles()
	local undodir = vim.fn.expand("~/.vim/undodir")
	local uv = vim.uv

	uv.fs_opendir(undodir, function(open_err, dir)
		if open_err or not dir then
			return -- directory doesn't exist yet, nothing to clean
		end

		local cutoff = os.time() - (10 * 24 * 60 * 60)

		local function read_next()
			uv.fs_readdir(dir, function(read_err, entries)
				if read_err or not entries then
					uv.fs_closedir(dir, function() end)
					return
				end

				for _, entry in ipairs(entries) do
					if entry.type == "file" then
						local path = undodir .. "/" .. entry.name
						uv.fs_stat(path, function(stat_err, stat)
							if not stat_err and stat and stat.mtime.sec < cutoff then
								uv.fs_unlink(path, function() end)
							end
						end)
					end
				end

				read_next()
			end)
		end

		read_next()
	end, 50)
end

-- Defer non-critical autocommands for faster startup
vim.defer_fn(function()
	clean_old_undofiles()

	-- Combined BufWritePre: remove trailing whitespace and auto-create directories
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = general_group,
		pattern = "*",
		callback = function(event)
			-- Skip for large files
			if is_large_buffer(event.buf) then
				return
			end

			-- Remove trailing whitespace
			local save_cursor = vim.fn.getpos(".")
			pcall(function()
				vim.cmd([[%s/\s\+$//e]])
			end)
			vim.fn.setpos(".", save_cursor)

			-- Auto-create directories when saving files
			if not event.match:match("^%w%w+:[\\/][\\/]") then
				local file = vim.uv.fs_realpath(event.match) or event.match
				vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
			end
		end,
	})

	-- Remember cursor position
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = general_group,
		callback = function(event)
			-- Skip for large files
			if is_large_buffer(event.buf) then
				return
			end

			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})
end, 50)

-- Auto-resize splits when window is resized (debounced to prevent rapid redraws)
local resize_timer = nil
vim.api.nvim_create_autocmd("VimResized", {
	group = general_group,
	callback = function()
		if resize_timer then
			vim.fn.timer_stop(resize_timer)
		end
		resize_timer = vim.fn.timer_start(100, function()
			vim.cmd("tabdo wincmd =")
			resize_timer = nil
		end)
	end,
})

-- Warn before opening large files (>512KB)
vim.api.nvim_create_autocmd("BufReadPre", {
	group = general_group,
	callback = function(event)
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
		if ok and stats and stats.size > 512 * 1024 then -- 512KB (was 1MB)
			local size_mb = string.format("%.2f", stats.size / (1024 * 1024))
			vim.notify(
				string.format("Large file detected (%s MB). Performance may be affected.", size_mb),
				vim.log.levels.WARN
			)
		end
	end,
})

-- ===============================================
-- DEVELOPMENT-SPECIFIC
-- ===============================================

local dev_group = vim.api.nvim_create_augroup("DevelopmentSettings", { clear = true })

-- Set correct filetype for various config files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = dev_group,
	pattern = {
		"*.env*",
		".env*",
		"Dockerfile*",
		"*.dockerfile",
		"*.jenkinsfile",
		"Jenkinsfile*",
		"*.gitlab-ci.yml",
	},
	callback = function()
		local filename = vim.fn.expand("%:t")
		if filename:match("%.env") or filename:match("^%.env") then
			vim.bo.filetype = "sh"
		elseif filename:match("Dockerfile") or filename:match("%.dockerfile$") then
			vim.bo.filetype = "dockerfile"
		elseif filename:match("jenkinsfile") or filename:match("Jenkinsfile") then
			vim.bo.filetype = "groovy"
		elseif filename:match("gitlab%-ci") then
			vim.bo.filetype = "yaml"
		end
	end,
})

-- ===============================================
-- TERMINAL & QUICKFIX
-- ===============================================

local ui_group = vim.api.nvim_create_augroup("UISettings", { clear = true })

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
	group = ui_group,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Auto-close quickfix if it's the last window
vim.api.nvim_create_autocmd("WinEnter", {
	group = ui_group,
	callback = function()
		if vim.bo.buftype == "quickfix" and vim.fn.winnr("$") == 1 then
			vim.cmd("quit")
		end
	end,
})

-- Open quickfix window automatically after grep/make
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = ui_group,
	pattern = { "grep", "make" },
	callback = function()
		vim.cmd("cwindow")
	end,
})


-- ===============================================
-- DIFF MODE
-- ===============================================

local diff_group = vim.api.nvim_create_augroup("DiffFolding", { clear = true })

-- Enable diff folding per-window when entering diff mode; restore on exit
vim.api.nvim_create_autocmd("OptionSet", {
	group = diff_group,
	pattern = "diff",
	callback = function()
		if vim.v.option_new == 1 then
			vim.w.saved_foldmethod = vim.wo.foldmethod
			vim.wo.foldmethod = "diff"
		elseif vim.w.saved_foldmethod then
			vim.wo.foldmethod = vim.w.saved_foldmethod
			vim.w.saved_foldmethod = nil
		end
	end,
})

-- ===============================================
-- GIT MERGE CONFLICTS
-- ===============================================

local merge_group = vim.api.nvim_create_augroup("GitMergeAutoTool", { clear = true })

-- Detect real conflict markers at the start of a line ("<<<<<<< ").
local function has_conflict_markers(bufnr)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		if line:match("^<<<<<<< ") then
			return true
		end
	end
	return false
end

-- Check whether the repo containing `dir` is mid merge/rebase/cherry-pick/revert.
local function git_has_merge_state(dir)
	local git_dir = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--git-dir" })[1]
	if vim.v.shell_error ~= 0 or not git_dir or git_dir == "" then
		return false
	end
	if not git_dir:match("^/") then
		git_dir = dir .. "/" .. git_dir
	end
	for _, marker in ipairs({ "MERGE_HEAD", "rebase-merge", "rebase-apply", "CHERRY_PICK_HEAD", "REVERT_HEAD" }) do
		if vim.uv.fs_stat(git_dir .. "/" .. marker) then
			return true
		end
	end
	return false
end

local function diffview_is_open()
	local ok, lib = pcall(require, "diffview.lib")
	return ok and lib.get_current_view() ~= nil
end

-- Mirror what `git mergetool` gives you automatically: the moment you open a
-- file that actually has unresolved conflict markers during a real
-- merge/rebase/cherry-pick, pop open diffview's LOCAL/BASE/REMOTE + MERGED
-- layout. Skipped while already inside a diffview so it doesn't fight you.
vim.api.nvim_create_autocmd("BufReadPost", {
	group = merge_group,
	callback = function(event)
		local bufname = vim.api.nvim_buf_get_name(event.buf)
		if bufname == "" or vim.bo[event.buf].buftype ~= "" then
			return
		end
		if is_large_buffer(event.buf) or diffview_is_open() then
			return
		end
		if not has_conflict_markers(event.buf) then
			return
		end
		if not git_has_merge_state(vim.fn.fnamemodify(bufname, ":h")) then
			return
		end
		vim.schedule(function()
			vim.cmd("DiffviewOpen --merge-tool")
		end)
	end,
})

-- ===============================================
-- LOAD CUSTOM AUTOCMDS
-- ===============================================
-- Load user-defined autocmds from lua/config/extras/autocmds.lua (gitignored)
-- Run :SetupCustom to create the template file
local custom_autocmds_path = vim.fn.stdpath("config") .. "/lua/config/extras/autocmds.lua"
if vim.fn.filereadable(custom_autocmds_path) == 1 then
	local ok, err = pcall(dofile, custom_autocmds_path)
	if not ok then
		vim.notify("Error loading custom autocmds: " .. tostring(err), vim.log.levels.ERROR)
	end
end
