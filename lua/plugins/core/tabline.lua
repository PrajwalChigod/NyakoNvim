return {
	"nvim-mini/mini.tabline",
	event = "VimEnter",
	init = function()
		vim.o.showtabline = 2
	end,
	config = function()
		require("mini.tabline").setup({
			show_icons = false,
			tabpage_section = "right",
			format = function(buf_id, label)
				local suffix = vim.bo[buf_id].modified and " [+]" or ""
				return " " .. label .. suffix .. " "
			end,
		})

		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = desc })
		end

		local function listed_buffers()
			local buffers = {}
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.fn.buflisted(buf) == 1 then
					table.insert(buffers, buf)
				end
			end
			return buffers
		end

		local function delete_buffer(buf)
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end

		local function delete_current_buffer()
			local current = vim.api.nvim_get_current_buf()
			vim.cmd("bprevious")
			if vim.api.nvim_get_current_buf() == current then
				vim.cmd("bnext")
			end
			if vim.api.nvim_get_current_buf() == current then
				vim.cmd("enew")
			end
			delete_buffer(current)
		end

		local function delete_other_buffers()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(listed_buffers()) do
				if buf ~= current then
					delete_buffer(buf)
				end
			end
		end

		local function delete_hidden_buffers()
			local current = vim.api.nvim_get_current_buf()
			local visible = {}
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				visible[vim.api.nvim_win_get_buf(win)] = true
			end

			for _, buf in ipairs(listed_buffers()) do
				if buf ~= current and not visible[buf] then
					delete_buffer(buf)
				end
			end
		end

		map("<Tab>", "<Cmd>bnext<CR>", "Next buffer")
		map("<S-Tab>", "<Cmd>bprevious<CR>", "Previous buffer")
		map("<leader>bd", delete_current_buffer, "Delete current buffer")
		map("<leader>bx", delete_hidden_buffers, "Delete hidden buffers")
		map("<leader>bo", delete_other_buffers, "Delete other buffers")
	end,
}
