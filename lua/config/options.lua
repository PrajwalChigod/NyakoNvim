local opt = vim.opt

opt.number = true
opt.relativenumber = true
-- Set leader key
vim.g.mapleader = " "

-- Disable Python providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0

-- Disable netrw for oil.nvim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = false

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
opt.scrolloff = 4
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

-- File encoding
opt.fileencoding = "utf-8"

-- Performance optimizations
opt.updatetime = 200 -- Balanced CursorHold events and diagnostics (default 4000ms)
opt.redrawtime = 1500 -- Prevent slow redraws from hanging editor
opt.synmaxcol = 180 -- Limit syntax highlighting on long lines

-- opt.lazyredraw = true
-- Note: ttyfast is deprecated in Neovim and has no effect

-- Better diff performance
opt.diffopt:append("internal,algorithm:patience")

-- Improved completion
opt.completeopt = "menuone,noselect,preview" -- Better than just "menuone,noselect"

-- Fix timeout conflict
opt.timeoutlen = 250 -- Snappier which-key response for better UX

-- Invisible characters
opt.list = true
opt.listchars = { tab = "⋅ ", trail = "·", nbsp = "␣" }

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Folding (using indent method - simpler and more reliable)
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = false -- Don't fold by default, but folds are available

-- Note: Built-in plugin disabling is handled in lua/config/lazy.lua for consistency

-- Performance: Improve diff algorithm
vim.opt.diffopt:append("linematch:60")

-- Performance: Better grep program
if vim.fn.executable("rg") == 1 then
	vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
end
