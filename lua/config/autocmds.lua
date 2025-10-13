-- ===============================================
-- FILE HANDLING & EDITOR BEHAVIOR
-- ===============================================

local general_group = vim.api.nvim_create_augroup("GeneralSettings", { clear = true })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Helper: Check if buffer is too large (>512KB or >3000 lines)
local function is_large_buffer(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
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

-- Defer non-critical autocommands for faster startup
vim.defer_fn(function()
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
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(event.buf))
		if ok and stats and stats.size > 512 * 1024 then -- 512KB (was 1MB)
			local size_mb = string.format("%.2f", stats.size / (1024 * 1024))
			vim.notify(
				string.format("Large file detected (%s MB). Performance may be affected.", size_mb),
				vim.log.levels.WARN
			)
		end
	end,
})

-- Clean old undofiles (>10 days) on startup
vim.api.nvim_create_autocmd("VimEnter", {
	group = general_group,
	callback = function()
		local undodir = vim.fn.expand("~/.vim/undodir")
		if vim.fn.isdirectory(undodir) == 1 then
			vim.fn.system(string.format("find %s -type f -mtime +10 -delete", undodir))
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
