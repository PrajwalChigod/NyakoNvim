return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
		pre_save = nil, -- a function to call before saving the session
		save_empty = false, -- don't save if there are no open file buffers
	},
	init = function()
		-- Auto-restore session when opening nvim with a directory or no args
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
			callback = function()
				local argc = vim.fn.argc()
				-- Load if no args, or if single arg is a directory
				if not vim.g.started_with_stdin then
					if argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1) then
						require("persistence").load()
					end
				end
			end,
			nested = true,
		})
	end,
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore session for current directory",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Stop session recording (don't save on exit)",
		},
	},
}
