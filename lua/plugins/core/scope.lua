return {
	"tiagovla/scope.nvim",
	event = "UIEnter",
	config = function()
		vim.defer_fn(function()
			require("scope").setup()
		end, 100)
	end,
}
