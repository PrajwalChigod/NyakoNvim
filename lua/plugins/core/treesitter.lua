return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Only install essential parsers upfront for faster startup
				-- Other parsers will be auto-installed on-demand
				ensure_installed = {
					"lua", -- Neovim config
					"vim", -- Vim commands
					"vimdoc", -- Vim help files
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- List of parsers to ignore installing (for "all")
				ignore_install = {},

				highlight = {
					enable = true,
					-- Disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 50 * 1024 -- 50 KB (~1500 lines)
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true,
					-- Disable for Python (conflicts with python-indent plugin)
					disable = { "python" },
				},

				-- Incremental selection based on the named nodes from the grammar
				incremental_selection = {
					enable = true,
					-- Disable for large files to prevent lag
					disable = function(lang, buf)
						local max_lines = 5000
						return vim.api.nvim_buf_line_count(buf) > max_lines
					end,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-S-space>",
						node_decremental = "<M-space>",
					},
				},

			})

			-- Note: Folding is configured in options.lua using indent method
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		keys = {
			-- Text object selections
			{ "af", mode = { "x", "o" } },
			{ "if", mode = { "x", "o" } },
			{ "ac", mode = { "x", "o" } },
			{ "ic", mode = { "x", "o" } },
			{ "ap", mode = { "x", "o" } },
			{ "ip", mode = { "x", "o" } },
			{ "ab", mode = { "x", "o" } },
			{ "ib", mode = { "x", "o" } },
			{ "al", mode = { "x", "o" } },
			{ "il", mode = { "x", "o" } },
			{ "aa", mode = { "x", "o" } },
			{ "ia", mode = { "x", "o" } },
			-- Movement
			{ "]f" }, { "[f" }, { "]F" }, { "[F" },
			{ "]c" }, { "[c" }, { "]C" }, { "[C" },
			{ "]p" }, { "[p" }, { "]P" }, { "[P" },
			{ "]k" }, { "[k" }, { "]K" }, { "[K" },
			-- Swap
			{ "]S" }, { "[S" },
			{ "]s" }, { "[s" },
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj
						-- Disable for large files to prevent lag
						disable = function(lang, buf)
							local max_lines = 5000
							return vim.api.nvim_buf_line_count(buf) > max_lines
						end,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ap"] = "@parameter.outer",
							["ip"] = "@parameter.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["aa"] = "@attribute.outer",
							["ia"] = "@attribute.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]p"] = "@parameter.outer",
							["]k"] = "@block.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]P"] = "@parameter.outer",
							["]K"] = "@block.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[p"] = "@parameter.outer",
							["[k"] = "@block.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[P"] = "@parameter.outer",
							["[K"] = "@block.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["]S"] = "@parameter.inner",
							["]s"] = "@function.outer",
						},
						swap_previous = {
							["[S"] = "@parameter.inner",
							["[s"] = "@function.outer",
						},
					},
				},
			})
		end,
	},
}

