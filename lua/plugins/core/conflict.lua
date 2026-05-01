return {
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPost",
		cmd = {
			"GitConflictChooseOurs",
			"GitConflictChooseTheirs",
			"GitConflictChooseBoth",
			"GitConflictChooseNone",
			"GitConflictNextConflict",
			"GitConflictPrevConflict",
		},
		config = function()
			require("git-conflict").setup({
				default_mappings = false,
				disable_diagnostics = false,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})

			local function set_conflict_keymaps(buf)
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
				end

				local function choose(action)
					return function()
						vim.cmd("GitConflictChoose" .. action)
						pcall(vim.cmd, "GitConflictNextConflict")
					end
				end

				map("co", choose("Ours"), "Conflict: choose ours")
				map("ct", choose("Theirs"), "Conflict: choose theirs")
				map("cb", choose("Both"), "Conflict: choose both")
				map("cx", choose("None"), "Conflict: choose none")
				map("]x", "<cmd>GitConflictNextConflict<CR>", "Next conflict")
				map("[x", "<cmd>GitConflictPrevConflict<CR>", "Prev conflict")
			end

			local function del_conflict_keymaps(buf)
				for _, lhs in ipairs({ "co", "ct", "cb", "cx", "]x", "[x" }) do
					pcall(vim.keymap.del, "n", lhs, { buffer = buf })
				end
			end

			local augroup = vim.api.nvim_create_augroup("GitConflictMaps", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				pattern = "GitConflictDetected",
				group = augroup,
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					vim.diagnostic.enable(false, { bufnr = buf })
					set_conflict_keymaps(buf)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "GitConflictResolved",
				group = augroup,
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					vim.diagnostic.enable(true, { bufnr = buf })
					del_conflict_keymaps(buf)
				end,
			})
		end,
	},
}
