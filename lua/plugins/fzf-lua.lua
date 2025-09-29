-- lua/plugins/fzf-lua.lua
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
		local fzf = require("fzf-lua")
		local actions = require("fzf-lua.actions")
		fzf.setup({
			-- Global options
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				border = "rounded",
				preview = {
					default = "bat",
					border = "border",
					wrap = "nowrap",
					hidden = "nohidden",
					vertical = "down:45%",
					horizontal = "right:50%",
					layout = "flex",
					flip_columns = 120,
					title = true,
					title_pos = "center",
					scrollbar = "float",
					scrolloff = "-2",
					scrollchars = { "█", "" },
					delay = 100,
				},
				fullscreen = false,
				preview_opts = "hidden",
			},
			keymap = {
				builtin = {
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					["<F3>"] = "toggle-preview-wrap",
					["<F4>"] = "toggle-preview",
					["<F5>"] = "toggle-preview-ccw",
					["<F6>"] = "toggle-preview-cw",
					["<S-down>"] = "preview-page-down",
					["<S-up>"] = "preview-page-up",
					["<S-left>"] = "preview-page-reset",
				},
				fzf = {
					["ctrl-z"] = "abort",
					["ctrl-u"] = "unix-line-discard",
					["ctrl-f"] = "half-page-down",
					["ctrl-b"] = "half-page-up",
					["ctrl-a"] = "beginning-of-line",
					["ctrl-e"] = "end-of-line",
					["alt-a"] = "select-all",
					["alt-d"] = "deselect-all",
				},
			},
			actions = {
				files = {
					["default"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["alt-q"] = actions.file_sel_to_qf,
					["alt-l"] = actions.file_sel_to_ll,
				},
				buffers = {
					["default"] = actions.buf_edit,
					["ctrl-s"] = actions.buf_split,
					["ctrl-v"] = actions.buf_vsplit,
					["ctrl-t"] = actions.buf_tabedit,
				},
			},
			fzf_opts = {
				["--ansi"] = "",
				["--info"] = "inline",
				["--height"] = "100%",
				["--layout"] = "reverse",
			},
			previewers = {
				cat = {
					cmd = "cat",
					args = "--number",
				},
				bat = {
					cmd = "bat",
					args = "--style=numbers,changes --color always",
				},
				head = {
					cmd = "head",
					args = nil,
				},
				git_diff = {
					cmd_deleted = "git show HEAD:./%s",
					cmd_modified = "git diff HEAD %s",
					cmd_untracked = "git diff --no-index /dev/null %s",
				},
			},
			-- Provider specific options
			files = {
				prompt = "Files❯ ",
				multiprocess = true,
				git_icons = true,
				file_icons = true,
				color_icons = true,
				find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/.next/*' -not -path '*/target/*' -not -path '*/build/*' -not -path '*/dist/*' -not -path '*/.venv/*' -not -path '*/venv/*' -not -path '*/.cache/*' -printf '%P\n']],
				rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!node_modules' -g '!.next' -g '!target' -g '!build' -g '!dist' -g '!.venv' -g '!venv' -g '!.cache' -g '!*.pyc' -g '!__pycache__'",
				fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .next --exclude target --exclude build --exclude dist --exclude .venv --exclude venv --exclude .cache --exclude __pycache__ --exclude '*.pyc'",
			},
			git = {
				files = {
					prompt = "GitFiles❯ ",
					cmd = "git ls-files --exclude-standard",
					multiprocess = true,
					git_icons = true,
					file_icons = true,
					color_icons = true,
				},
				status = {
					prompt = "GitStatus❯ ",
					preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
				},
				commits = {
					prompt = "Commits❯ ",
					preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
				},
				bcommits = {
					prompt = "BCommits❯ ",
					preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
				},
				branches = {
					prompt = "Branches❯ ",
				},
			},
			grep = {
				prompt = "Rg❯ ",
				input_prompt = "Grep For❯ ",
				multiprocess = true,
				git_icons = true,
				file_icons = true,
				color_icons = true,
				grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512 -e",
			},
			buffers = {
				prompt = "Buffers❯ ",
				file_icons = true,
				color_icons = true,
				sort_lastused = true,
				previewer = "builtin",
			},
			oldfiles = {
				prompt = "History❯ ",
				cwd_only = false,
				stat_file = true,
				include_current_session = true,
			},
		})
	end,
}
