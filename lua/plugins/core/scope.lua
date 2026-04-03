return {
	"tiagovla/scope.nvim",
	event = { "TabNew", "SessionLoadPost" },
	config = function()
		require("scope").setup()
	end,
}
