return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>s", "ysiw", desc = "Surround word", remap = true },
		{ "<leader>S", "ysiW", desc = "Surround WORD", remap = true },
		{ "<leader>sl", "yss", desc = "Surround line", remap = true },
		{ "<leader>sc", "cs", desc = "Change surround", remap = true },
		{ "<leader>sd", "ds", desc = "Delete surround", remap = true },
	},
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
			keymaps = {
				insert = false, -- Disabled to allow <C-s> for save
				insert_line = false, -- Disabled to allow <C-s> for save
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = false, -- Disable S in visual mode (use for flash.nvim)
				visual_line = "gS",
				delete = false, -- Disabled, use <leader>sd instead
				change = false, -- Disabled, use <leader>sc instead
				change_line = "cS",
			},
			aliases = {
				["a"] = ">",
				["b"] = ")",
				["B"] = "}",
				["r"] = "]",
				["q"] = { '"', "'", "`" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
			highlight = {
				duration = 0,
			},
			move_cursor = "begin",
			indent_lines = function(start, stop)
				local b = vim.bo
				-- Only re-indent the selection if a formatter is set up already
				if
					start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp)
				then
					vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
				end
			end,
		})
	end,
}

