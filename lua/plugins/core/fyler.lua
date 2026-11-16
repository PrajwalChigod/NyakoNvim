-- Close fyler if it's open in this tab as `kind`, otherwise open it as
-- `kind` (fyler swaps out a window of the other kind). fyler.toggle()
-- can't be used: it reuses the instance only when opts match exactly, and
-- root_path changes whenever fyler :tcd's into another directory, so it
-- would reopen instead of closing.
local function toggle(kind)
	local fyler = require("fyler")
	local open = require("fyler.finder").instance_get_or_nil()
	if open and open.opts.kind == kind then
		fyler.close()
		return
	end
	-- fyler defaults root_path to getcwd(-1, -1), the GLOBAL cwd, which ignores
	-- :tcd. Pass the effective (tab/window-aware) cwd explicitly so fyler opens
	-- rooted at whichever project/worktree the current tab is scoped to.
	fyler.open({ kind = kind, root_path = vim.fn.getcwd() })
end

return {
	"A7Lavinraj/fyler.nvim",
	branch = "stable",
	cmd = "Fyler",
	keys = {
		{
			"-",
			function()
				toggle("split_left_most")
			end,
			desc = "Toggle fyler at the current file",
		},
		{
			"_",
			function()
				toggle("floating")
			end,
			desc = "Toggle fyler in floating window",
		},
	},
	opts = {
		extensions = {
			git = { enabled = true },
		},
	},
}
