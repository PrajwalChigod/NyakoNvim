return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	keys = {
		{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
	},
	opts = {
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			width = 100, -- width of the Zen window
			height = 1, -- height of the Zen window (1 = full height)
			options = {
				signcolumn = "no", -- disable signcolumn
				number = true, -- disable number column
				relativenumber = false, -- disable relative numbers
				cursorline = false, -- disable cursorline
				cursorcolumn = false, -- disable cursor column
				foldcolumn = "0", -- disable fold column
				list = true, -- disable whitespace characters
			},
		},
		plugins = {
			-- disable some global vim options (vim.o...)
			options = {
				enabled = true,
				ruler = false, -- disables the ruler text in the cmd line area
				showcmd = false, -- disables the command in the last line of the screen
				laststatus = 0, -- turn off the statusline in zen mode
			},
			twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
			gitsigns = { enabled = false }, -- disables git signs
			tmux = { enabled = false }, -- disables the tmux statusline
			-- this will change the font size on kitty when in zen mode
			kitty = {
				enabled = false,
				font = "+4", -- font size increment
			},
			-- this will change the font size on alacritty when in zen mode
			alacritty = {
				enabled = false,
				font = "14", -- font size
			},
			-- this will change the font size on wezterm when in zen mode
			wezterm = {
				enabled = false,
				font = "+4", -- font size increment
			},
			-- this will change the font size on ghostty when in zen mode
			ghostty = {
				enabled = true,
				font = "+4", -- font size increment
			},
		},
		-- callback where you can add custom code when the Zen window opens
		on_open = function(win)
			-- Optional: Add any custom behavior when entering zen mode
		end,
		-- callback where you can add custom code when the Zen window closes
		on_close = function()
			-- Optional: Add any custom behavior when exiting zen mode
		end,
	},
}
