return {
	"nvim-mini/mini.surround",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
			require("mini.surround").setup({
				highlight_duration = 0,
				mappings = {
					add = "ys",
					delete = "ds",
					replace = "cs",
					find = "",
					find_left = "",
					highlight = "",
					suffix_last = "",
					suffix_next = "",
				},
				search_method = "cover_or_next",
			})

			vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Add surround to line" })
			vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true, desc = "Add surround" })
		end,
}
