return {
	"numToStr/Comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("Comment").setup({
			-- Add a space between comment and the line
			padding = true,
			-- Whether the cursor should stay at its position
			sticky = true,
			-- Lines to be ignored while (un)comment (empty lines, whitespace-only)
			ignore = "^(%s*)$",
			-- LHS of toggle mappings in NORMAL mode
			toggler = {
				line = "gcc", -- Line-comment toggle keymap
				block = "gbc", -- Block-comment toggle keymap
			},
			-- LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				line = "gc", -- Line-comment keymap
				block = "gb", -- Block-comment keymap
			},
			-- LHS of extra mappings
			extra = {
				above = "gcO", -- Add comment on the line above
				below = "gco", -- Add comment on the line below
				eol = "gcA", -- Add comment at the end of line
			},
			-- Enable keybindings
			mappings = {
				basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
			},
			-- Function to call before (un)comment (treesitter context awareness)
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			-- Function to call after (un)comment
			post_hook = nil,
		})

		-- Visual mode commenting
		vim.keymap.set("v", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment selection" })
		vim.keymap.set("v", "gb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Block comment selection" })
	end,
}

