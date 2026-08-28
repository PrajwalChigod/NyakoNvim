local terminals = {}

-- Create (once) and toggle a named terminal, tracking it as the
-- most-recently-used one so <C-\> can bring back exactly this one later.
local function toggle(key, term_opts)
	terminals[key] = terminals[key] or require("toggleterm.terminal").Terminal:new(term_opts)
	terminals.last = terminals[key]
	terminals[key]:toggle()
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = true,
	cmd = { "ToggleTerm", "TermExec", "TermSelect" },
	keys = {
		{
			"<localleader>tb",
			function()
				vim.cmd("term")
			end,
			desc = "Toggle terminal buffer",
		},
		{
			"<localleader>tf",
			function()
				toggle("float", { direction = "float", float_opts = { border = "curved" } })
			end,
			desc = "Toggle floating terminal",
		},
		{
			"<localleader>th",
			function()
				toggle("horizontal", { direction = "horizontal" })
			end,
			desc = "Toggle horizontal terminal",
		},
		{
			"<localleader>tv",
			function()
				toggle("vertical", { direction = "vertical", size = 80 })
			end,
			desc = "Toggle vertical terminal",
		},
		{
			"<localleader>tt",
			function()
				toggle("tab", { direction = "tab" })
			end,
			desc = "Toggle tab terminal",
		},
		{
			"<localleader>tr",
			function()
				vim.ui.input({ prompt = "Command to run: " }, function(cmd)
					if not cmd or cmd == "" then
						return
					end
					local Terminal = require("toggleterm.terminal").Terminal
					local name = #cmd > 40 and (cmd:sub(1, 37) .. "...") or cmd
					-- each run gets its own terminal (not reused) so an earlier
					-- still-running command is never orphaned by starting a new one
					local term = Terminal:new({
						cmd = cmd,
						display_name = name,
						direction = "float",
						float_opts = { border = "curved" },
						close_on_exit = false,
						on_exit = function(_, _, exit_code)
							local level = exit_code == 0 and vim.log.levels.INFO or vim.log.levels.WARN
							vim.notify(
								string.format("`%s` finished (exit code %d)", cmd, exit_code),
								level,
								{ title = "Terminal" }
							)
						end,
					})
					terminals.last = term
					terminals.last_cmd = term
					term:toggle()
				end)
			end,
			desc = "Run command in terminal (notify on exit)",
		},
		{
			"<localleader>tc",
			function()
				if terminals.last_cmd then
					terminals.last = terminals.last_cmd
					terminals.last_cmd:toggle()
				else
					vim.notify("No command terminal running yet -- use <localleader>tr first", vim.log.levels.WARN)
				end
			end,
			desc = "Toggle most recent run-command terminal",
		},
		{
			"<localleader>ts",
			function()
				vim.cmd("TermSelect")
			end,
			desc = "Select terminal (pick from all open/tracked)",
		},
		{
			[[<C-\>]],
			function()
				if terminals.last then
					terminals.last:toggle()
				else
					toggle("float", { direction = "float", float_opts = { border = "curved" } })
				end
			end,
			mode = { "n", "t" },
			desc = "Toggle last-used terminal",
		},
	},
	opts = {
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = -30,
		start_in_insert = true,
		insert_mappings = false,
		terminal_mappings = true,
		persist_size = false,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
		winbar = {
			enabled = true,
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Terminal window navigation: move between a toggleterm split and other
		-- windows without first leaving terminal mode. Scoped to toggleterm
		-- buffers only (term://*toggleterm#*), per the plugin's README.
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			group = vim.api.nvim_create_augroup("ToggleTermWindowNav", { clear = true }),
			callback = function(args)
				local map_opts = { buffer = args.buf, silent = true }
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], map_opts)
			end,
		})
	end,
}
