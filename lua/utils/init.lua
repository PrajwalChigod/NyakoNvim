local M = {}

M.DEFAULT_COLORSCHEME = "catppuccin-espresso"
local DEFAULT_COLORSCHEME = M.DEFAULT_COLORSCHEME

local function get_colorscheme_path()
	return vim.fs.joinpath(vim.fn.stdpath("data"), "colorscheme.txt")
end

function M.save_colorscheme(colorscheme)
	if type(colorscheme) ~= "string" or colorscheme == "" then
		return false, "Invalid colorscheme name"
	end

	local path = get_colorscheme_path()
	local write_ok, write_err = pcall(vim.fn.writefile, { colorscheme }, path)
	if not write_ok then
		return false, "Failed to write colorscheme file: " .. tostring(write_err)
	end

	return true, colorscheme
end

function M.load_colorscheme()
	local path = get_colorscheme_path()

	if vim.fn.filereadable(path) == 0 then
		return DEFAULT_COLORSCHEME
	end

	local read_ok, content = pcall(vim.fn.readfile, path)
	if not read_ok or not content or content[1] == nil or content[1] == "" then
		return DEFAULT_COLORSCHEME
	end

	return content[1]
end

return M
