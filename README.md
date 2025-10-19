# 🐱 NyakoNvim

A sleek, purr-fectly crafted Neovim configuration that's fast, lightweight, and ready for serious development work. Built with carefully selected plugins and sensible defaults for developers who want power without the complexity.

## 📋 Table of Contents

- [✨ Why NyakoNvim?](#-why-nyakonvim)
- [📦 Quick Start](#-quick-start)
- [Requirements](#1-requirements)
- [Installation](#2-dependencies-and-project-installation-setup)
- [Language Support](#4-available-lsp-servers-and-installation-commands)
- [Debugging](#5-available-debug-tools-and-installation-commands)
- [Key Plugins](#8-key-plugins--what-they-do)
- [Learning Guide](#-learning-nyakonvim)
- [Contributing](#-contributing)

## ✨ Why NyakoNvim?

### 🚀 Lightning Fast
- **Blazing startup**: Loads 40+ plugins in under 50ms thanks to lazy loading
- **Optimized performance**: Smart buffer management, minimal redraw times, and efficient syntax highlighting
- **Instant completions**: Powered by [blink.cmp](https://github.com/saghen/blink.cmp) for zero-delay autocomplete

### 🎯 Developer Experience First
- **Zero configuration needed**: Works out of the box with sensible defaults
- **Comprehensive LSP support**: 8+ languages configured with auto-formatting, linting, and debugging
- **Smart keybindings**: Intuitive, mnemonic keymaps with [which-key](https://github.com/folke/which-key.nvim) integration
- **Session persistence**: Pick up exactly where you left off

### 🎨 Beautiful & Modern UI
- **Catppuccin Macchiato theme**: Easy on the eyes with custom color tweaks (default theme)
- **6 colorscheme options**: Switch between catppuccin, tokyonight, gruvbox, rose-pine, kanagawa, and onedark with `<leader>cp`
- **Clean status line**: Essential info without clutter via [lualine](https://github.com/nvim-lualine/lualine.nvim)
- **Smooth animations**: Enhanced UI with [noice.nvim](https://github.com/folke/noice.nvim)
- **Smart buffer tabs**: Visual buffer management with [bufferline](https://github.com/akinsho/bufferline.nvim)

### 🛠️ Batteries Included
- **Full DAP debugging**: Step through Python, JavaScript, Rust, C/C++, Go, and more
- **Advanced fuzzy finding**: Lightning-fast file/text search with [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- **Git integration**: Stage hunks, blame, and diff without leaving your editor
- **Treesitter magic**: Syntax-aware selections, smart text objects, and code navigation
- **File explorer**: Modern file management with [oil.nvim](https://github.com/stevearc/oil.nvim)

### 🧠 Smart Features
- **Flash navigation**: Jump anywhere on screen with [flash.nvim](https://github.com/folke/flash.nvim)
- **Auto-pairs & surround**: Intelligent bracket/quote handling
- **Scope-aware buffers**: Tab-local buffer management
- **Format on save**: Consistent code style with [conform.nvim](https://github.com/stevearc/conform.nvim)

## 📦 Quick Start

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone NyakoNvim
git clone https://github.com/PrajwalChigod/NyakoNvim.git ~/.config/nvim

# Install dependencies (macOS)
brew install bat ripgrep fzf fd

# Launch Neovim - plugins install automatically!
nvim
```

**That's it!** 🎉 Open a file and start coding. See [full installation guide](#2-dependencies-and-project-installation-setup) for other platforms.

## 🌍 Supported Languages

NyakoNvim comes pre-configured with LSP, formatting, linting, and debugging for:

<table>
<tr>
<td>

**Systems & Scripting**
- 🦀 Rust
- 🔷 C/C++
- ⚡ Zig
- 🐚 Bash/Shell

</td>
<td>

**Web & Frontend**
- 🟨 JavaScript/TypeScript
- 🎨 HTML/CSS
- 📦 JSON/YAML/TOML

</td>
<td>

**Dynamic Languages**
- 🐍 Python
- 🌙 Lua
- 🐹 Go

</td>
</tr>
</table>

**Full tooling support**: Each language gets LSP autocomplete, formatting, linting, and debugging (where applicable). See [tooling matrix](#9-tooling-matrix) for details.

## 1. Requirements

- **Neovim >= 0.11.0**
- Git
- A terminal with true color support
- A [Nerd Font](https://www.nerdfonts.com/) (recommended for proper icon display)

## 2. Dependencies and Project Installation Setup

### Core Dependencies

The following tools are required for full functionality:

- **bat** - For file previewing
- **rg (ripgrep)** - For fast searching
- **fzf** - For fuzzy finding
- **fd** - For faster file finding performance
- **C compiler** - Required for Treesitter parsers (gcc, clang, or MSVC)

### Installation Commands

#### macOS
```bash
# Core dependencies
brew install bat ripgrep fzf fd

# C compiler is included with Xcode Command Line Tools
xcode-select --install
```

#### Ubuntu/Debian
```bash
# Core dependencies
sudo apt install bat ripgrep fzf fd-find build-essential
```

#### Arch Linux
```bash
# Core dependencies
sudo pacman -S bat ripgrep fzf fd base-devel
```

### Project Setup

1. **Backup your existing Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/PrajwalChigod/NyakoNvim.git ~/.config/nvim
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first launch.

## 3. Optional Language-Specific Dependencies

The following are only needed if you're actively developing in these languages:

- **Node.js** - For running JavaScript/TypeScript projects
- **Python 3** - For running Python projects
- **Go** - For running/building Go projects
- **Rust** - For running/building Rust projects
- **Zig** - For running/building Zig projects

### Installation Commands

#### macOS
```bash
brew install node python3 go rust zig
```

#### Ubuntu/Debian
```bash
sudo apt install nodejs python3 golang rustc
# Install Zig manually from https://ziglang.org/download/
```

#### Arch Linux
```bash
sudo pacman -S nodejs python go rust zig
```

## 4. Available LSP Servers and Installation Commands

LSP servers are automatically managed by Mason. Install via `:Mason` in Neovim:

| Language                  | LSP Server      | Mason Install Command                      |
|-------------------------  |-----------------|--------------------------------------------|
| **Lua**                   | `lua_ls`        | `:MasonInstall lua-language-server`        |
| **Python**                | `basedpyright`  | `:MasonInstall basedpyright`               |
| **JavaScript/TypeScript** | `ts_ls`         | `:MasonInstall typescript-language-server` |
| **Rust**                  | `rust_analyzer` | `:MasonInstall rust-analyzer`              |
| **C/C++**                 | `clangd`        | `:MasonInstall clangd`                     |
| **Zig**                   | `zls`           | `:MasonInstall zls`                        |
| **Bash/Shell**            | `bashls`        | `:MasonInstall bash-language-server`       |
| **TOML**                  | `taplo`         | `:MasonInstall taplo`                      |

### Quick Install All LSP Servers
```vim
:MasonInstall lua-language-server basedpyright typescript-language-server rust-analyzer clangd zls bash-language-server taplo
```

## 5. Available Debug Tools and Installation Commands


### External Dependencies
```bash
# Python debugging support (not available in Mason)
pip install debugpy

# Lua linting support (luacheck requires luarocks)
# macOS
brew install luarocks

# Ubuntu/Debian
sudo apt-get install luarocks

# CentOS/RHEL
sudo yum install luarocks
```

Debugging is powered by nvim-dap. Install debug adapters via Mason:

| Language          | Debug Adapter         | Mason Install Command               | External Dependencies |
|-------------------|-----------------------|-------------------------------------|-----------------------|
| **Python**        | `debugpy`             | `:MasonInstall debugpy`             | `pip install debugpy` |
| **JavaScript**    | `js-debug-adapter`    | `:MasonInstall js-debug-adapter`    | Node.js runtime       |
| **TypeScript**    | `js-debug-adapter`    | `:MasonInstall js-debug-adapter`    | Node.js runtime       |
| **Go**            | `delve`               | `:MasonInstall delve`               | Go runtime            |
| **Rust**          | `codelldb`            | `:MasonInstall codelldb`            | -                     |
| **C**             | `codelldb`            | `:MasonInstall codelldb`            | -                     |
| **C++**           | `codelldb`            | `:MasonInstall codelldb`            | -                     |
| **Zig**           | `codelldb`            | `:MasonInstall codelldb`            | -                     |
| **Bash/Shell**    | `bash-debug-adapter`  | `:MasonInstall bash-debug-adapter`  | -                     |


### Quick Install All Debug Tools
```vim
:MasonInstall debugpy js-debug-adapter delve codelldb bash-debug-adapter
```

## 6. Available Linting Tools and Installation Commands

Linting is handled by nvim-lint. Install linters via Mason:

| Language/File Type        | Linter            | Mason Install Command                |
|---------------------------|-------------------|--------------------------------------|
| **Python**                | `ruff`            | `:MasonInstall ruff`                 |
| **JavaScript/TypeScript** | `eslint`          | `:MasonInstall eslint_d`             |
| **Lua**                   | `luacheck`        | `:MasonInstall luacheck`             |
| **JSON**                  | `jsonlint`        | `:MasonInstall jsonlint`             |
| **YAML**                  | `yamllint`        | `:MasonInstall yamllint`             |
| **Markdown**              | `markdownlint`    | `:MasonInstall markdownlint-cli2`    |
| **Shell**                 | `shellcheck`      | `:MasonInstall shellcheck`           |
| **Dockerfile**            | `hadolint`        | `:MasonInstall hadolint`             |

### Quick Install All Linting Tools
```vim
:MasonInstall ruff eslint_d luacheck jsonlint yamllint markdownlint-cli2 shellcheck hadolint
```

## 7. Available Formatting Tools and Installation Commands

Formatting is handled by conform.nvim. Install formatters via Mason:

| Language/File Type        | Formatter                    | Mason Install Command        |
|---------------------------|------------------------------|------------------------------|
| **Python**                | `ruff`                       | `:MasonInstall ruff`         |
| **Lua**                   | `stylua`                     | `:MasonInstall stylua`       |
| **JavaScript/TypeScript** | `prettier`                   | `:MasonInstall prettier`     |
| **JSON**                  | `prettier`                   | `:MasonInstall prettier`     |
| **YAML**                  | `prettier`                   | `:MasonInstall prettier`     |
| **Markdown**              | `prettier`                   | `:MasonInstall prettier`     |
| **CSS**                   | `prettier`                   | `:MasonInstall prettier`     |
| **HTML**                  | `prettier`                   | `:MasonInstall prettier`     |
| **C/C++**                 | `clang-format`               | `:MasonInstall clang-format` |
| **Shell**                 | `shfmt`                      | `:MasonInstall shfmt`        |
| **TOML**                  | `taplo`                      | `:MasonInstall taplo`        |
| **SQL**                   | `sqlfluff`                   | `:MasonInstall sqlfluff`     |
| **Rust**                  | Built-in via `rust_analyzer` | -                            |
| **Zig**                   | Built-in `zig fmt`           | -                            |

### Quick Install All Formatting Tools
```vim
:MasonInstall ruff stylua prettier clang-format shfmt taplo sqlfluff
```

## 8. Key Plugins & What They Do

Here's what powers NyakoNvim:

| Plugin | Purpose | Why It's Awesome |
|--------|---------|------------------|
| **lazy.nvim** | Plugin manager | Lightning-fast lazy loading, zero config needed |
| **blink.cmp** | Completion | Fastest completion engine, no delays |
| **fzf-lua** | Fuzzy finder | Find anything instantly - files, text, commands |
| **nvim-lspconfig** | LSP client | Full IDE features - autocomplete, go-to-def, refactor |
| **conform.nvim** | Formatter | Auto-format on save, multiple formatters per file |
| **nvim-lint** | Linter | Real-time error detection across 10+ languages |
| **nvim-dap** | Debugger | Full debugging with breakpoints, watches, stepping |
| **nvim-treesitter** | Parser | Smart syntax highlighting, code navigation, text objects |
| **gitsigns.nvim** | Git integration | See changes inline, stage hunks, blame, diff |
| **flash.nvim** | Motion | Jump anywhere with 2 keystrokes |
| **oil.nvim** | File explorer | Edit your filesystem like a buffer |
| **catppuccin** | Theme | Beautiful, carefully crafted color scheme |
| **which-key** | Keybind helper | Never forget a keybinding again |
| **toggleterm** | Terminal | Integrated terminals - floating, split, tabbed |

### Colorscheme System
NyakoNvim includes a flexible colorscheme system:
- **6 pre-configured themes**: catppuccin, tokyonight, gruvbox, rose-pine, kanagawa, onedark
- **Live preview picker**: Press `<leader>cp` to browse and preview themes with fzf-lua
- **Persistent selections**: Theme changes are automatically saved and restored on next startup
- **Smart lazy-loading**: Only the active theme loads at startup for optimal performance

## 9. Tooling Matrix

Complete reference matrix for all configured languages and their tooling:

| Language      | LSP Server      | Linter             | Formatter           | Debugger            | Mason Install Commands                                                  |
|---------------|-----------------|--------------------|--------------------|---------------------|--------------------------------------------------------------------------|
| **Python**    | `basedpyright`  | `ruff`             | `ruff`             | `debugpy`           | `basedpyright`, `ruff`, `debugpy`                                        |
| **JavaScript** | `ts_ls`        | `eslint`           | `prettier`         | `js-debug-adapter`  | `typescript-language-server`, `eslint_d`, `prettier`, `js-debug-adapter` |
| **TypeScript** | `ts_ls`        | `eslint`           | `prettier`         | `js-debug-adapter`  | `typescript-language-server`, `eslint_d`, `prettier`, `js-debug-adapter` |
| **Lua**       | `lua_ls`        | `luacheck`         | `stylua`           | ❌                  | `lua-language-server`, `luacheck`, `stylua`                              |
| **Rust**      | `rust_analyzer` | via LSP (clippy)   | via LSP            | `codelldb`          | `rust-analyzer`, `codelldb`                                              |
| **C**         | `clangd`        | via LSP            | `clang-format`     | `codelldb`          | `clangd`, `clang-format`, `codelldb`                                     |
| **C++**       | `clangd`        | via LSP            | `clang-format`     | `codelldb`          | `clangd`, `clang-format`, `codelldb`                                     |
| **Zig**       | `zls`           | via LSP            | `zig fmt`          | `codelldb`          | `zls`, `codelldb`                                                        |
| **Bash/Shell** | `bashls`       | `shellcheck`       | `shfmt`            | `bash-debug-adapter`| `bash-language-server`, `shellcheck`, `shfmt`, `bash-debug-adapter`      |
| **JSON**      | ❌              | `jsonlint`         | `prettier`         | ❌                  | `jsonlint`, `prettier`                                                   |
| **YAML**      | ❌              | `yamllint`         | `prettier`         | ❌                  | `yamllint`, `prettier`                                                   |
| **TOML**      | `taplo`         | ❌                 | `taplo`            | ❌                  | `taplo`                                                                  |
| **HTML**      | ❌              | ❌                 | `prettier`         | ❌                  | `prettier`                                                               |
| **CSS**       | ❌              | ❌                 | `prettier`         | ❌                  | `prettier`                                                               |
| **Markdown**  | ❌              | `markdownlint`     | `prettier`         | ❌                  | `markdownlint-cli2`, `prettier`                                          |
| **Dockerfile** | ❌             | `hadolint`         | ❌                 | ❌                  | `hadolint`                                                               |
| **SQL**       | ❌              | ❌                 | `sqlfluff`         | ❌                  | `sqlfluff`                                                               |

### Install All Tools At Once
```vim
" LSP Servers
:MasonInstall lua-language-server basedpyright typescript-language-server rust-analyzer clangd zls bash-language-server taplo

" Debug Adapters
:MasonInstall debugpy js-debug-adapter delve codelldb bash-debug-adapter

" Linters
:MasonInstall ruff eslint_d luacheck jsonlint yamllint markdownlint-cli2 shellcheck hadolint

" Formatters
:MasonInstall stylua prettier clang-format shfmt sqlfluff
```


### Configuration Notes
- **TreeSitter Parsers**: Automatically installed via `ensure_installed` list and `auto_install = true`
- **Rust**: Uses built-in `rust fmt` and `clippy` via `rust_analyzer` LSP
- **Zig**: Uses built-in `zig fmt` for formatting
- **C/C++**: Linting handled by `clangd` LSP with clang-tidy integration
- **Python**: `ruff` handles both linting and formatting for optimal performance
- **JavaScript/TypeScript**: Uses same tooling (ESLint, Prettier, ts_ls)

---

## 🎓 Learning NyakoNvim

### First Steps
1. **Open the dashboard**: Launch `nvim` without arguments to see the welcome screen
2. **Check keybindings**: Press `<Space>` (leader key) and wait - which-key will show you all options
3. **Find files**: `<Space>ff` to fuzzy find files, `<Space>fr` to live grep
4. **Explore config**: `<Space>ec` to browse the configuration

### Essential Keybindings
- **Leader key**: `<Space>` - Most commands start here
- **File navigation**: `<Space>ff` (find files), `-` (file explorer)
- **Buffer management**: `<Tab>` (next buffer), `<Shift-Tab>` (previous buffer)
- **LSP actions**: `gd` (go to definition), `grr` (find references), `gra` (code actions)
- **Git**: `<Space>g` prefix for all git operations
- **Fuzzy find**: `<Space>f` prefix for all search operations
- **Colorscheme picker**: `<Space>cp` to browse and apply themes with live preview

📖 **Full keymap reference**: See [KEYMAPS.md](./docs/KEYMAPS.md) for the complete cheatsheet

### Pro Tips
- **Session restore**: `<Space>qs` restores your last session with all buffers and splits
- **Format on save**: Enabled by default for all configured languages
- **Insert mode LSP**: Press `<C-g>` in insert mode for LSP actions without leaving insert
- **Flash navigation**: Press `s` in normal mode, type 2 chars, jump anywhere instantly
- **Buffer pinning**: Pin important buffers with `<Space>bi` to prevent accidental closing

---

## 🤝 Contributing

NyakoNvim is a personal configuration, but suggestions and improvements are welcome! Found a bug or have an idea?

- **Report issues**: [GitHub Issues](https://github.com/PrajwalChigod/NyakoNvim/issues)
- **Suggest features**: Open a discussion or PR
- **Share your setup**: Fork and customize to your heart's content!

---

## 📄 License

Apache 2.0 License

---

## ⭐ Show Your Support

If NyakoNvim makes your coding life easier, consider:
- ⭐ **Starring** the repo
- 🐱 **Sharing** with fellow developers
- 💬 **Spreading the word** about NyakoNvim

---

<div align="center">

**Made with 💜 and 🐱 by developers, for developers**

*Happy coding!* 🚀

</div>
