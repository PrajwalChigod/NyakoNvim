-- Neovide-specific configuration
if vim.g.neovide then
	-- macOS simple fullscreen (hides dock and menu bar without creating a new Space)
	vim.g.neovide_macos_simple_fullscreen = true

	-- Additional neovide optimizations
	vim.g.neovide_cursor_animation_length = 0.06
	vim.g.neovide_cursor_trail_size = 0.3
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true

	-- Performance settings
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
end
