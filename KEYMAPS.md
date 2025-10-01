# Nekonvim Keymaps Cheatsheet

## Basic Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `jj` | Insert | Exit insert mode |
| `<C-h/j/k/l>` | Normal | Navigate between splits |
| `<C-d>` | Normal | Page down (centered) |
| `<C-u>` | Normal | Page up (centered) |
| `n` / `N` | Normal | Next/Previous search (centered) |
| `J` | Normal | Join lines (keep cursor position) |

## Buffer & Tab Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | Normal | Next buffer |
| `<S-Tab>` | Normal | Previous buffer |
| `<leader>bi` | Normal | Toggle pin buffer |
| `<leader>bdd` | Normal | Delete current buffer |
| `<leader>bdi` | Normal | Delete non-pinned buffers |
| `<leader>bds` | Normal | Delete all non-active buffers |
| `<leader>bsv` | Normal | Split buffer vertically |
| `<leader>bsh` | Normal | Split buffer horizontally |
| `<leader>tt` | Normal | New tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tb` | Normal | Open buffer in new tab |
| `<leader>tf` | Normal | New tab with file picker |

## LSP Operations

### Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gS` | Normal | Document symbols |
| `gW` | Normal | Workspace symbols |
| `K` | Normal | Hover documentation |
| `gs` | Normal | Signature help |

### References & Actions (gr*)
| Key | Mode | Description |
|-----|------|-------------|
| `grr` | Normal | Find references |
| `gra` | Normal | Code actions |
| `grn` | Normal | Rename symbol |
| `gri` | Normal | Implementations |
| `grt` | Normal | Type definitions |

### Insert Mode LSP
| Key | Mode | Description |
|-----|------|-------------|
| `<C-g>K` | Insert | Hover documentation |
| `<C-g>s` | Insert | Signature help |
| `<C-g>f` | Insert | Format file |
| `<C-g>l` | Insert | Run linter |

## Diagnostics (ge*)

| Key | Mode | Description |
|-----|------|-------------|
| `get` | Normal | Toggle diagnostics |
| `gen` | Normal | Next diagnostic |
| `gep` | Normal | Previous diagnostic |
| `gef` | Normal | Open diagnostic float |
| `gel` | Normal | Set loclist with diagnostics |
| `geq` | Normal | Set quickfix with diagnostics |

## Code Tools

| Key | Mode | Description |
|-----|------|-------------|
| `gf` | Normal/Visual | Format file/range |
| `gl` | Normal | Run linter |

## Window Management

### Navigation (Configured Shortcuts)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | Normal | Go to left split |
| `<C-j>` | Normal | Go to bottom split |
| `<C-k>` | Normal | Go to top split |
| `<C-l>` | Normal | Go to right split |

### Default Window Navigation (`<C-w>` prefix)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>h` | Normal | Go to left window |
| `<C-w>j` | Normal | Go to down window |
| `<C-w>k` | Normal | Go to up window |
| `<C-w>l` | Normal | Go to right window |
| `<C-w>w` | Normal | Cycle to next window |
| `<C-w>W` | Normal | Cycle to previous window |
| `<C-w>t` | Normal | Go to top-left window |
| `<C-w>b` | Normal | Go to bottom-right window |
| `<C-w>p` | Normal | Go to previous window |

### Window Splitting
| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>s` | Normal | Split window horizontally |
| `<C-w>v` | Normal | Split window vertically |
| `<C-w>n` | Normal | New window with empty buffer |
| `<C-w>q` | Normal | Quit current window |
| `<C-w>c` | Normal | Close current window |
| `<C-w>o` | Normal | Close all other windows (only this one) |

### Window Moving
| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>r` | Normal | Rotate windows downwards/rightwards |
| `<C-w>R` | Normal | Rotate windows upwards/leftwards |
| `<C-w>x` | Normal | Exchange window with next one |
| `<C-w>H` | Normal | Move window to far left |
| `<C-w>J` | Normal | Move window to very bottom |
| `<C-w>K` | Normal | Move window to very top |
| `<C-w>L` | Normal | Move window to far right |
| `<C-w>T` | Normal | Move window to new tab |

### Window Resizing
| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>=` | Normal | Make all windows equal size |
| `<C-w>-` | Normal | Decrease window height |
| `<C-w>+` | Normal | Increase window height |
| `<C-w><` | Normal | Decrease window width |
| `<C-w>>` | Normal | Increase window width |
| `<C-w>_` | Normal | Maximize window height |
| `<C-w>\|` | Normal | Maximize window width |

### Other Window Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>f` | Normal | Open file under cursor in new window |
| `<C-w>gf` | Normal | Open file under cursor in new tab |
| `<C-w>}` | Normal | Preview tag under cursor |
| `<C-w>z` | Normal | Close preview window |

## File Explorer (Oil)

| Key | Mode | Description |
|-----|------|-------------|
| `-` | Normal | Open file explorer |
| `g?` | Oil Buffer | Show help |
| `<CR>` | Oil Buffer | Select/Open file or directory |
| `<C-t>` | Oil Buffer | Open in new tab |
| `p` | Oil Buffer | Preview file |
| `x` | Oil Buffer | Close oil buffer |
| `r` | Oil Buffer | Refresh |
| `_` | Oil Buffer | Go to parent directory |
| `` ` `` | Oil Buffer | Change directory (cd) |
| `~` | Oil Buffer | Change directory for tab (tcd) |
| `gs` | Oil Buffer | Change sort order |
| `gx` | Oil Buffer | Open with external program |
| `g.` | Oil Buffer | Toggle hidden files |
| `g\` | Oil Buffer | Toggle trash view |

## Fuzzy Finding (FZF)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Find git files |
| `<leader>fo` | Normal | Find recent files |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fw` | Normal | Find word under cursor |
| `<leader>fW` | Normal | Find WORD under cursor |
| `<leader>fr` | Normal | Live grep |
| `<leader>fs` | Normal | Grep current buffer |
| `<leader>fh` | Normal | Help tags |
| `<leader>fk` | Normal | Keymaps |
| `<leader>fc` | Normal | Commands |
| `<leader>f:` | Normal | Command history |
| `<leader>f/` | Normal | Search history |
| `<leader>fm` | Normal | Marks |
| `<leader>fj` | Normal | Jumps |
| `<leader>fl` | Normal | Resume last search |

## Comments (gc*)

| Key | Mode | Description |
|-----|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gcf` | Normal | Comment function |
| `gbc` | Normal | Toggle block comment |
| `gcO` | Normal | Add comment above |
| `gco` | Normal | Add comment below |
| `gcA` | Normal | Add comment at end of line |
| `gc` | Visual | Comment selection |
| `gb` | Visual | Block comment selection |

## Folding

| Key | Mode | Description |
|-----|------|-------------|
| `za` | Normal | Toggle fold |
| `zA` | Normal | Toggle fold recursively |
| `zd` | Normal | Delete fold |
| `zD` | Normal | Delete fold recursively |

## Text Editing

| Key | Mode | Description |
|-----|------|-------------|
| `<` | Visual | Indent left (stay in visual) |
| `>` | Visual | Indent right (stay in visual) |
| `J` | Visual | Move line down |
| `K` | Visual | Move line up |

## Surround (nvim-surround)

| Key | Mode | Description |
|-----|------|-------------|
| `ys{motion}` | Normal | Add surround (e.g., `ysiw"`) |
| `yss` | Normal | Surround entire line |
| `cs` | Normal | Change surround (e.g., `cs"'`) |
| `ds` | Normal | Delete surround (e.g., `ds"`) |
| `S` | Visual | Surround selection |
| `<C-s>s` | Insert | Surround selection |
| `<C-s>S` | Insert | Surround line |

## Flash Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual/Operator | Flash jump |
| `S` | Normal/Visual/Operator | Flash treesitter |
| `r` | Operator | Remote flash |
| `R` | Operator/Visual | Treesitter search |

## Treesitter

### Selection
| Key | Mode | Description |
|-----|------|-------------|
| `<C-space>` | Normal/Visual | Init/Increment selection |
| `<C-S-space>` | Normal/Visual | Scope incremental |
| `<M-space>` | Normal/Visual | Node decremental |

### Text Objects
| Key | Mode | Description |
|-----|------|-------------|
| `af/if` | Visual/Operator | Around/Inside function |
| `ac/ic` | Visual/Operator | Around/Inside class |
| `ap/ip` | Visual/Operator | Around/Inside parameter |
| `ab/ib` | Visual/Operator | Around/Inside block |
| `al/il` | Visual/Operator | Around/Inside loop |
| `aa/ia` | Visual/Operator | Around/Inside attribute |

### Movement
| Key | Mode | Description |
|-----|------|-------------|
| `]f/[f` | Normal | Next/Previous function start |
| `]F/[F` | Normal | Next/Previous function end |
| `]c/[c` | Normal | Next/Previous class start |
| `]C/[C` | Normal | Next/Previous class end |
| `]p/[p` | Normal | Next/Previous parameter start |
| `]P/[P` | Normal | Next/Previous parameter end |
| `]k/[k` | Normal | Next/Previous block start |
| `]K/[K` | Normal | Next/Previous block end |

### Swap (localleader)
| Key | Mode | Description |
|-----|------|-------------|
| `<localleader>sp` | Normal | Swap with next parameter |
| `<localleader>sP` | Normal | Swap with previous parameter |
| `<localleader>sf` | Normal | Swap with next function |
| `<localleader>sF` | Normal | Swap with previous function |

## Git (Gitsigns)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gs` | Normal/Visual | Stage hunk |
| `<leader>gr` | Normal/Visual | Reset hunk |
| `<leader>gp` | Normal | Preview hunk |
| `<leader>gb` | Normal | Blame line |
| `<leader>gd` | Normal | Diff this |
| `<leader>gS` | Normal | Stage buffer |
| `<leader>gR` | Normal | Reset buffer |
| `<leader>gu` | Normal | Undo stage hunk |
| `<leader>gD` | Normal | Diff this ~ |
| `<leader>gt` | Normal | Toggle signs |
| `<leader>glb` | Normal | Toggle line blame |
| `<leader>gld` | Normal | Toggle deleted |
| `ih` | Visual/Operator | Git hunk text object |

## Debug (DAP)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dB` | Normal | Conditional breakpoint |
| `<leader>dc` | Normal | Continue |
| `<leader>di` | Normal | Step into |
| `<leader>do` | Normal | Step over |
| `<leader>dO` | Normal | Step out |
| `<leader>dr` | Normal | Run/Start debugging |
| `<leader>dt` | Normal | Terminate session |
| `<leader>du` | Normal | Toggle DAP UI |
| `<leader>de` | Normal | Evaluate expression |

## Terminal

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | Terminal | Exit terminal mode |
| `<localleader>tf` | Normal | Toggle floating terminal |
| `<localleader>th` | Normal | Toggle horizontal terminal |
| `<localleader>tv` | Normal | Toggle vertical terminal |
| `<localleader>tt` | Normal | Toggle tab terminal |

## Editor Config

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ec` | Normal | Edit Neovim config |
| `<leader>er` | Normal | Reload config & sync plugins |

## Session Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>qs` | Normal | Restore session |
| `<leader>ql` | Normal | Restore last session |
| `<leader>qd` | Normal | Stop session recording |

## Completion (Blink.cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Insert | Next completion |
| `<C-p>` | Insert | Previous completion |
| `<C-d>` | Insert | Scroll docs down |
| `<C-f>` | Insert | Scroll docs up |
| `<CR>` | Insert | Accept completion |
| `<C-Space>` | Insert | Accept completion |
| `<Tab>` | Insert | Next snippet/completion |
| `<S-Tab>` | Insert | Previous snippet/completion |

## Dashboard

| Key | Mode | Description |
|-----|------|-------------|
| `f` | Dashboard | Find files |
| `r` | Dashboard | Recent files |
| `g` | Dashboard | Live grep |
| `s` | Dashboard | Restore session |
| `c` | Dashboard | Edit config |
| `q` | Dashboard | Quit |

---

## Notes

- **Leader key**: `<Space>`
- **Local leader key**: `\`
- Most commands work with counts (e.g., `3gcc` comments 3 lines)
- Visual mode works with most text operations
- LSP features require active language server