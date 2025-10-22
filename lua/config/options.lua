local opt = vim.opt

-- ===============================================
-- PERFORMANCE: Disable built-in plugins
-- ===============================================
-- Disable built-in plugins that cause startup overhead (for large projects)
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1 -- Matching parens cause lag in large files
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

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
opt.cursorline = false -- Disable for large projects (reduces redraws)
opt.colorcolumn = "120"

-- Blinking Cursor
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

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
opt.updatetime = 500 -- Increased for large projects (default 4000ms, was 200ms)
opt.redrawtime = 1500 -- Prevent slow redraws from hanging editor
opt.synmaxcol = 180 -- Limit syntax highlighting on long lines

-- Large project optimizations
opt.maxmempattern = 5000 -- Limit regex memory usage (default: 1000)
opt.regexpengine = 2 -- NFA engine for predictable performance

-- Disable slow UI features
opt.cursorcolumn = false
opt.showcmd = false
opt.ruler = false -- Lualine shows this anyway

-- File finding optimization - ignore common large/irrelevant directories
opt.wildignore:append({
	"**/node_modules/**",
	"**/.git/**",
	"**/target/**",
	"**/build/**",
	"**/dist/**",
	"**/__pycache__/**",
	"**/.venv/**",
	"**/venv/**",
	"**/.next/**",
	"**/.cache/**",
	"**/media/**",
	"**/static/media/**",
	"**/public/media/**",
})

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
