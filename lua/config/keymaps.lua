local keymap = vim.keymap.set

-- ===============================================
-- ESSENTIAL
-- ===============================================

-- Exit insert mode with jj
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- File explorer (Oil)
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open file explorer" })

-- Quick access to config
keymap("n", "<leader>ec", function()
	vim.cmd("cd ~/.config/nvim")
	require("fzf-lua").files({ cwd = "~/.config/nvim" })
end, { desc = "Edit Neovim config" })

keymap("n", "<leader>er", function()
	-- Save current file if modified
	if vim.bo.modified then
		vim.cmd("write")
	end
	-- Reload config
	vim.cmd("source $MYVIMRC")
	-- Sync plugins
	vim.cmd("Lazy sync")
	vim.notify("Config reloaded and plugins synced!", vim.log.levels.INFO)
end, { desc = "Reload config and sync plugins" })



-- ===============================================
-- WINDOW & BUFFER NAVIGATION
-- ===============================================

-- Navigate between splits
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom split" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top split" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })


-- ===============================================
-- MOVEMENT & SEARCH
-- ===============================================

-- Better page up/down (keep cursor centered)
keymap("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

-- Keep search terms in the middle
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- ===============================================
-- TEXT EDITING & MANIPULATION (Medium Usage)
-- ===============================================

-- Better indenting (stays in visual mode)
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z", { desc = "Join lines" })


-- ===============================================
-- TAB MANAGEMENT
-- ===============================================

keymap("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tb", "<cmd>tab sb<CR>", { desc = "Open buffer in new tab" })

-- Enhanced tab workflow with scope.nvim
keymap("n", "<leader>tf", function()
  vim.cmd("tabnew")
  -- Optional: open a file picker in the new tab
  require("fzf-lua").files()
end, { desc = "New tab with file picker" })

-- ===============================================
-- TERMINAL OPERATIONS
-- ===============================================

-- Terminal mode escape
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable Q key (ex mode)
keymap("n", "Q", "<nop>")

-- ===============================================
-- FOLD OPERATIONS (Restrict to essential only)
-- ===============================================
-- Keep: za (toggle), zA (toggle recursive), zd (delete), zD (delete recursive)
-- Disable all other fold commands
local fold_cmds = { "zc", "zC", "zo", "zO", "zm", "zM", "zr", "zR", "zv", "zx", "zX", "zf", "zE", "zi", "zn", "zN", "zj", "zk" }
for _, cmd in ipairs(fold_cmds) do
	keymap("n", cmd, "<nop>", { desc = "Disabled fold command" })
end
