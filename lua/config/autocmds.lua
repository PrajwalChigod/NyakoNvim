-- Auto-open alpha dashboard
local alpha_group = vim.api.nvim_create_augroup("AlphaDashboard", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = alpha_group,
	pattern = "LazyVimStarted",
	callback = function()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

		-- Update footer with actual startup time
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
		pcall(alpha.redraw)
	end,
})

-- ===============================================
-- FILE HANDLING & EDITOR BEHAVIOR
-- ===============================================

local general_group = vim.api.nvim_create_augroup("GeneralSettings", { clear = true })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = general_group,
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = general_group,
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = general_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = general_group,
	callback = function()
		vim.cmd("tabdo wincmd =")
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

-- Note: Format on save is now handled by conform.nvim plugin

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
