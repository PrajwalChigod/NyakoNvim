local function textobject_fn(module, method, query, group)
	return function()
		if require("utils.treesitter").is_large_file(vim.api.nvim_get_current_buf()) then
			return
		end
		require(module)[method](query, group)
	end
end

local textobject_keys = {
	{ "af", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@function.outer", "textobjects"), mode = { "x", "o" }, desc = "Select function outer" },
	{ "if", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@function.inner", "textobjects"), mode = { "x", "o" }, desc = "Select function inner" },
	{ "ac", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@class.outer", "textobjects"), mode = { "x", "o" }, desc = "Select class outer" },
	{ "ic", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@class.inner", "textobjects"), mode = { "x", "o" }, desc = "Select class inner" },
	{ "ap", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@parameter.outer", "textobjects"), mode = { "x", "o" }, desc = "Select parameter outer" },
	{ "ip", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@parameter.inner", "textobjects"), mode = { "x", "o" }, desc = "Select parameter inner" },
	{ "ab", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@block.outer", "textobjects"), mode = { "x", "o" }, desc = "Select block outer" },
	{ "ib", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@block.inner", "textobjects"), mode = { "x", "o" }, desc = "Select block inner" },
	{ "al", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@loop.outer", "textobjects"), mode = { "x", "o" }, desc = "Select loop outer" },
	{ "il", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@loop.inner", "textobjects"), mode = { "x", "o" }, desc = "Select loop inner" },
	{ "aa", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@attribute.outer", "textobjects"), mode = { "x", "o" }, desc = "Select attribute outer" },
	{ "ia", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@attribute.inner", "textobjects"), mode = { "x", "o" }, desc = "Select attribute inner" },
	{ "]f", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@function.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next function start" },
	{ "[f", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@function.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous function start" },
	{ "]F", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@function.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next function end" },
	{ "[F", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@function.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous function end" },
	{ "]c", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@class.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next class start" },
	{ "[c", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@class.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous class start" },
	{ "]C", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@class.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next class end" },
	{ "[C", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@class.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous class end" },
	{ "]p", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@parameter.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next parameter start" },
	{ "[p", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@parameter.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous parameter start" },
	{ "]P", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@parameter.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next parameter end" },
	{ "[P", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@parameter.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous parameter end" },
	{ "]k", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@block.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next block start" },
	{ "[k", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@block.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous block start" },
	{ "]K", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@block.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Next block end" },
	{ "[K", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@block.outer", "textobjects"), mode = { "n", "x", "o" }, desc = "Previous block end" },
	{ "]S", textobject_fn("nvim-treesitter-textobjects.swap", "swap_next", "@parameter.inner", "textobjects"), mode = "n", desc = "Swap next parameter" },
	{ "[S", textobject_fn("nvim-treesitter-textobjects.swap", "swap_previous", "@parameter.inner", "textobjects"), mode = "n", desc = "Swap previous parameter" },
	{ "]s", textobject_fn("nvim-treesitter-textobjects.swap", "swap_next", "@function.outer", "textobjects"), mode = "n", desc = "Swap next function" },
	{ "[s", textobject_fn("nvim-treesitter-textobjects.swap", "swap_previous", "@function.outer", "textobjects"), mode = "n", desc = "Swap previous function" },
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = textobject_keys,
		opts = {
			select = { enable = true, lookahead = true, keymaps = {} },
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {},
				goto_previous_start = {},
				goto_next_end = {},
				goto_previous_end = {},
			},
			swap = { enable = true, swap_next = {}, swap_previous = {} },
		},
	},
}
