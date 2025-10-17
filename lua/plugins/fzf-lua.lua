return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
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
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Find word under cursor",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "Find WORD under cursor",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").grep_curbuf()
			end,
			desc = "Grep current buffer",
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
			"<leader>f:",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Command history",
		},
		{
			"<leader>f/",
			function()
				require("fzf-lua").search_history()
			end,
			desc = "Search history",
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
	},
	config = function()
		-- Defer heavy setup until first actual use
		vim.defer_fn(function()
			require("fzf-lua").setup({
				winopts = {
					height = 0.85,
					width = 0.80,
					row = 0.35,
					col = 0.50,
					border = "rounded",
				},
				previewers = {
					bat = {
						cmd = "bat",
						args = "--style=numbers,changes --color always --line-range :500", -- Limit preview to 500 lines
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
					cmd = "rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g \"!.git\" -g \"!node_modules\" -g \"!.next\" -g \"!target\" -g \"!build\" -g \"!dist\" -g \"!.venv\" -g \"!venv\" -g \"!.cache\"",
				},
				oldfiles = {
					prompt = "History❯ ",
					cwd_only = true,
				},
			})
		end, 0)
	end,
}
