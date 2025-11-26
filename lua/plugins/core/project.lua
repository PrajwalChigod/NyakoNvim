return {
	"project-manager",
	dir = vim.fn.stdpath("config"),
	event = "VeryLazy",
	keys = {
		{
			"<leader>p",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.switch_to_project(nil, false, true)
				end
			end,
			desc = "Open project in new tab",
		},
		{
			"<leader>ph",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.switch_to_project("vsplit", false, false)
				end
			end,
			desc = "Open project in left split",
		},
		{
			"<leader>pj",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.switch_to_project("belowright split", false, false)
				end
			end,
			desc = "Open project in bottom split",
		},
		{
			"<leader>pk",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.switch_to_project("aboveleft split", false, false)
				end
			end,
			desc = "Open project in top split",
		},
		{
			"<leader>pl",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.switch_to_project("belowright vsplit", false, false)
				end
			end,
			desc = "Open project in right split",
		},
		{
			"<leader>pa",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.add_project()
				end
			end,
			desc = "Add project",
		},
		{
			"<leader>pr",
			function()
				if _G.ProjectManager then
					_G.ProjectManager.remove_project()
				end
			end,
			desc = "Remove project",
		},
	},
	config = function()
		local M = {}

		-- Storage path for projects
		local storage_path = vim.fn.stdpath("data") .. "/projects.json"

		-- ========================================
		-- STORAGE FUNCTIONS
		-- ========================================

		local function ensure_storage_file()
			if vim.fn.filereadable(storage_path) == 0 then
				vim.fn.writefile({ "{}" }, storage_path)
			end
		end

		local function load_projects()
			ensure_storage_file()

			local read_ok, content = pcall(vim.fn.readfile, storage_path)
			if not read_ok or not content or #content == 0 then
				return {}
			end

			local json_ok, data = pcall(vim.json.decode, table.concat(content))
			if not json_ok or type(data) ~= "table" then
				return {}
			end

			return data
		end

		local function save_projects(projects)
			local json_ok, json_str = pcall(vim.json.encode, projects)
			if not json_ok then
				vim.notify("Failed to encode projects: " .. tostring(json_str), vim.log.levels.ERROR)
				return false
			end

			local write_ok, write_err = pcall(vim.fn.writefile, { json_str }, storage_path)
			if not write_ok then
				vim.notify("Failed to write projects file: " .. tostring(write_err), vim.log.levels.ERROR)
				return false
			end

			return true
		end

		-- ========================================
		-- VALIDATION
		-- ========================================

		local function validate_directory(path)
			-- Expand home directory and environment variables
			local expanded = vim.fn.expand(path)

			-- Check if directory exists
			if vim.fn.isdirectory(expanded) ~= 1 then
				return false, "Directory does not exist"
			end

			-- Convert to absolute path
			local absolute = vim.fn.fnamemodify(expanded, ":p")

			-- Remove trailing slash if present
			if absolute:sub(-1) == "/" then
				absolute = absolute:sub(1, -2)
			end

			return true, absolute
		end

		-- ========================================
		-- ADD PROJECT
		-- ========================================

		function M.add_project()
			-- Get current working directory as default
			local cwd = vim.fn.getcwd()

			-- First ask for path
			vim.ui.input({
				prompt = "Project path: ",
				default = cwd,
				completion = "dir",
			}, function(path)
				if not path or path == "" then
					return
				end

				local valid, result = validate_directory(path)
				if not valid then
					vim.notify("Invalid directory: " .. result, vim.log.levels.ERROR)
					return
				end

				-- Then ask for name, with basename of selected path as default
				vim.ui.input({
					prompt = "Project name: ",
					default = vim.fn.fnamemodify(result, ":t"), -- Use selected path's basename
				}, function(name)
					if not name or name == "" then
						return
					end

					local projects = load_projects()
					projects[name] = result

					if save_projects(projects) then
						vim.notify(string.format("Added project '%s' → %s", name, result), vim.log.levels.INFO)
					end
				end)
			end)
		end

		-- ========================================
		-- REMOVE PROJECT
		-- ========================================

		function M.remove_project()
			local projects = load_projects()

			if vim.tbl_isempty(projects) then
				vim.notify("No projects to remove", vim.log.levels.WARN)
				return
			end

			-- Convert to fzf-lua format
			local entries = {}
			for name, path in pairs(projects) do
				table.insert(entries, string.format("%s → %s", name, path))
			end

			-- Sort entries alphabetically
			table.sort(entries)

			require("fzf-lua").fzf_exec(entries, {
				prompt = "Remove Project❯ ",
				winopts = {
					height = 0.50,
					width = 0.70,
				},
				actions = {
					["default"] = function(selected)
						if not selected or #selected == 0 then
							return
						end

						-- Extract project name from selection
						local name = selected[1]:match("^(.-)%s+→")

						-- Confirm deletion
						vim.ui.select({ "Yes", "No" }, {
							prompt = string.format("Remove project '%s'?", name),
						}, function(choice)
							if choice == "Yes" then
								projects[name] = nil
								if save_projects(projects) then
									vim.notify(string.format("Removed project '%s'", name), vim.log.levels.INFO)
								end
							end
						end)
					end,
				},
			})
		end

		-- ========================================
		-- HELPER FUNCTIONS
		-- ========================================

		local function clear_buffers()
			-- Get all buffers
			local buffers = vim.api.nvim_list_bufs()

			for _, buf in ipairs(buffers) do
				-- Only delete loaded, normal buffers (not special buffers)
				if vim.api.nvim_buf_is_loaded(buf) then
					local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
					local modified = vim.api.nvim_buf_get_option(buf, "modified")

					-- Skip special buffers (terminal, quickfix, etc.) and modified buffers
					if buftype == "" and not modified then
						vim.api.nvim_buf_delete(buf, { force = false })
					end
				end
			end
		end

		-- ========================================
		-- SWITCH TO PROJECT
		-- ========================================

		function M.switch_to_project(split_cmd, clear_bufs, new_tab)
			local projects = load_projects()

			if vim.tbl_isempty(projects) then
				vim.notify("No projects available. Add one with <leader>pa", vim.log.levels.WARN)
				return
			end

			-- Convert to fzf-lua format
			local entries = {}
			for name, path in pairs(projects) do
				table.insert(entries, string.format("%s → %s", name, path))
			end

			-- Sort entries alphabetically
			table.sort(entries)

			require("fzf-lua").fzf_exec(entries, {
				prompt = "Projects❯ ",
				winopts = {
					height = 0.50,
					width = 0.70,
				},
				actions = {
					["default"] = function(selected)
						if not selected or #selected == 0 then
							return
						end

						-- Extract path from selection
						local path = selected[1]:match("→%s+(.+)$")

						-- Handle new tab
						if new_tab then
							vim.cmd("tabnew")
							-- Use tcd (tab-local directory) so each tab has its own directory
							vim.cmd("tcd " .. vim.fn.fnameescape(path))
							vim.notify(string.format("Opened project in new tab: %s", path), vim.log.levels.INFO)
							require("fzf-lua").files({ cwd = path })
						-- Handle splits
						elseif split_cmd then
							-- Create split
							vim.cmd(split_cmd)

							-- Change directory in new split (local to window)
							vim.cmd("lcd " .. vim.fn.fnameescape(path))

							-- Open fzf-lua file picker in the new split
							require("fzf-lua").files({ cwd = path })
						else
							-- Clear buffers if requested
							if clear_bufs then
								clear_buffers()
							end

							-- Replace current project (change directory globally)
							vim.cmd("cd " .. vim.fn.fnameescape(path))

							vim.notify(string.format("Switched to: %s", path), vim.log.levels.INFO)

							-- Open file picker
							require("fzf-lua").files({ cwd = path })
						end
					end,
				},
			})
		end

		-- Make functions available to keybindings
		_G.ProjectManager = M
	end,
}
