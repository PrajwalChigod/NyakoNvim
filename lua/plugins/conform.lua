return {
	"stevearc/conform.nvim",
	event = { "BufReadPost", "BufWritePre", "BufNewFile" },
	cmd = { "ConformInfo" },
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
			format_on_save = false, -- Disabled by default
		})

		-- Format on save state (disabled by default)
		local format_on_save_enabled = false

		-- Get formatter name for current filetype
		local function get_formatter_name()
			local ft = vim.bo.filetype
			local formatters = conform.formatters_by_ft[ft]
			if formatters and #formatters > 0 then
				return formatters[1]
			end
			return "LSP"
		end

		-- Check if formatting is supported for current file
		local function is_format_supported()
			local ft = vim.bo.filetype
			return conform.formatters_by_ft[ft] ~= nil
		end

		-- Format file using external formatter only
		local function format_file()
			local formatter = get_formatter_name()
			vim.notify("Formatting with " .. formatter .. "...", vim.log.levels.INFO)
			conform.format({ lsp_format = "fallback" })
		end

		-- Format range
		local function format_range()
			local formatter = get_formatter_name()
			conform.format({ lsp_format = "fallback" })
		end

		-- Toggle format on save
		local function toggle_format_on_save()
			local formatter = get_formatter_name()
			format_on_save_enabled = not format_on_save_enabled
			vim.notify(
				"Format on save " .. (format_on_save_enabled and "enabled" or "disabled") .. " (" .. formatter .. ")",
				vim.log.levels.INFO
			)
		end

		-- Auto-format on save (only when enabled)
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				if format_on_save_enabled then
					conform.format({ lsp_format = "fallback" })
				end
			end,
		})

		-- Formatting keymaps with g* pattern
		vim.keymap.set("n", "gf", format_file, { desc = "Format file" })
		vim.keymap.set("v", "gf", format_range, { desc = "Format range" })
	end,
}

