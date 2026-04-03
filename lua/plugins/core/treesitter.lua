local max_filesize = 50 * 1024
local max_lines = 5000

local function is_large_file(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name ~= "" then
		local ok, stats = pcall(vim.uv.fs_stat, name)
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end

	return vim.api.nvim_buf_line_count(bufnr) > max_lines
end

local function textobject_fn(module, method, query, query_group)
	return function()
		local bufnr = vim.api.nvim_get_current_buf()
		if is_large_file(bufnr) then
			return
		end

		require(module)[method](query, query_group)
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

local function set_default_fold_opts(bufnr)
	local winid = vim.fn.bufwinid(bufnr)
	if winid == -1 then
		return nil
	end

	vim.wo[winid].foldmethod = "indent"
	vim.wo[winid].foldexpr = "0"
	return winid
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = "VimEnter",
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			local available_parsers = {}
			local query_support = {}

			for _, lang in ipairs(ts.get_available()) do
				available_parsers[lang] = true
			end

			ts.setup()

			local function enable_treesitter(bufnr)
				if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
					return
				end

				local winid = set_default_fold_opts(bufnr)
				if vim.bo[bufnr].buftype ~= "" or is_large_file(bufnr) then
					return
				end

				local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
				if not lang or lang == "" or not available_parsers[lang] then
					return
				end

				local ok = pcall(vim.treesitter.start, bufnr, lang)
				if not ok then
					return
				end

				local support = query_support[lang]
				if not support then
					support = {
						indents = #vim.api.nvim_get_runtime_file("queries/" .. lang .. "/indents.scm", true) > 0,
						folds = #vim.api.nvim_get_runtime_file("queries/" .. lang .. "/folds.scm", true) > 0,
					}
					query_support[lang] = support
				end

				if support.indents then
					vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				if winid and support.folds then
					vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[winid].foldmethod = "expr"
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("nyako-treesitter", { clear = true }),
				pattern = "*",
				callback = function(args)
					enable_treesitter(args.buf)
				end,
				desc = "Enable Treesitter features",
			})

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				enable_treesitter(bufnr)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = textobject_keys,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})
		end,
	},
}
