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

			-- LSP keymaps using modern vim.keymap.set
			local function setup_lsp_keymaps(bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- Direct mappings for go-to operations (always use fzf)
				vim.keymap.set("n", "gd", function()
					require("fzf-lua").lsp_definitions({ jump1 = false })
				end, opts)
				vim.keymap.set("n", "gr", function()
					require("fzf-lua").lsp_references({ jump1 = false })
				end, opts)
				vim.keymap.set("n", "gi", function()
					require("fzf-lua").lsp_implementations({ jump1 = false })
				end, opts)
				vim.keymap.set("n", "gy", function()
					require("fzf-lua").lsp_typedefs({ jump1 = false })
				end, opts)
				vim.keymap.set("n", "gD", function()
					require("fzf-lua").lsp_declarations({ jump1 = false })
				end, opts)

				-- Other LSP actions with leader prefix
				vim.keymap.set("n", "ga", function()
					require("fzf-lua").lsp_code_actions()
				end, opts)
				vim.keymap.set("n", "gW", function()
					require("fzf-lua").lsp_workspace_symbols()
				end, opts)

				-- Built-in LSP functions
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "gS", function()
					require("fzf-lua").lsp_document_symbols()
				end, opts)
				vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
			end

			-- On attach function
			local function on_attach(client, bufnr)
				setup_lsp_keymaps(bufnr)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			end

			-- Enhanced capabilities with completion
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- LSP server configurations for all your languages
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
							},
						},
					},
				},

				-- JavaScript/TypeScript
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
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

			-- Setup LSP servers
			local lspconfig = require("lspconfig")
			for server, config in pairs(servers) do
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}

