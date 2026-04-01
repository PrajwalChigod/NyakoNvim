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

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			local essential_parsers = {
				"bash",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"vim",
				"vimdoc",
			}
			local available_parsers = {}
			for _, lang in ipairs(ts.get_available()) do
				available_parsers[lang] = true
			end

			ts.setup()

			if vim.fn.executable("tree-sitter") == 1 then
				ts.install(essential_parsers)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("nyako-treesitter", { clear = true }),
				pattern = "*",
				callback = function(args)
					local bufnr = args.buf
					vim.wo[0][0].foldmethod = "indent"
					vim.wo[0][0].foldexpr = "0"

					if vim.bo[bufnr].buftype ~= "" or is_large_file(bufnr) then
						return
					end

					local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
					if not lang or lang == "" then
						return
					end

					if not available_parsers[lang] then
						return
					end

					local ok = pcall(vim.treesitter.start, bufnr, lang)
					if not ok then
						if vim.fn.executable("tree-sitter") == 1 then
							ts.install({ lang })
						end
						return
					end

					if #vim.api.nvim_get_runtime_file("queries/" .. lang .. "/indents.scm", true) > 0 then
						vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end

					if #vim.api.nvim_get_runtime_file("queries/" .. lang .. "/folds.scm", true) > 0 then
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo[0][0].foldmethod = "expr"
					end
				end,
				desc = "Enable Treesitter features",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local keymaps = {
				{ { "x", "o" }, "af", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@function.outer", "textobjects"), "Select function outer" },
				{ { "x", "o" }, "if", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@function.inner", "textobjects"), "Select function inner" },
				{ { "x", "o" }, "ac", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@class.outer", "textobjects"), "Select class outer" },
				{ { "x", "o" }, "ic", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@class.inner", "textobjects"), "Select class inner" },
				{ { "x", "o" }, "ap", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@parameter.outer", "textobjects"), "Select parameter outer" },
				{ { "x", "o" }, "ip", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@parameter.inner", "textobjects"), "Select parameter inner" },
				{ { "x", "o" }, "ab", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@block.outer", "textobjects"), "Select block outer" },
				{ { "x", "o" }, "ib", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@block.inner", "textobjects"), "Select block inner" },
				{ { "x", "o" }, "al", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@loop.outer", "textobjects"), "Select loop outer" },
				{ { "x", "o" }, "il", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@loop.inner", "textobjects"), "Select loop inner" },
				{ { "x", "o" }, "aa", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@attribute.outer", "textobjects"), "Select attribute outer" },
				{ { "x", "o" }, "ia", textobject_fn("nvim-treesitter-textobjects.select", "select_textobject", "@attribute.inner", "textobjects"), "Select attribute inner" },
				{ { "n", "x", "o" }, "]f", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@function.outer", "textobjects"), "Next function start" },
				{ { "n", "x", "o" }, "[f", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@function.outer", "textobjects"), "Previous function start" },
				{ { "n", "x", "o" }, "]F", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@function.outer", "textobjects"), "Next function end" },
				{ { "n", "x", "o" }, "[F", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@function.outer", "textobjects"), "Previous function end" },
				{ { "n", "x", "o" }, "]c", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@class.outer", "textobjects"), "Next class start" },
				{ { "n", "x", "o" }, "[c", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@class.outer", "textobjects"), "Previous class start" },
				{ { "n", "x", "o" }, "]C", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@class.outer", "textobjects"), "Next class end" },
				{ { "n", "x", "o" }, "[C", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@class.outer", "textobjects"), "Previous class end" },
				{ { "n", "x", "o" }, "]p", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@parameter.outer", "textobjects"), "Next parameter start" },
				{ { "n", "x", "o" }, "[p", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@parameter.outer", "textobjects"), "Previous parameter start" },
				{ { "n", "x", "o" }, "]P", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@parameter.outer", "textobjects"), "Next parameter end" },
				{ { "n", "x", "o" }, "[P", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@parameter.outer", "textobjects"), "Previous parameter end" },
				{ { "n", "x", "o" }, "]k", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_start", "@block.outer", "textobjects"), "Next block start" },
				{ { "n", "x", "o" }, "[k", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_start", "@block.outer", "textobjects"), "Previous block start" },
				{ { "n", "x", "o" }, "]K", textobject_fn("nvim-treesitter-textobjects.move", "goto_next_end", "@block.outer", "textobjects"), "Next block end" },
				{ { "n", "x", "o" }, "[K", textobject_fn("nvim-treesitter-textobjects.move", "goto_previous_end", "@block.outer", "textobjects"), "Previous block end" },
				{ "n", "]S", textobject_fn("nvim-treesitter-textobjects.swap", "swap_next", "@parameter.inner", "textobjects"), "Swap next parameter" },
				{ "n", "[S", textobject_fn("nvim-treesitter-textobjects.swap", "swap_previous", "@parameter.inner", "textobjects"), "Swap previous parameter" },
				{ "n", "]s", textobject_fn("nvim-treesitter-textobjects.swap", "swap_next", "@function.outer", "textobjects"), "Swap next function" },
				{ "n", "[s", textobject_fn("nvim-treesitter-textobjects.swap", "swap_previous", "@function.outer", "textobjects"), "Swap previous function" },
			}

			for _, keymap in ipairs(keymaps) do
				vim.keymap.set(keymap[1], keymap[2], keymap[3], { desc = keymap[4] })
			end
		end,
	},
}
