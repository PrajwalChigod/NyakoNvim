local BAT_PREVIEW_MAX_LINES = 300
local MAX_FILE_SIZE = 1024 * 1024

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		-- Find (by name/location)
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "Find git files",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Find recent files",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").help_tags()
			end,
			desc = "Help tags",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>fm",
			function()
				require("fzf-lua").marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fj",
			function()
				require("fzf-lua").jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>fl",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume last search",
		},
		-- Search (by content)
		{
			"<leader>sb",
			function()
				require("fzf-lua").grep_curbuf()
			end,
			desc = "Grep current buffer",
		},
		{
			"<leader>sw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Search word under cursor",
		},
		{
			"<leader>sW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "Search WORD under cursor",
		},
		{
			"<leader>sg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>sc",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Command history",
		},
		{
			"<leader>sh",
			function()
				require("fzf-lua").search_history()
			end,
			desc = "Search history",
		},
	},
	config = function()
		require("fzf-lua").setup({
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				border = "rounded",
				preview = {
					delay = 100,
					scrollbar = false,
				},
			},
			previewers = {
				bat = {
					cmd = "bat",
					args = string.format("--style=numbers,changes --color always --line-range :%d", BAT_PREVIEW_MAX_LINES),
				},
			},
			files = {
				cmd = "fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .next --exclude target --exclude build --exclude dist --exclude .venv --exclude venv --exclude .cache",
				prompt = "Files❯ ",
				multiprocess = true,
				git_icons = true,
				file_icons = true,
			},
			git = {
				files = {
					prompt = "GitFiles❯ ",
					cmd = "git ls-files --exclude-standard",
				},
			},
			grep = {
				prompt = "Rg❯ ",
				cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden -g \"!.git\" -g \"!node_modules\" -g \"!.next\" -g \"!target\" -g \"!build\" -g \"!dist\" -g \"!.venv\" -g \"!venv\" -g \"!.cache\"",
			},
			oldfiles = {
				prompt = "History❯ ",
				cwd_only = true,
			},
			colorschemes = {
				prompt = "Colorschemes❯ ",
				winopts = {
					height = 0.60,
					width = 0.50,
				},
				live_preview = true,
			},
		})
	end,
}
