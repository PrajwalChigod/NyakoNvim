return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
		pre_save = function()
			-- Clean up old session files for current directory before saving new one
			local session_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/")
			local cwd = vim.fn.getcwd()
			local cwd_pattern = cwd:gsub("/", "%%")
			local session_files = vim.fn.glob(session_dir .. cwd_pattern .. "*.vim", false, true)

			-- Delete all existing sessions for this directory (we'll keep only the new one)
			for _, file in ipairs(session_files) do
				vim.fn.delete(file)
			end
		end,
		save_empty = false, -- don't save if there are no open file buffers
	},
	init = function()
		-- Clean up old sessions (older than 30 days)
		local function cleanup_old_sessions()
			local session_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/")
			local session_files = vim.fn.glob(session_dir .. "*.vim", false, true)
			local now = os.time()
			local thirty_days = 30 * 24 * 60 * 60 -- 30 days in seconds

			for _, file in ipairs(session_files) do
				local stat = vim.loop.fs_stat(file)
				if stat and (now - stat.mtime.sec) > thirty_days then
					vim.fn.delete(file)
				end
			end
		end

		-- Track last cleanup time
		local cleanup_marker = vim.fn.stdpath("state") .. "/last_session_cleanup"
		local function should_run_weekly_cleanup()
			if vim.fn.filereadable(cleanup_marker) == 1 then
				local last_cleanup = tonumber(vim.fn.readfile(cleanup_marker)[1]) or 0
				local seven_days = 7 * 24 * 60 * 60
				return (os.time() - last_cleanup) > seven_days
			end
			return true -- First run
		end

		local function mark_cleanup_done()
			vim.fn.writefile({ tostring(os.time()) }, cleanup_marker)
		end

		-- Run cleanup on VimLeavePre (when closing nvim)
		vim.api.nvim_create_autocmd("VimLeavePre", {
			group = vim.api.nvim_create_augroup("persistence_cleanup", { clear = true }),
			callback = function()
				if should_run_weekly_cleanup() then
					cleanup_old_sessions()
					mark_cleanup_done()
				end
			end,
		})

		-- Auto-restore session or open oil when opening nvim with a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
			callback = function()
				local argc = vim.fn.argc()
				-- Only handle when single arg is a directory (nvim .)
				if not vim.g.started_with_stdin and argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
					local session_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/")
					local cwd = vim.fn.getcwd()
					-- Convert path to persistence's format: replace / with %
					local cwd_pattern = cwd:gsub("/", "%%")

					-- Check if any session file exists for this directory (with or without branch)
					local has_session = false
					local session_files = vim.fn.glob(session_dir .. cwd_pattern .. "*.vim", false, true)
					if #session_files > 0 then
						has_session = true
					end

					if has_session then
						-- Session exists, load it
						require("persistence").load()
						-- Close oil/directory buffer after loading session
						vim.schedule(function()
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								if vim.api.nvim_buf_is_loaded(buf) then
									local name = vim.api.nvim_buf_get_name(buf)
									-- Delete if it's a directory buffer or oil buffer
									if vim.fn.isdirectory(name) == 1 or name:match("^oil://") then
										vim.api.nvim_buf_delete(buf, { force = true })
									end
								end
							end
						end)
					else
						-- No session, open oil
						vim.schedule(function()
							require("oil").open()
						end)
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
