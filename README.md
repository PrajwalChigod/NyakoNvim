# Neovim Configuration

A modern Neovim configuration with essential plugins for an enhanced editing experience.

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
- **lazygit** - For Git interface integration
- **C compiler** - Required for Treesitter parsers (gcc, clang, or MSVC)

### Installation Commands

#### macOS
```bash
# Core dependencies
brew install bat ripgrep fzf fd lazygit

# C compiler is included with Xcode Command Line Tools
xcode-select --install
```

#### Ubuntu/Debian
```bash
# Core dependencies
sudo apt install bat ripgrep fzf fd-find build-essential
# Install lazygit manually from https://github.com/jesseduffield/lazygit#installation
```

#### Arch Linux
```bash
# Core dependencies
sudo pacman -S bat ripgrep fzf fd base-devel lazygit
```

### Project Setup

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

## 8. Tooling Matrix

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

