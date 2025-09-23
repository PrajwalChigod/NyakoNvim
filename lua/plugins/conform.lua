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

		-- Auto-indent function
		local function auto_indent()
			local save_cursor = vim.api.nvim_win_get_cursor(0)
			vim.cmd("normal! gg=G")
			vim.api.nvim_win_set_cursor(0, save_cursor)
			vim.notify("File auto-indented", vim.log.levels.INFO)
		end

		-- Format file with auto-indent
		local function format_file()
			local formatter = get_formatter_name()
			-- Auto-indent first, then format
			auto_indent()
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

		-- Formatting keymaps with <leader>m* pattern
		vim.keymap.set("n", "<leader>mf", format_file, { desc = "Format file (indent + format)" })
		vim.keymap.set("v", "<leader>mr", format_range, { desc = "Format range" })
		vim.keymap.set("n", "<leader>mt", toggle_format_on_save, { desc = "Toggle format on save" })
		vim.keymap.set("n", "<leader>ma", auto_indent, { desc = "Auto-indent file" })
		vim.keymap.set("n", "<leader>mi", function()
			local formatter = get_formatter_name()
			vim.notify("Current formatter: " .. formatter .. " for " .. vim.bo.filetype, vim.log.levels.INFO)
		end, { desc = "Show formatter info" })
		vim.keymap.set("n", "<leader>mc", "<cmd>ConformInfo<CR>", { desc = "Conform info" })
	end,
}

