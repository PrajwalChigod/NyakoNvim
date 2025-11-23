local quickfix = require("config.quickfix")
local keymap = vim.keymap.set

-- ===============================================
-- ESSENTIAL
-- ===============================================

-- Exit insert mode with jj
keymap("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Insert mode navigation
keymap("i", "<A-.>", "<C-o>$", { desc = "End of line" })
keymap("i", "<A-,>", "<C-o>^", { desc = "First non-blank character" })
keymap("i", "<A-0>", "<C-o>0", { desc = "Beginning of line" })
keymap("i", "<A-b>", "<C-o>b", { desc = "Previous word" })
keymap("i", "<A-w>", "<C-o>w", { desc = "Next word start" })
keymap("i", "<A-e>", "<C-o>e", { desc = "Next word end" })

-- Insert mode directional movement
keymap("i", "<A-h>", "<Left>", { desc = "Move left" })
keymap("i", "<A-j>", "<Down>", { desc = "Move down" })
keymap("i", "<A-k>", "<Up>", { desc = "Move up" })
keymap("i", "<A-l>", "<Right>", { desc = "Move right" })

-- Insert mode quick edits
keymap("i", "<A-d>", "<C-o>dw", { desc = "Delete word forward" })
keymap("i", "<A-u>", "<C-u>", { desc = "Delete to line start" })
keymap("i", "<A-o>", "<C-o>o", { desc = "Insert line below" })
keymap("i", "<A-O>", "<C-o>O", { desc = "Insert line above" })

-- Insert mode character deletion
keymap("i", "<A-x>", "<Del>", { desc = "Delete character under cursor" })

-- Insert mode undo/redo
keymap("i", "<A-z>", "<C-o>u", { desc = "Undo" })
keymap("i", "<A-y>", "<C-o><C-r>", { desc = "Redo" })

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

-- Reload config and sync plugins
keymap("n", "<leader>cr", function()
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

-- Quick jump to end of file (mirrors gg for top)
keymap("n", "gG", "G", { desc = "Go to end of file" })

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
-- QUICKFIX OPERATIONS
-- ===============================================

keymap("n", "<localleader>q", quickfix.toggle, { desc = "Toggle quickfix list" })
keymap("n", "<localleader>qa", quickfix.add_line, { desc = "Add line to quickfix list" })
keymap("n", "<leader>qc", quickfix.clear, { desc = "Clear quickfix list" })


-- ===============================================
-- TAB MANAGEMENT
-- ===============================================

keymap("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
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
-- LSP PERFORMANCE TOGGLE
-- ===============================================

-- Toggle LSP workspace scanning (for large projects)
-- Use this when you need project-wide rename/references but experience slowness
keymap("n", "<leader>lw", function()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		vim.notify("No LSP clients attached", vim.log.levels.WARN)
		return
	end

	for _, client in ipairs(clients) do
		if client.server_capabilities and client.server_capabilities.workspace then
			local current = client.server_capabilities.workspace.workspaceFolders
			if current and current.supported == false then
				-- Enable workspace scanning
				client.server_capabilities.workspace.workspaceFolders = {
					supported = true,
					changeNotifications = true,
				}
				vim.notify("LSP Workspace scanning ENABLED for " .. client.name, vim.log.levels.INFO)
			else
				-- Disable workspace scanning
				client.server_capabilities.workspace.workspaceFolders = {
					supported = false,
					changeNotifications = false,
				}
				vim.notify("LSP Workspace scanning DISABLED for " .. client.name, vim.log.levels.INFO)
			end
		end
	end

	-- Restart LSP to apply changes
	vim.defer_fn(function()
		vim.cmd("LspRestart")
		vim.notify("LSP restarted to apply workspace settings", vim.log.levels.INFO)
	end, 100)
end, { desc = "Toggle LSP Workspace Scanning" })

-- ===============================================
-- FOLD OPERATIONS (Restrict to essential only)
-- ===============================================
-- Keep: za (toggle), zA (toggle recursive), zd (delete), zD (delete recursive)
-- Disable all other fold commands
local fold_cmds = { "zc", "zC", "zo", "zO", "zm", "zM", "zr", "zR", "zv", "zx", "zX", "zf", "zE", "zi", "zn", "zN", "zj", "zk" }
for _, cmd in ipairs(fold_cmds) do
	keymap("n", cmd, "<nop>", { desc = "Disabled fold command" })
end
