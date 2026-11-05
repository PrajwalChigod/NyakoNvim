-- ctrl+h/j/k/l move between nvim splits. At the edge of the last split:
--   * inside tmux, vim-tmux-navigator selects the neighbouring tmux pane
--   * inside Rex, ask the Rex server to focus the neighbouring pane
local function rex_focus(direction)
	if vim.env.REX_SESSION == nil or vim.fn.executable("rex") == 0 then
		return
	end
	vim.system({
		"rex", "api", "call", "-s", vim.env.REX_SESSION,
		"session.focus_direction", vim.json.encode({ direction = direction }),
	})
end

local function navigate(direction, wincmd, tmux_cmd)
	return function()
		if vim.env.TMUX then
			vim.cmd(tmux_cmd)
			return
		end
		local win = vim.api.nvim_get_current_win()
		vim.cmd("wincmd " .. wincmd)
		if vim.api.nvim_get_current_win() == win then
			rex_focus(direction)
		end
	end
end

return {
	"christoomey/vim-tmux-navigator",
	lazy = true,
	keys = {
		{ "<c-h>", navigate("left", "h", "TmuxNavigateLeft"), desc = "Navigate left" },
		{ "<c-j>", navigate("down", "j", "TmuxNavigateDown"), desc = "Navigate down" },
		{ "<c-k>", navigate("up", "k", "TmuxNavigateUp"), desc = "Navigate up" },
		{ "<c-l>", navigate("right", "l", "TmuxNavigateRight"), desc = "Navigate right" },
	},
}
