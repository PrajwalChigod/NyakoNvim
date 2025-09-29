-- Lua specific settings (2 spaces standard)
vim.opt_local.expandtab = true       -- Use spaces
vim.opt_local.tabstop = 2            -- Tab width
vim.opt_local.shiftwidth = 2         -- Indentation width
vim.opt_local.softtabstop = 2        -- Tab behavior

-- 2-space indentation listchars
vim.opt_local.listchars = { tab = "⋅ ", trail = "·", nbsp = "␣", leadmultispace = "⋅ " }