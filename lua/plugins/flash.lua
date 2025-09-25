return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- Flash configuration
		search = {
			-- search/jump in all windows
			multi_window = true,
			-- search direction
			forward = true,
			-- when `false`, find only matches in the given direction
			wrap = true,
			-- Each mode will take `incremental` into account.
			-- `incremental` is forced for `search.mode=search` and `jump.mode=search`
			incremental = false,
			-- Use a simple search instead of a regular expression
			mode = "exact",
			-- Minimum pattern length
			min_length = 2,
		},
		jump = {
			-- save location in the jumplist
			jumplist = true,
			-- jump position offset. Not used for range jumps.
			pos = "start", -- "start" | "end" | "range"
			-- add pattern to search history
			history = false,
			-- add pattern to search register
			register = false,
			-- clear highlight after jump
			nohlsearch = false,
			-- automatically jump when there is only one match
			autojump = false,
		},
		label = {
			-- allow uppercase labels
			uppercase = true,
			-- add any labels with the correct case here, that you want to exclude
			exclude = "",
			-- add a label for the first match in the current window.
			current = true,
			-- show the label after the match
			after = true,
			-- show the label before the match
			before = false,
			-- position of the label extmark
			style = "overlay", -- "eol" | "overlay" | "right_align" | "inline"
			-- flash tries to re-use labels that were already assigned to a position,
			-- when typing more characters. By default only lower-case labels are re-used.
			reuse = "lowercase",
			-- for the current window, label targets closer to the cursor first
			distance = true,
			-- minimum pattern length to show labels
			min_pattern_length = 0,
			-- Enable this to use rainbow colors to highlight labels
			rainbow = {
				enabled = false,
				shade = 5,
			},
		},
		highlight = {
			-- show a backdrop with hl FlashBackdrop
			backdrop = true,
			-- Highlight the search matches
			matches = true,
			-- extmark priority
			priority = 5000,
			groups = {
				match = "FlashMatch",
				current = "FlashCurrent",
				backdrop = "FlashBackdrop",
				label = "FlashLabel",
			},
		},
		-- action to perform when picking a label.
		-- defaults to the jumping logic depending on the mode.
		action = nil,
		-- initial pattern to use when opening flash
		pattern = "",
		-- When `true`, flash will try to continue the last search
		continue = false,
		-- Set config to a function to dynamically change the config
		config = nil, ---@type fun(opts:Flash.Config)|nil
		-- You can override the default options for a specific mode.
		-- Use it with `require("flash").jump({mode = "forward"})`
		modes = {
			-- options used when flash is activated through
			-- a regular search with `/` or `?`
			search = {
				-- when `true`, flash will be activated during regular search by default.
				-- You can always toggle when searching with `require("flash").toggle()`
				enabled = false,
				highlight = { backdrop = false },
				jump = { history = true, register = true, nohlsearch = true },
				search = {
					-- `forward` will be automatically set to the search direction
					-- `mode` is always set to `search`
					-- `incremental` is set to `true` when `incsearch` is enabled
				},
			},
			-- options used when flash is activated through
			-- `f`, `F`, `t`, `T`, `;` and `,` motions
			char = {
				enabled = true,
				-- dynamic configuration for ftFT motions
				config = function(opts)
					-- autohide flash when in operator-pending mode
					opts.autohide = opts.autohide or (vim.fn.mode(true):find("o") and vim.v.operator == "y")

					-- disable jump labels when not enabled, when using a count,
					-- or when recording/executing registers
					opts.jump_labels = opts.jump_labels
						and vim.v.count == 0
						and vim.fn.reg_executing() == ""
						and vim.fn.reg_recording() == ""

					-- Show jump labels only in operator-pending mode
					opts.jump_labels = vim.fn.mode(true):find("o")
				end,
				-- hide after jump when not using jump labels
				autohide = false,
				-- show jump labels
				jump_labels = false,
				-- set to `false` to use the current line only
				multi_line = true,
				-- When using jump labels, don't use these keys
				-- This allows using those keys directly after the motion
				label = { exclude = "hjkliardc" },
				-- by default all keymaps are enabled, but you can disable some of them,
				-- by removing them from the list.
				keys = { "f", "F", "t", "T", ";", "," },
				---@type number|fun():number
				char_actions = function(motion)
					return {
						[";"] = "next", -- set to `right` to always go right
						[","] = "prev", -- set to `left` to always go left
						-- clever-f style
						[motion:lower()] = "next",
						[motion:upper()] = "prev",
					}
				end,
				search = { wrap = false },
				highlight = { backdrop = true },
				jump = { register = false },
			},
			-- options used for treesitter selections
			-- `require("flash").treesitter()`
			treesitter = {
				labels = "abcdefghijklmnopqrstuvwxyz",
				jump = { pos = "range" },
				search = { incremental = false },
				label = { before = true, after = true, style = "inline" },
				highlight = {
					backdrop = false,
					matches = false,
				},
			},
			treesitter_search = {
				jump = { pos = "range" },
				search = { multi_window = true, wrap = true, incremental = false },
				remote_op = { restore = true },
				label = { before = true, after = true, style = "inline" },
			},
			-- options used for remote flash
			remote = {
				remote_op = { restore = true, motion = true },
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}