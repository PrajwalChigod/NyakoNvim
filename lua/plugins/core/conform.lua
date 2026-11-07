return {
	"stevearc/conform.nvim",
	-- Load before the first save too, so format-on-save works without pressing gf first.
	event = "BufWritePre",
	cmd = { "ConformInfo", "Format", "FormatToggle" },
	keys = {
		{ "gf", mode = "n", desc = "Format file" },
		{ "gf", mode = "v", desc = "Format range" },
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Python
				python = { "ruff" },

				-- Lua
				lua = { "stylua" },

				-- JavaScript/TypeScript
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },

				-- Web technologies
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },

				-- Systems programming (Rust uses LSP formatting)
				c = { "clang-format" },
				cpp = { "clang-format" },
				zig = { "zig_fmt" },

				-- Go (goimports fixes imports, gofumpt formats)
				go = { "goimports", "gofumpt" },

				-- Shell scripting
				sh = { "shfmt" },
				bash = { "shfmt" },

				-- Configuration files
				toml = { "taplo" },
				sql = { "sqlfluff" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- The only format-on-save hook; :FormatToggle switches it via the global below.
			format_on_save = function()
				if not vim.g.conform_format_on_save_enabled then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			notify_on_error = true,
			notify_no_formatters = false,
			log_level = vim.log.levels.ERROR,
		})

		if vim.g.conform_format_on_save_enabled == nil then
			vim.g.conform_format_on_save_enabled = true
		end

		-- Get formatter name for current filetype
		local function get_formatter_name()
			local ft = vim.bo.filetype
			local formatters = conform.formatters_by_ft[ft]
			if formatters and #formatters > 0 then
				return formatters[1]
			end
			return "LSP"
		end

		local function format_file()
			local formatter = get_formatter_name()
			vim.notify("Formatting with " .. formatter .. "...", vim.log.levels.INFO)
			conform.format({ lsp_format = "fallback" })
		end

		local function format_range()
			conform.format({ lsp_format = "fallback" })
		end

		local function toggle_format_on_save()
			local formatter = get_formatter_name()
			vim.g.conform_format_on_save_enabled = not vim.g.conform_format_on_save_enabled
			vim.notify(
				"Format on save " .. (vim.g.conform_format_on_save_enabled and "enabled" or "disabled") .. " (" .. formatter .. ")",
				vim.log.levels.INFO
			)
		end

		vim.api.nvim_create_user_command("Format", function()
			if vim.fn.mode():match("[vV\22]") then
				format_range()
			else
				format_file()
			end
		end, { desc = "Format current buffer or selection" })

		vim.api.nvim_create_user_command("FormatToggle", toggle_format_on_save, { desc = "Toggle format on save" })

		vim.keymap.set("n", "gf", format_file, { desc = "Format file" })
		vim.keymap.set("v", "gf", format_range, { desc = "Format range" })
	end,
}
