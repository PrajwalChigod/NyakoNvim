return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "x" }, desc = "Comment toggle" },
		{ "gcc", mode = "n", desc = "Comment current line" },
		{ "gco", mode = "n", desc = "Comment below" },
		{ "gcO", mode = "n", desc = "Comment above" },
		{ "gcA", mode = "n", desc = "Comment end of line" },
	},
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = function()
		local cached_pre_hook
		local function lazy_pre_hook(...)
			if not cached_pre_hook then
				local ok, integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
				if not ok then
					return
				end
				cached_pre_hook = integration.create_pre_hook()
			end
			return cached_pre_hook(...)
		end

		return {
			-- Add a space between comment and the line
			padding = true,
			-- Whether the cursor should stay at its position
			sticky = true,
			-- Lines to be ignored while (un)comment (empty lines, whitespace-only)
			ignore = "^(%s*)$",
			-- Enable keybindings
			mappings = {
				basic = false, -- Disabled to replace defaults with custom gc-only mappings
				extra = true, -- Keep insert helpers; gco/gcO/gcA
			},
			-- Function to call before (un)comment (treesitter context awareness)
			pre_hook = lazy_pre_hook,
			-- Function to call after (un)comment
			post_hook = nil,
		}
	end,
	config = function(_, opts)
		require("Comment").setup(opts)
		-- gc-only workflow: recreate linewise toggles and let <Plug> handlers keep context
		vim.keymap.set("n", "gc", "<Plug>(comment_toggle_linewise)", { desc = "Comment toggle linewise" })
		vim.keymap.set("n", "gcc", function()
			return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
				or "<Plug>(comment_toggle_linewise_count)"
		end, { expr = true, desc = "Comment toggle current line" })

		-- Visual & Select mode commenting - auto-detect linewise vs blockwise
		vim.keymap.set("x", "gc", function()
			local mode = vim.fn.visualmode()
			if mode == "\22" or mode == "^V" then
				-- Blockwise visual mode (Ctrl-V)
				return "<Plug>(comment_toggle_blockwise_visual)"
			end
			-- Linewise or characterwise visual mode
			return "<Plug>(comment_toggle_linewise_visual)"
		end, { expr = true, desc = "Comment selection" })
	end,
}
