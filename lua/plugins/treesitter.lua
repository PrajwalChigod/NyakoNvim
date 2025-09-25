return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Languages you primarily work with
				ensure_installed = {
					-- Core languages
					"python",
					"javascript",
					"typescript",
					"tsx",
					"c",
					"cpp",
					"rust",
					"zig",

					-- Supporting languages
					"lua", -- For Neovim config
					"bash", -- Shell scripts
					"json", -- Config files
					"yaml", -- Config files
					"toml", -- Rust/Python configs
					"html", -- Web development
					"css", -- Web development
					"markdown", -- Documentation
					"dockerfile", -- Container configs
					"sql", -- Database queries
					"regex", -- Regex patterns
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
						local max_filesize = 100 * 1024 -- 100 KB
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
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<M-space>",
					},
				},

				-- Treesitter-based folding
				fold = {
					enable = true,
				},
			})

			-- Enable treesitter folding
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Don't fold by default
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj
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
							["<localleader>sp"] = "@parameter.inner",
							["<localleader>sf"] = "@function.outer",
						},
						swap_previous = {
							["<localleader>sP"] = "@parameter.inner",
							["<localleader>sF"] = "@function.outer",
						},
					},
				},
			})
		end,
	},
}

