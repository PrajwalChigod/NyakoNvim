return {
	{
		"nvim-mini/mini.diff",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "▎", change = "▎", delete = "▁" },
				},
			})
			-- Defaults (unchanged): ]h / [h jump to next/prev changed hunk,
			-- ]H / [H jump to last/first hunk in the buffer.
		end,
	},
}
