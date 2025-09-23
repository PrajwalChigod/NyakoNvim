local keymap = vim.keymap.set

-- ===============================================
-- GENERAL EDITING
-- ===============================================

-- Exit insert mode with jk
keymap("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ===============================================
-- MOVEMENT & NAVIGATION
-- ===============================================

-- Better page up/down (keep cursor centered)
keymap("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

-- Keep search terms in the middle
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z", { desc = "Join lines" })

-- ===============================================
-- WINDOW MANAGEMENT
-- ===============================================


-- Navigate between splits
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom split" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top split" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

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
-- BUFFER MANAGEMENT
-- ===============================================

keymap("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- ===============================================
-- TEXT EDITING & MANIPULATION
-- ===============================================

-- Better indenting (stays in visual mode)
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- ===============================================
-- CLIPBOARD OPERATIONS
-- ===============================================

-- Better paste (doesn't replace clipboard)
keymap("x", "<leader>p", [["_dP]], { desc = "Paste without replacing clipboard" })

-- Copy to system clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Delete without copying to clipboard
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copying" })

-- ===============================================
-- FILE OPERATIONS
-- ===============================================

-- File explorer (Oil.nvim)
keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>-", "<CMD>Oil .<CR>", { desc = "Open current directory" })
keymap("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })

-- Save and quit operations
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })
keymap("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })
keymap("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Force quit without saving" })

-- ===============================================
-- MISC & UTILITY
-- ===============================================

-- Disable Q key (ex mode)
keymap("n", "Q", "<nop>")

-- Terminal mode escape
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ===============================================
-- TERMINAL (TOGGLETERM)
-- ===============================================

-- Toggle terminal (primary binding is in plugin config)
keymap("n", "<localleader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
keymap("n", "<localleader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Toggle vertical terminal" })
