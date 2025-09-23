# Neovim Configuration

A modern Neovim configuration with essential plugins for an enhanced editing experience.

## Requirements

- **Neovim >= 0.11.0**
- Git
- A terminal with true color support
- A [Nerd Font](https://www.nerdfonts.com/) (recommended for proper icon display)

## External Dependencies

The following tools are required for full functionality:

**Core Dependencies:**
- **bat** - For file previewing
- **rg (ripgrep)** - For fast searching
- **fzf** - For fuzzy finding
- **fd** - For faster file finding performance
- **lazygit** - For Git interface integration
- **C compiler** - Required for Treesitter parsers (gcc, clang, or MSVC)

**Formatting & Linting Tools:**
- **prettier** - Web technologies formatter
- **stylua** - Lua formatter
- **shfmt** - Shell script formatter
- **shellcheck** - Shell script linter
- **eslint** - JavaScript/TypeScript linter (project-specific)
- **luacheck** - Lua linter

### Optional Language Runtime Dependencies

The following are only needed if you're actively developing in these languages:

- **Node.js** - For running JavaScript/TypeScript projects
- **Python 3** - For running Python projects
- **Go** - For running/building Go projects
- **Rust** - For running/building Rust projects
- **Zig** - For running/building Zig projects

**For debugging support:**

- **lldb** or **gdb** - For C/C++/Rust debugging
- **delve** - For Go debugging (install after Go: `go install github.com/go-delve/delve/cmd/dlv@latest`)
- **debugpy** - For Python debugging (install with: `pip install debugpy`)

### LSP Servers

LSP servers are automatically managed by Mason. The following will be installed automatically:

- **lua_ls** - Lua LSP for Neovim configuration development
- **basedpyright** - Python type checker and code intelligence
- **ts_ls** - JavaScript/TypeScript LSP for web development
- **rust_analyzer** - Rust LSP with advanced features and cargo integration
- **clangd** - C/C++ LSP with IntelliSense and code navigation
- **zls** - Zig Language Server for Zig development
- **bashls** - Bash Language Server for shell script development
- **taplo** - TOML Language Server for configuration files

### Formatting Tools

Formatting is handled by conform.nvim with the following formatters (automatically installed via Mason):

**Python:**
- **ruff** - Fast Python formatter and import organizer

**Lua:**
- **stylua** - Lua code formatter

**Web Technologies:**
- **prettier** - JavaScript, TypeScript, JSON, YAML, Markdown, CSS, HTML formatter

**Systems Programming:**
- **Rust** - Formatted via rust-analyzer LSP (no separate tool needed)
- **clang-format** - C/C++ formatter
- **zig fmt** - Official Zig formatter

**Shell & Config:**
- **shfmt** - Shell script formatter (bash/sh)
- **taplo** - TOML formatter
- **sqlfluff** - SQL formatter

### Linting Tools

Linting is handled by nvim-lint with support for:

**Python:**
- **ruff** - Fast Python linter with extensive rule coverage

**JavaScript/TypeScript:**
- **eslint** - JavaScript/TypeScript linter

**Lua:**
- **luacheck** - Lua static analysis tool

**Web & Config:**
- **jsonlint** - JSON syntax validator
- **yamllint** - YAML linter
- **markdownlint** - Markdown style checker

**Shell & Docker:**
- **shellcheck** - Shell script static analysis
- **hadolint** - Dockerfile linter

### Debugging Support

Debugging is powered by nvim-dap with UI support via nvim-dap-ui:

**Currently Configured:**
- **Python** - Uses debugpy adapter for Python debugging
- **Shell/Bash** - Uses bash-debug-adapter for shell script debugging
- **Go** - Uses delve adapter for Go debugging
- **Rust/C/C++** - Uses codelldb adapter for systems programming debugging
- **Zig** - Uses codelldb adapter for Zig debugging
- **JavaScript/TypeScript** - Uses js-debug-adapter for Node.js debugging

**Features:**
- Breakpoints, step-through debugging, variable inspection
- Auto-opens DAP UI when debugging starts
- Support for conditional breakpoints and expression evaluation

**Debugger Requirements:**
All DAP adapters are installed via Mason (already configured):
- **bash-debug-adapter** - For shell script debugging
- **delve** - For Go debugging
- **codelldb** - For Rust/C/C++ debugging
- **js-debug-adapter** - For JavaScript/TypeScript debugging

**External Dependencies:**
- **Python**: `pip install debugpy` (not available in Mason)
- **Go runtime**: Required for Go debugging
- **Node.js**: Required for JavaScript/TypeScript debugging

**Debug Keymaps:**
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint
- `<leader>dc` - Continue/Start debugging
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Run/Restart debugging
- `<leader>dt` - Terminate debug session
- `<leader>du` - Toggle DAP UI
- `<leader>de` - Evaluate expression

## TOOLING_MATRIX

This matrix provides a comprehensive overview of LSP servers, linters, formatters, and debuggers configured for each language. Use this as a reference for what needs to be installed via Mason when cloning this repository.

### Mason Installation
Run `:Mason` in Neovim and install the required tools listed in the "Install via Mason" column below.

### External Dependencies
Some tools require external installation:
- **Python**: `pip install debugpy` (for debugging)
- **Node.js**: Required for JavaScript/TypeScript tools
- **Go**: Required for Go development and tools

### Language Support Matrix

| Language | LSP Server | Linter | Formatter | Debugger | Install via Mason |
|----------|------------|--------|-----------|----------|-------------------|
| **Python** | `basedpyright` | `ruff` | `ruff_format`, `ruff_fix` | `debugpy` | `basedpyright`, `ruff` |
| **JavaScript** | `ts_ls` | `eslint` | `prettier` | `js-debug-adapter` | `typescript-language-server`, `eslint_d`, `prettier`, `js-debug-adapter` |
| **TypeScript** | `ts_ls` | `eslint` | `prettier` | `js-debug-adapter` | `typescript-language-server`, `eslint_d`, `prettier`, `js-debug-adapter` |
| **Lua** | `lua_ls` | `luacheck` | `stylua` | ❌ | `lua-language-server`, `luacheck`, `stylua` |
| **Rust** | `rust_analyzer` | via LSP (clippy) | via LSP | `codelldb` | `rust-analyzer`, `codelldb` |
| **C** | `clangd` | via LSP | `clang-format` | `codelldb` | `clangd`, `clang-format`, `codelldb` |
| **C++** | `clangd` | via LSP | `clang-format` | `codelldb` | `clangd`, `clang-format`, `codelldb` |
| **Zig** | `zls` | via LSP | `zig fmt` | `codelldb` | `zls`, `codelldb` |
| **Bash/Shell** | `bashls` | `shellcheck` | `shfmt` | `bash-debug-adapter` | `bash-language-server`, `shellcheck`, `shfmt`, `bash-debug-adapter` |
| **JSON** | ❌ | `jsonlint` | `prettier` | ❌ | `jsonlint`, `prettier` |
| **YAML** | ❌ | `yamllint` | `prettier` | ❌ | `yamllint`, `prettier` |
| **TOML** | `taplo` | ❌ | `taplo` | ❌ | `taplo` |
| **HTML** | ❌ | ❌ | `prettier` | ❌ | `prettier` |
| **CSS** | ❌ | ❌ | `prettier` | ❌ | `prettier` |
| **Markdown** | ❌ | `markdownlint` | `prettier` | ❌ | `markdownlint-cli2`, `prettier` |
| **Dockerfile** | ❌ | `hadolint` | ❌ | ❌ | `hadolint` |
| **SQL** | ❌ | ❌ | `sqlfluff` | ❌ | `sqlfluff` |

### Quick Setup Commands

#### Install All Required Mason Tools
Run these commands in Neovim command mode:

```vim
:MasonInstall basedpyright ruff
:MasonInstall typescript-language-server eslint_d prettier js-debug-adapter
:MasonInstall lua-language-server luacheck stylua
:MasonInstall rust-analyzer codelldb
:MasonInstall clangd clang-format
:MasonInstall zls
:MasonInstall bash-language-server shellcheck shfmt bash-debug-adapter
:MasonInstall jsonlint yamllint
:MasonInstall taplo
:MasonInstall markdownlint-cli2
:MasonInstall hadolint sqlfluff
```

#### External Dependencies
```bash
# Python debugging support
pip install debugpy

# Ensure Node.js is installed for JS/TS tools
# Ensure Go is installed for Go tools
# Ensure Rust toolchain is installed
```

### Configuration Notes

- **TreeSitter Parsers**: Automatically installed via `ensure_installed` list and `auto_install = true`
- **Rust**: Uses built-in `rust fmt` and `clippy` via `rust_analyzer` LSP
- **Zig**: Uses built-in `zig fmt` for formatting
- **C/C++**: Linting handled by `clangd` LSP with clang-tidy integration
- **Python**: `ruff` handles both linting and formatting for optimal performance
- **JavaScript/TypeScript**: Uses same tooling (ESLint, Prettier, ts_ls)

### Installation Commands

**macOS:**

```bash
# Core dependencies
brew install bat ripgrep fzf fd lazygit

# Formatting and linting tools
brew install prettier stylua shfmt shellcheck

# C compiler is included with Xcode Command Line Tools
xcode-select --install

# Language runtimes (only if you're developing in these languages)
# brew install node python3 go rust zig
# For Go debugging: go install github.com/go-delve/delve/cmd/dlv@latest
# For Python debugging: pip install debugpy
# Note: lldb is included with Xcode Command Line Tools for C/C++/Rust debugging

# Project-specific tools (install in your projects as needed)
# npm install -g eslint luacheck

# Note: LSP servers are automatically installed by Mason when you first open relevant files
```

**Ubuntu/Debian:**

```bash
# Core dependencies
sudo apt install bat ripgrep fzf fd-find build-essential
# Install lazygit manually from https://github.com/jesseduffield/lazygit#installation

# Formatting and linting tools
sudo apt install shellcheck
# Install prettier, stylua, shfmt via npm/cargo/go after language runtimes
# npm install -g prettier
# cargo install stylua
# go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Language runtimes (only if you're developing in these languages)
# sudo apt install nodejs python3 golang rustc
# For debugging: sudo apt install lldb gdb
# For Python debugging: pip install debugpy
# Install Zig manually from https://ziglang.org/download/
# For Go debugging: go install github.com/go-delve/delve/cmd/dlv@latest

# Project-specific tools (install in your projects as needed)
# npm install -g eslint
# luarocks install luacheck

# Note: LSP servers are automatically installed by Mason when you first open relevant files
```

**Arch Linux:**

```bash
# Core dependencies
sudo pacman -S bat ripgrep fzf fd base-devel lazygit

# Formatting and linting tools
sudo pacman -S prettier stylua shfmt shellcheck

# Language runtimes (only if you're developing in these languages)
# sudo pacman -S nodejs python go rust zig
# For debugging: sudo pacman -S lldb gdb
# For Python debugging: pip install debugpy
# For Go debugging: go install github.com/go-delve/delve/cmd/dlv@latest

# Project-specific tools (install in your projects as needed)
# npm install -g eslint
# luarocks install luacheck

# Note: LSP servers are automatically installed by Mason when you first open relevant files
```

## Installation

1. **Backup your existing Neovim configuration** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**

   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Start Neovim:**

   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first launch.

