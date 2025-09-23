local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Disable Python providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.colorcolumn = "120"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files and backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Performance
vim.opt.timeout = true
-- Timeout moved to performance section below
vim.opt.ttimeoutlen = 10 -- 10ms for key codes (like <Esc>)

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Better completion (updated below in performance section)

-- File encoding
opt.fileencoding = "utf-8"

-- Performance optimizations
opt.updatetime = 200 -- Faster CursorHold events (default 4000ms)
opt.redrawtime = 1500 -- Prevent slow redraws from hanging editor
opt.synmaxcol = 200 -- Limit syntax highlighting on long lines
-- opt.lazyredraw = true
opt.ttyfast = true -- Fast terminal connection assumption

-- Better diff performance
opt.diffopt:append("internal,algorithm:patience")

-- Improved completion
opt.completeopt = "menuone,noselect,preview" -- Better than just "menuone,noselect"

-- Fix timeout conflict
opt.timeoutlen = 300 -- Match which-key timeout for consistency

-- Invisible characters
opt.list = true
opt.listchars = { tab = "⋅ ", trail = "·", nbsp = "␣" }

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Disable netrw for oil.nvim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Performance: Disable built-in plugins for faster startup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_man = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

-- Performance: Improve diff algorithm
vim.opt.diffopt:append("linematch:60")

-- Performance: Better grep program
if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
end
