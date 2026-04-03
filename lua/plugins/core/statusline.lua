return {
	"nvim-mini/mini.statusline",
	event = "VimEnter",
	init = function()
		vim.o.laststatus = 3
	end,
	config = function()
		local statusline = require("mini.statusline")

		local function git_branch()
			if statusline.is_truncated(40) then
				return ""
			end

			local summary = vim.b.minigit_summary
			return summary and summary.head_name or ""
		end

		local function diff_summary()
			if statusline.is_truncated(75) then
				return ""
			end

			local summary = vim.b.minidiff_summary
			if not summary then
				return ""
			end

			local parts = {}
			if (summary.add or 0) > 0 then
				table.insert(parts, "+" .. summary.add)
			end
			if (summary.change or 0) > 0 then
				table.insert(parts, "~" .. summary.change)
			end
			if (summary.delete or 0) > 0 then
				table.insert(parts, "-" .. summary.delete)
			end

			return table.concat(parts, " ")
		end

		local function project_root_relative_name()
			local buf_name = vim.api.nvim_buf_get_name(0)
			if buf_name == "" then
				return "[No Name]"
			end

			if statusline.is_truncated(120) then
				return vim.fn.fnamemodify(buf_name, ":t")
			end

			local root = vim.fs.root(buf_name, { ".git" }) or vim.fn.getcwd()
			local prefix = root:sub(-1) == "/" and root or (root .. "/")
			if vim.startswith(buf_name, prefix) then
				return buf_name:sub(#prefix + 1)
			end

			return vim.fn.fnamemodify(buf_name, ":.")
		end

		local function fileinfo()
			if vim.bo.buftype ~= "" then
				return ""
			end

			local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
			local filetype = vim.bo.filetype
			return table.concat(vim.tbl_filter(function(item)
				return item ~= ""
			end, { encoding, filetype }), " ")
		end

		statusline.setup({
			use_icons = false,
			content = {
				active = function()
					local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
					local git = git_branch()
					local diff = diff_summary()
					local filename = project_root_relative_name()
					local info = fileinfo()

					return statusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff } },
						"%<",
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=",
						{ hl = "MiniStatuslineFileinfo", strings = { info, "%P", "%l:%c" } },
					})
				end,
				inactive = function()
					return statusline.combine_groups({
						{ hl = "MiniStatuslineInactive", strings = { project_root_relative_name() } },
						"%=",
						{ hl = "MiniStatuslineInactive", strings = { "%l:%c" } },
					})
				end,
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("MiniStatuslineDisable", { clear = true }),
			pattern = { "fyler" },
			callback = function(args)
				vim.b[args.buf].ministatusline_disable = true
			end,
		})
	end,
}
