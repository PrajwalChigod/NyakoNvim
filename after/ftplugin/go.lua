-- Go specific settings (requires tabs per gofmt)
vim.opt_local.expandtab = false  -- Use actual tabs
vim.opt_local.tabstop = 4        -- Tab width
vim.opt_local.shiftwidth = 4     -- Indentation width
vim.opt_local.softtabstop = 4    -- Tab behavior

-- Go-specific listchars (tabs are standard)
vim.opt_local.listchars = { tab = "⋅ ", trail = "·", nbsp = "␣" }