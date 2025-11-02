# Yazi File Explorer Keymaps

## Opening Yazi in Neovim

| Key | Mode | Description |
|-----|------|-------------|
| `-` | Normal | Open Yazi at the current file |
| `~` | Normal | Open Yazi in the current working directory |

## Inside Yazi Window

### Navigation

| Key | Description |
|-----|-------------|
| `j` / `↓` | Move cursor down |
| `k` / `↑` | Move cursor up |
| `h` / `←` | Go to parent directory |
| `l` / `→` / `<CR>` | Enter directory or open file |
| `gg` | Go to top of list |
| `G` | Go to bottom of list |
| `<C-u>` | Page up |
| `<C-d>` | Page down |
| `~` | Go to home directory |
| `g.` | Show hidden files |

### File Selection

| Key | Description |
|-----|-------------|
| `<Space>` | Toggle selection of current file |
| `v` | Enter visual/select mode |
| `V` | Unselect all |
| `<C-a>` | Select all files |
| `<C-r>` | Inverse selection |

### File Operations

| Key | Description |
|-----|-------------|
| `y` | Yank/copy selected files |
| `x` | Cut selected files |
| `p` | Paste yanked/cut files |
| `d` | Delete selected files (with confirmation) |
| `D` | Force delete (without confirmation) |
| `a` | Create new file or directory |
| `r` | Rename file/directory |
| `u` | Undo last operation |
| `;` | Run shell command |
| `:` | Execute Yazi command |

### Search & Filter

| Key | Description |
|-----|-------------|
| `/` | Search files |
| `n` | Next search match |
| `N` | Previous search match |
| `f` | Filter files by pattern |

### Tab Management

| Key | Description |
|-----|-------------|
| `t` | Create new tab |
| `<Tab>` | Switch to next tab |
| `<S-Tab>` | Switch to previous tab |
| `1-9` | Switch to tab 1-9 |
| `[` | Switch to previous tab |
| `]` | Switch to next tab |

### Sorting & Display

| Key | Description |
|-----|-------------|
| `,a` | Sort alphabetically |
| `,c` | Sort by creation time |
| `,m` | Sort by modified time |
| `,s` | Sort by size |
| `,e` | Sort by extension |
| `z` | Jump to directory (zoxide) |

### Other

| Key | Description |
|-----|-------------|
| `?` | Show help/keybindings |
| `q` | Quit Yazi |
| `<Esc>` | Cancel operation or exit mode |
| `<C-s>` | Toggle selection mode |
| `o` | Open file with default application |
| `O` | Open file with custom command |

---

## Configuration

Yazi is configured in `lua/plugins/yazi.lua` with the following settings:
- Opens in floating window
- Custom help keymap: `?`
- Does not auto-open for directories (handled by session management)
