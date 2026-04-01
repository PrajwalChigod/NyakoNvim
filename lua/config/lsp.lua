local function prepend_mason_bin_to_path()
	local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
	if vim.fn.isdirectory(mason_bin) == 0 then
		return
	end

	local path = vim.env.PATH or ""
	if string.find(path, mason_bin, 1, true) then
		return
	end

	local path_sep = vim.fn.has("win32") == 1 and ";" or ":"
	vim.env.PATH = path ~= "" and (mason_bin .. path_sep .. path) or mason_bin
end

prepend_mason_bin_to_path()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local bufnr = event.buf
		local opts = { buf = bufnr, silent = true }

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

		vim.keymap.set("n", "gd", function()
			require("fzf-lua").lsp_definitions()
		end, vim.tbl_extend("force", opts, { desc = "LSP Definitions (fzf)" }))

		vim.keymap.set("n", "gD", function()
			require("fzf-lua").lsp_declarations({ jump1 = false })
		end, vim.tbl_extend("force", opts, { desc = "LSP Declarations (fzf)" }))

		vim.keymap.set("n", "gO", function()
			require("fzf-lua").lsp_document_symbols()
		end, vim.tbl_extend("force", opts, { desc = "LSP Document Symbols (fzf)" }))

		vim.keymap.set("n", "gW", function()
			require("fzf-lua").lsp_workspace_symbols()
		end, vim.tbl_extend("force", opts, { desc = "LSP Workspace Symbols (fzf)" }))

		vim.keymap.set("n", "gh", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
		vim.keymap.set(
			"n",
			"gs",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "LSP Signature Help" })
		)

		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local servers = {
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
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
	ty = {
		cmd = { "ty", "server" },
		filetypes = { "python" },
		root_markers = {
			"ty.toml",
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			".git",
		},
		settings = {
			ty = {
				diagnosticMode = "openFilesOnly",
				showSyntaxErrors = true,
				completions = {
					autoImport = true,
				},
				configuration = {
					rules = {
						["invalid-method-override"] = "warn",
						["not-iterable"] = "warn",
						["not-subscriptable"] = "warn",
						["possibly-missing-attribute"] = "warn",
						["possibly-missing-import"] = "warn",
						["possibly-unresolved-reference"] = "warn",
						["unresolved-import"] = "warn",
						["unresolved-reference"] = "warn",
					},
					src = {
						exclude = {
							"**/node_modules",
							"**/__pycache__",
							"**/.venv",
							"**/venv",
						},
					},
				},
			},
		},
		init_options = {
			logLevel = "error",
		},
	},
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		root_markers = { "tsconfig.json", "package.json", ".git" },
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literals",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = false,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "literals",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = false,
				},
			},
		},
	},
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", ".git" },
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
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
	},
	zls = {
		cmd = { "zls" },
		filetypes = { "zig" },
		root_markers = { "build.zig", ".git" },
	},
	bashls = {
		cmd = { "bash-language-server", "start" },
		filetypes = { "sh", "bash" },
		root_markers = { ".git" },
		settings = {
			bashIde = {
				globPattern = "**/*@(.sh|.inc|.bash|.command)",
				includeAllWorkspaceSymbols = true,
			},
		},
	},
	taplo = {
		cmd = { "taplo", "lsp", "stdio" },
		filetypes = { "toml" },
		root_markers = { ".git" },
		settings = {
			taplo = {
				configFile = {
					enabled = true,
				},
			},
		},
	},
}

for name, config in pairs(servers) do
	config.capabilities = capabilities
	vim.lsp.config[name] = config
end

local lsp_filetypes = {
	lua = { "lua_ls" },
	python = { "ty" },
	javascript = { "ts_ls" },
	typescript = { "ts_ls" },
	javascriptreact = { "ts_ls" },
	typescriptreact = { "ts_ls" },
	rust = { "rust_analyzer" },
	c = { "clangd" },
	cpp = { "clangd" },
	objc = { "clangd" },
	objcpp = { "clangd" },
	cuda = { "clangd" },
	proto = { "clangd" },
	zig = { "zls" },
	sh = { "bashls" },
	bash = { "bashls" },
	toml = { "taplo" },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(lsp_filetypes),
	callback = function(args)
		local servers_for_ft = lsp_filetypes[args.match]
		if not servers_for_ft then
			return
		end
		for _, server_name in ipairs(servers_for_ft) do
			vim.lsp.enable(server_name)
		end
	end,
})
