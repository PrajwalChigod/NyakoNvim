local M = {}

local DEFAULT_COLORSCHEME = "catppuccin"

local function get_colorscheme_path()
	return vim.fs.joinpath(vim.fn.stdpath("data"), "colorscheme.json")
end

function M.save_colorscheme(colorscheme)
	if type(colorscheme) ~= "string" or colorscheme == "" then
		return false, "Invalid colorscheme name"
	end

	local path = get_colorscheme_path()
	local data = { colorscheme = colorscheme }

	local json_ok, json_str = pcall(vim.json.encode, data)
	if not json_ok then
		return false, "Failed to encode JSON: " .. tostring(json_str)
	end

	local write_ok, write_err = pcall(vim.fn.writefile, { json_str }, path)
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
	if not read_ok or not content or #content == 0 then
		return DEFAULT_COLORSCHEME
	end

	local json_ok, data = pcall(vim.json.decode, table.concat(content))
	if not json_ok or type(data) ~= "table" or type(data.colorscheme) ~= "string" then
		return DEFAULT_COLORSCHEME
	end

	return data.colorscheme
end

return M
