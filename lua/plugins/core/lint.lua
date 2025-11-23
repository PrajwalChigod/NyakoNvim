return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		-- Configure linters for your programming languages
		lint.linters_by_ft = {
			-- Python
			python = { "ruff" },

			-- JavaScript/TypeScript
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },

			-- Lua
			lua = { "luacheck" },

			-- Systems programming (Rust uses clippy via LSP, C/C++ via clangd)
			-- rust = {}, -- Handled by rust-analyzer LSP
			-- c = {},    -- Handled by clangd LSP
			-- cpp = {},  -- Handled by clangd LSP
			-- zig = {},  -- Basic linting via zls LSP

			-- Configuration and markup
			json = { "jsonlint" },
			yaml = { "yamllint" },
			markdown = { "markdownlint" },

			-- Shell scripting
			bash = { "shellcheck" },
			sh = { "shellcheck" },

			-- Docker
			dockerfile = { "hadolint" },
		}

		-- Auto-lint state (disabled by default)
		local auto_lint_enabled = false

		-- Get linter name for current filetype
		local function get_linter_name()
			local ft = vim.bo.filetype
			local linters = lint.linters_by_ft[ft]
			if linters and #linters > 0 then
				return linters[1]
			end
			return nil
		end

		-- Check if linting is supported for current file
		local function is_lint_supported()
			return get_linter_name() ~= nil
		end

		-- Run linter for current file
		local function run_lint()
			local linter = get_linter_name()
			if not linter then
				vim.notify("No linter configured for " .. vim.bo.filetype .. " files", vim.log.levels.WARN)
				return
			end

			vim.notify("Running " .. linter .. " linter...", vim.log.levels.INFO)
			lint.try_lint()
		end

		-- Toggle auto-lint on save
		local function toggle_auto_lint()
			local linter = get_linter_name()
			if not linter then
				vim.notify("No linter configured for " .. vim.bo.filetype .. " files", vim.log.levels.WARN)
				return
			end

			auto_lint_enabled = not auto_lint_enabled
			vim.notify(
				"Auto-lint " .. (auto_lint_enabled and "enabled" or "disabled") .. " (" .. linter .. ")",
				vim.log.levels.INFO
			)
		end

		-- Auto-lint on save (only when enabled and linter available)
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				if auto_lint_enabled and is_lint_supported() then
					lint.try_lint()
				end
			end,
		})

		-- Create LintInfo command
		vim.api.nvim_create_user_command("LintInfo", function()
			local lint = require("lint")
			local ft = vim.bo.filetype
			local linters = lint.linters_by_ft[ft]

			if not linters or #linters == 0 then
				vim.notify("No linters configured for " .. ft .. " files", vim.log.levels.WARN)
				return
			end

			local info = "Linter info for " .. ft .. ":\n"
			for _, linter_name in ipairs(linters) do
				local linter = lint.linters[linter_name]
				if linter then
					info = info .. "• " .. linter_name .. " (cmd: " .. (linter.cmd or "unknown") .. ")\n"
				else
					info = info .. "• " .. linter_name .. " (not found)\n"
				end
			end

			vim.notify(info, vim.log.levels.INFO)
		end, { desc = "Show linter information" })

		-- Linting keymaps with g* pattern
		vim.keymap.set("n", "gl", run_lint, { desc = "Run linter" })
	end,
}

