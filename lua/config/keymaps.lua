local keymap = vim.keymap.set

-- ===============================================
-- ESSENTIAL
-- ===============================================

-- Exit insert mode with jj
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode" })


-- File explorer
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>-", "<CMD>Oil .<CR>", { desc = "Open current directory" })
keymap("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })



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

keymap("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
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
