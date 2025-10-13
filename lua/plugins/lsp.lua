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

			-- Helper function to use fzf-lua with fallback
			local function fzf_or_fallback(fzf_fn, fallback_fn)
				return function()
					local ok, fzf = pcall(require, "fzf-lua")
					if ok then
						fzf[fzf_fn]()
					else
						fallback_fn()
					end
				end
			end

			-- LSP keymaps using LspAttach autocmd (modern Neovim 0.8+ pattern)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local opts = { buffer = bufnr, silent = true }

					-- LSP keymaps with fzf-lua and fallback to built-in
					vim.keymap.set(
						"n",
						"grr",
						fzf_or_fallback("lsp_references", vim.lsp.buf.references),
						vim.tbl_extend("force", opts, { desc = "LSP References" })
					)

					vim.keymap.set(
						"n",
						"gra",
						fzf_or_fallback("lsp_code_actions", vim.lsp.buf.code_action),
						vim.tbl_extend("force", opts, { desc = "LSP Code Actions" })
					)

					vim.keymap.set("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP Rename" }))

					vim.keymap.set(
						"n",
						"gri",
						fzf_or_fallback("lsp_implementations", vim.lsp.buf.implementation),
						vim.tbl_extend("force", opts, { desc = "LSP Implementations" })
					)

					vim.keymap.set(
						"n",
						"grt",
						fzf_or_fallback("lsp_typedefs", vim.lsp.buf.type_definition),
						vim.tbl_extend("force", opts, { desc = "LSP Type Definitions" })
					)

					-- Additional useful LSP keymaps
					vim.keymap.set(
						"n",
						"gd",
						fzf_or_fallback("lsp_definitions", vim.lsp.buf.definition),
						vim.tbl_extend("force", opts, { desc = "LSP Definitions" })
					)

					vim.keymap.set(
						"n",
						"gD",
						fzf_or_fallback("lsp_declarations", vim.lsp.buf.declaration),
						vim.tbl_extend("force", opts, { desc = "LSP Declarations" })
					)

					vim.keymap.set(
						"n",
						"gS",
						fzf_or_fallback("lsp_document_symbols", vim.lsp.buf.document_symbol),
						vim.tbl_extend("force", opts, { desc = "LSP Document Symbols" })
					)

					vim.keymap.set(
						"n",
						"gW",
						fzf_or_fallback("lsp_workspace_symbols", vim.lsp.buf.workspace_symbol),
						vim.tbl_extend("force", opts, { desc = "LSP Workspace Symbols" })
					)

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

			-- LSP Performance: Reduce logging (configurable via environment variable)
			local valid_levels = { "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }
			local log_level = vim.env.NVIM_LSP_LOG_LEVEL or "ERROR"
			if not vim.tbl_contains(valid_levels, log_level) then
				vim.notify(
					string.format("Invalid NVIM_LSP_LOG_LEVEL '%s', using ERROR", log_level),
					vim.log.levels.WARN
				)
				log_level = "ERROR"
			end
			vim.lsp.set_log_level(log_level)

			-- Standard capabilities with error handling
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				capabilities = blink.get_lsp_capabilities(capabilities)
			else
				vim.notify("blink.cmp not available, using default LSP capabilities", vim.log.levels.INFO)
			end

			-- Per-server configurations
			local servers = {
				-- Lua (Neovim configuration)
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false, -- Greatly improves performance
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
								typeCheckingMode = "strict", -- Use "off" for performance
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								autoImportCompletions = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},

				-- JavaScript/TypeScript
				ts_ls = {
					-- IMPORTANT: For large projects, create a `tsconfig.json` or `jsconfig.json` at your project root.
					-- This allows the server to understand your project structure and avoid excessive file scanning.
					-- Example `jsconfig.json`:
					-- {
					--   "compilerOptions": {
					--     "module": "commonjs",
					--     "target": "es2020"
					--   },
					--   "exclude": ["node_modules"]
					-- }
					init_options = {
						maxTsServerMemory = 4096, -- Limit memory usage for performance
						preferences = {
							includeCompletionsForModuleExports = true,
							includeCompletionsWithInsertText = true,
							importModuleSpecifierPreference = "relative",
							quotePreference = "double",
						},
					},
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "none",
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = false,
								includeInlayEnumMemberValueHints = false,
							},
							suggest = {
								includeCompletionsForModuleExports = true,
							},
							updateImportsOnFileMove = { enabled = "always" },
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "none",
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = false,
								includeInlayEnumMemberValueHints = false,
							},
							suggest = {
								includeCompletionsForModuleExports = true,
							},
							updateImportsOnFileMove = { enabled = "always" },
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
								enable = false, -- Disabled for performance, run manually
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
						"--offset-encoding=utf-16", -- Important for compatibility with some plugins
						"--pch-storage=memory", -- Faster but uses more RAM
					},
					init_options = {
						clangdFileStatus = true,
						usePlaceholders = true,
						completeUnimported = true,
						semanticHighlighting = true,
					},
				},

				-- Zig
				zls = {
					settings = {
						zls = {
							enable_autofix = false, -- Disable for performance
							enable_snippets = true,
							enable_ast_check_diagnostics = true,
							enable_build_on_save = false, -- Better performance, build manually
						},
					},
				},

				-- Bash
				bashls = {
					filetypes = { "sh", "bash", "zsh" },
					settings = {
						bashIde = {
							globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
						},
					},
				},

				-- TOML
				taplo = {
					settings = {
						evenBetterToml = {
							schema = {
								enabled = true,
								catalogs = {
									"https://www.schemastore.org/api/json/catalog.json",
								},
							},
						},
					},
				},
			}

			-- Setup servers in a loop with error handling
			for server_name, config in pairs(servers) do
				local server_config = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 300, -- Debounce for performance
					},
				}, config)

				local ok, err = pcall(function()
					require("lspconfig")[server_name].setup(server_config)
				end)

				if not ok then
					vim.notify(
						string.format("Failed to setup LSP server '%s': %s", server_name, err),
						vim.log.levels.ERROR
					)
				end
			end
		end,
	},
}
