-- C++ specific settings (4 spaces for consistency with Python/Rust/Zig)
vim.opt_local.expandtab = true       -- Use spaces
vim.opt_local.tabstop = 4            -- Tab width
vim.opt_local.shiftwidth = 4         -- Indentation width
vim.opt_local.softtabstop = 4        -- Tab behavior

-- 4-space indentation listchars
vim.opt_local.listchars = { tab = "⋅ ", trail = "·", nbsp = "␣", leadmultispace = "⋅   " }