return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			-- Direct LSP configuration without mason-lspconfig
			-- Mason only provides the LSP binaries, we configure them manually

			-- LSP keymaps using LspAttach autocmd (modern Neovim 0.8+ pattern)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local opts = { buffer = bufnr, silent = true }

					-- Override default LSP keymaps to use fzf-lua
					vim.keymap.set("n", "grr", function()
						require("fzf-lua").lsp_references({ jump1 = false })
					end, vim.tbl_extend("force", opts, { desc = "LSP References (fzf)" }))

					vim.keymap.set("n", "gra", function()
						require("fzf-lua").lsp_code_actions()
					end, vim.tbl_extend("force", opts, { desc = "LSP Code Actions (fzf)" }))

					vim.keymap.set("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP Rename" }))

					vim.keymap.set("n", "gri", function()
						require("fzf-lua").lsp_implementations({ jump1 = false })
					end, vim.tbl_extend("force", opts, { desc = "LSP Implementations (fzf)" }))

					vim.keymap.set("n", "grt", function()
						require("fzf-lua").lsp_typedefs({ jump1 = false })
					end, vim.tbl_extend("force", opts, { desc = "LSP Type Definitions (fzf)" }))

					-- Additional useful LSP keymaps
					vim.keymap.set("n", "gd", function()
						require("fzf-lua").lsp_definitions()
					end, vim.tbl_extend("force", opts, { desc = "LSP Definitions (fzf)" }))

					vim.keymap.set("n", "gD", function()
						require("fzf-lua").lsp_declarations({ jump1 = false })
					end, vim.tbl_extend("force", opts, { desc = "LSP Declarations (fzf)" }))

					vim.keymap.set("n", "gS", function()
						require("fzf-lua").lsp_document_symbols()
					end, vim.tbl_extend("force", opts, { desc = "LSP Document Symbols (fzf)" }))

					vim.keymap.set("n", "gW", function()
						require("fzf-lua").lsp_workspace_symbols()
					end, vim.tbl_extend("force", opts, { desc = "LSP Workspace Symbols (fzf)" }))

					-- Built-in LSP functions
					vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
					vim.keymap.set(
						"n",
						"gs",
						vim.lsp.buf.signature_help,
						vim.tbl_extend("force", opts, { desc = "LSP Signature Help" })
					)

					-- Insert mode LSP keymaps with <C-g>* pattern
					vim.keymap.set("i", "<C-g>K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover (insert mode)" }))
					vim.keymap.set("i", "<C-g>s", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP Signature Help (insert mode)" }))

					-- Set omnifunc for buffer
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
			})

			-- LSP Performance: Reduce logging and limit workspace scanning
			vim.lsp.set_log_level("ERROR") -- Only log errors, not info/debug
			vim.lsp.config['*'] = {
				flags = {
					debounce_text_changes = 300, -- Increase from default 150ms for large projects
					allow_incremental_sync = true,
				},
				on_init = function(client)
					if client.server_capabilities then
						client.server_capabilities.workspace = client.server_capabilities.workspace or {}
						client.server_capabilities.workspace.workspaceFolders = {
							supported = false,
							changeNotifications = false,
						}
					end
				end,
			}
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			local servers = {
				-- Lua (Neovim configuration)
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},

				-- Python
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "strict",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								autoImportCompletions = true,
								diagnosticMode = "openFilesOnly",
								reportMissingImports = true,
								reportUnusedImport = true,
								reportUnusedVariable = { "all" },
								reportUndefinedVariable = true,
								reportOptionalMemberAccess = true,
								reportOptionalSubscript = true,
								reportOptionalIterable = true,
								reportPrivateImportUsage = true,
								reportIncompatibleMethodOverride = true,
							},
						},
					},
				},

				-- JavaScript/TypeScript
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literals", -- Only for literals, not all arguments
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false, -- Often obvious from context
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = false, -- Rarely needed
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "literals", -- Only for literals, not all arguments
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false, -- Often obvious from context
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = false, -- Rarely needed
							},
						},
					},
				},

				-- Rust
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = false,
								loadOutDirsFromCheck = false,
								runBuildScripts = false,
							},
							checkOnSave = {
								allFeatures = false,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},

				-- C/C++
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},

				-- Zig
				zls = {
					-- Basic Zig LSP configuration
				},

				-- Bash/Shell
				bashls = {
					settings = {
						bashIde = {
							globPattern = "**/*@(.sh|.inc|.bash|.command)",
							includeAllWorkspaceSymbols = true,
						},
					},
				},

				-- TOML
				taplo = {
					settings = {
						taplo = {
							configFile = {
								enabled = true,
							},
						},
					},
				},
			}

			-- Lua Language Server
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
				capabilities = capabilities,
				settings = servers.lua_ls.settings,
			}

			-- Python (basedpyright)
			vim.lsp.config.basedpyright = {
				cmd = { "basedpyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
				capabilities = capabilities,
				settings = servers.basedpyright.settings,
			}

			-- TypeScript/JavaScript
			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				root_markers = { "tsconfig.json", "package.json", ".git" },
				capabilities = capabilities,
				settings = servers.ts_ls.settings,
			}

			-- Rust
			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				root_markers = { "Cargo.toml", ".git" },
				capabilities = capabilities,
				settings = servers.rust_analyzer.settings,
			}

			-- C/C++
			vim.lsp.config.clangd = {
				cmd = servers.clangd.cmd,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
				capabilities = capabilities,
				init_options = servers.clangd.init_options,
			}

			-- Zig
			vim.lsp.config.zls = {
				cmd = { "zls" },
				filetypes = { "zig" },
				root_markers = { "build.zig", ".git" },
				capabilities = capabilities,
			}

			-- Bash
			vim.lsp.config.bashls = {
				cmd = { "bash-language-server", "start" },
				filetypes = { "sh", "bash" },
				root_markers = { ".git" },
				capabilities = capabilities,
				settings = servers.bashls.settings,
			}

			-- TOML
			vim.lsp.config.taplo = {
				cmd = { "taplo", "lsp", "stdio" },
				filetypes = { "toml" },
				root_markers = { ".git" },
				capabilities = capabilities,
				settings = servers.taplo.settings,
			}

			-- Enable LSP servers on-demand per filetype for faster startup
			local lsp_filetypes = {
				lua = "lua_ls",
				python = "basedpyright",
				javascript = "ts_ls",
				typescript = "ts_ls",
				javascriptreact = "ts_ls",
				typescriptreact = "ts_ls",
				rust = "rust_analyzer",
				c = "clangd",
				cpp = "clangd",
				objc = "clangd",
				objcpp = "clangd",
				cuda = "clangd",
				proto = "clangd",
				zig = "zls",
				sh = "bashls",
				bash = "bashls",
				toml = "taplo",
			}

			-- Auto-enable LSP when opening relevant filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = vim.tbl_keys(lsp_filetypes),
				callback = function(args)
					local lsp_name = lsp_filetypes[args.match]
					if lsp_name then
						vim.lsp.enable(lsp_name)
					end
				end,
			})
		end,
	},
}
