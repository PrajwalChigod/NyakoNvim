-- Neovide-specific configuration
if vim.g.neovide then
	-- macOS Display Settings
	vim.g.neovide_macos_simple_fullscreen = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_window_blurred = true

	-- Performance Settings
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = false

	-- Cursor Animations
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_size = 0.2
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_vfx_mode = ""

	-- Scroll Animations
	vim.g.neovide_scroll_animation_length = 0.2
	vim.g.neovide_scroll_animation_far_lines = 1

	-- Window Positioning
	vim.g.neovide_position_animation_length = 0.1

	-- Quality of Life
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_hide_mouse_when_typing = false
end
