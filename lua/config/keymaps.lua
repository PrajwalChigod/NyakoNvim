local quickfix = require("config.quickfix")
local keymap = vim.keymap.set

-- ===============================================
-- ESSENTIAL
-- ===============================================

-- Exit insert mode with jj
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode" })



-- Clear highlights and return to normal mode with Esc
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("i", "<Esc>", "<Esc><cmd>nohlsearch<CR>", { desc = "Exit insert mode and clear highlights" })
keymap("v", "<Esc>", "<Esc><cmd>nohlsearch<CR>", { desc = "Exit visual mode and clear highlights" })

-- Save all buffers with Ctrl+s (works in all modes, like VS Code)
keymap("n", "<C-s>", "<cmd>wa<CR>", { desc = "Save all buffers" })
keymap("i", "<C-s>", "<Esc><cmd>wa<CR>", { desc = "Exit insert mode and save all buffers" })
keymap("v", "<C-s>", "<Esc><cmd>wa<CR>", { desc = "Exit visual mode and save all buffers" })


-- ===============================================
-- CONFIG OPERATIONS
-- ===============================================

-- Edit Neovim config
keymap("n", "<leader>ce", function()
	vim.cmd("cd ~/.config/nvim")
	require("fzf-lua").files({ cwd = "~/.config/nvim" })
end, { desc = "Edit Neovim config" })

-- Sync plugins. (lazy.nvim can't re-source the config in a running session;
-- restart Neovim to pick up config changes.)
keymap("n", "<leader>cr", function()
	if vim.bo.modified then
		vim.cmd("write")
	end
	vim.cmd("Lazy sync")
end, { desc = "Sync plugins" })

keymap("n", "<leader>cp", function()
	require("fzf-lua").colorschemes()
end, { desc = "Colorscheme Picker" })

-- ===============================================
-- EDITOR OPERATIONS
-- ===============================================

-- Ergonomic line navigation (H/L override default viewport jumps)
keymap("n", "H", "^", { desc = "Go to first non-blank character" })
keymap("v", "H", "^", { desc = "Go to first non-blank character" })

keymap("n", "L", "$", { desc = "Go to end of line" })
keymap("v", "L", "$", { desc = "Go to end of line" })

-- Alt key operations (insert mode only)
keymap("i", "<A-D>", "<C-o>d$", { desc = "Delete to end of line" })
keymap("i", "<A-c>", "<C-o>yy", { desc = "Yank/copy current line" })
keymap("i", "<A-p>", "<C-o>p", { desc = "Paste after cursor" })

-- ===============================================
-- MOVEMENT & SEARCH
-- ===============================================

-- Quick jump to end of file (mirrors gg for top)
keymap("n", "gG", "G", { desc = "Go to end of file" })

-- Better page up/down (keep cursor centered)
keymap("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

-- Keep search terms in the middle
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Disable f/F/t/T motions (using Flash.nvim instead)
keymap("n", "f", "<nop>", { desc = "Disabled (use Flash 's' instead)" })
keymap("n", "F", "<nop>", { desc = "Disabled (use Flash 's' instead)" })
keymap("n", "t", "<nop>", { desc = "Disabled (use Flash 's' instead)" })
keymap("n", "T", "<nop>", { desc = "Disabled (use Flash 's' instead)" })
keymap("n", ",", "<nop>", { desc = "Disabled (using ; as localleader)" })

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
-- QUICKFIX OPERATIONS
-- ===============================================

keymap("n", "<localleader>q", quickfix.toggle, { desc = "Toggle quickfix list" })
keymap("n", "<localleader>qa", quickfix.add_line, { desc = "Add line to quickfix list" })
keymap("n", "<leader>qc", quickfix.clear, { desc = "Clear quickfix list" })

-- ===============================================
-- SESSION
-- ===============================================

keymap("n", "<leader>qs", function()
	require("config.session").load()
end, { desc = "Restore session for current directory" })

keymap("n", "<leader>ql", function()
	require("config.session").load({ last = true })
end, { desc = "Restore last session" })

keymap("n", "<leader>qd", function()
	require("config.session").stop()
end, { desc = "Stop session recording (don't save on exit)" })

keymap("n", "<leader>qx", function()
	require("config.session").delete()
end, { desc = "Delete current session" })


-- ===============================================
-- TAB MANAGEMENT
-- ===============================================

keymap("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tb", "<cmd>tab sb<CR>", { desc = "Open buffer in new tab" })

keymap("n", "<leader>tf", function()
  vim.cmd("tabnew")
  -- Optional: open a file picker in the new tab
  require("fzf-lua").files()
end, { desc = "New tab with file picker" })

keymap("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

keymap("n", "<leader>tr", function()
  vim.ui.input({
    prompt = "Tab name: ",
    default = vim.t.tab_name or "",
  }, function(name)
    if name == nil then
      return -- cancelled
    end
    vim.t.tab_name = name ~= "" and name or nil
    vim.cmd("redrawstatus")
    vim.cmd("redrawtabline")
  end)
end, { desc = "Rename current tab" })

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

-- ===============================================
-- LOAD CUSTOM KEYMAPS
-- ===============================================
-- Load user-defined keymaps from lua/config/extras/keymaps.lua (gitignored)
-- Run :SetupCustom to create the template file
local custom_keymaps_path = vim.fn.stdpath("config") .. "/lua/config/extras/keymaps.lua"
if vim.fn.filereadable(custom_keymaps_path) == 1 then
	local ok, err = pcall(dofile, custom_keymaps_path)
	if not ok then
		vim.notify("Error loading custom keymaps: " .. tostring(err), vim.log.levels.ERROR)
	end
end
