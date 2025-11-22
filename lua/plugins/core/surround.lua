return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features

	keys = {
		{ "ys", mode = "n", desc = "Add surround" },
		{ "ds", mode = "n", desc = "Delete surround" },
		{ "cs", mode = "n", desc = "Change surround" },
		{ "S", mode = "v", desc = "Surround selection" },
	},

	config = function()
		require("nvim-surround").setup({
			-- Use all default keymaps
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

