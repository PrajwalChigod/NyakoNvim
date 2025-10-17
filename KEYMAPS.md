# NyakoNvim Keymaps Cheatsheet

## Basic Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `jj` | Insert | Exit insert mode |
| `<Esc>` | Normal/Insert/Visual | Clear search highlights (also exit mode if in insert/visual) |
| `<C-h/j/k/l>` | Normal | Navigate between splits |
| `<C-d>` | Normal | Page down (centered) |
| `<C-u>` | Normal | Page up (centered) |
| `n` / `N` | Normal | Next/Previous search (centered) |
| `J` | Normal | Join lines (keep cursor position) |

## Insert Mode Navigation

### Word & Line Movement
| Key | Mode | Description |
|-----|------|-------------|
| `<A-.>` | Insert | End of line |
| `<A-,>` | Insert | First non-blank character |
| `<A-0>` | Insert | Beginning of line |
| `<A-b>` | Insert | Previous word |
| `<A-w>` | Insert | Next word start |
| `<A-e>` | Insert | Next word end |

### Directional Movement
| Key | Mode | Description |
|-----|------|-------------|
| `<A-h>` | Insert | Move left |
| `<A-j>` | Insert | Move down |
| `<A-k>` | Insert | Move up |
| `<A-l>` | Insert | Move right |

### Function & Class Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<A-J>` | Insert | Next function |
| `<A-K>` | Insert | Previous function |
| `<A-L>` | Insert | Next class |
| `<A-H>` | Insert | Previous class |

### Quick Edits
| Key | Mode | Description |
|-----|------|-------------|
| `<A-d>` | Insert | Delete word forward |
| `<A-D>` | Insert | Delete to end of line |
| `<A-u>` | Insert | Delete to line start |
| `<A-o>` | Insert | Insert line below |
| `<A-O>` | Insert | Insert line above |
| `<A-x>` | Insert | Delete character under cursor |
| `<A-z>` | Insert | Undo |
| `<A-c>` | Insert | Yank/copy current line |
| `<A-p>` | Insert | Paste after cursor |

## Save Operations

| Key | Mode | Description |
|-----|------|-------------|
| `<C-s>` | Normal | Save all buffers |
| `<C-s>` | Insert | Exit insert mode and save all buffers |
| `<C-s>` | Visual | Exit visual mode and save all buffers |

## Buffer & Tab Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | Normal | Next buffer |
| `<S-Tab>` | Normal | Previous buffer |
| `]s` | Normal | Next symbol (Aerial) |
| `[s` | Normal | Previous symbol (Aerial) |
| `<leader>bp` | Normal | Pin/unpin buffer |
| `<leader>bd` | Normal | Delete current buffer |
| `<leader>bx` | Normal | Delete non-pinned buffers |
| `<leader>bo` | Normal | Delete other buffers |
| `<leader>tn` | Normal | New tab |
| `<leader>tc` | Normal | Close current tab |
| `<leader>tb` | Normal | Open buffer in new tab |
| `<leader>tf` | Normal | New tab with file picker |

## LSP Operations

### Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gO` | Normal | Document symbols |
| `gW` | Normal | Workspace symbols |
| `gh` | Normal | Hover documentation |
| `gs` | Normal | Signature help |

### References & Actions (gr*)
| Key | Mode | Description |
|-----|------|-------------|
| `grr` | Normal | Find references |
| `gra` | Normal | Code actions |
| `grn` | Normal | Rename symbol |
| `gri` | Normal | Implementations |
| `grt` | Normal | Type definitions |

### LSP Performance
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lw` | Normal | Toggle LSP workspace scanning (for large projects) |

## Diagnostics

### Built-in Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `]d` | Normal | Next diagnostic |
| `[d` | Normal | Previous diagnostic |
| `]D` | Normal | Last diagnostic in buffer |
| `[D` | Normal | First diagnostic in buffer |
| `<C-w>d` | Normal | Open diagnostic float |

### Custom Actions (ge*)
| Key | Mode | Description |
|-----|------|-------------|
| `get` | Normal | Toggle diagnostics |
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
| `~` | Normal | Open parent directory |
| `g?` | Oil Buffer | Show help |
| `<CR>` | Oil Buffer | Select/Open file or directory |
| `<C-t>` | Oil Buffer | Open in new tab |
| `p` | Oil Buffer | Preview file |
| `x` | Oil Buffer | Close oil buffer |
| `r` | Oil Buffer | Refresh |
| `` ` `` | Oil Buffer | Change directory (cd) |
| `~` | Oil Buffer | Go to parent directory |
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
| `<leader>fa` | Normal | Symbols in current file (fzf) |
| `<leader>fA` | Normal | Symbols in workspace (fzf) |
| `<leader>fh` | Normal | Help tags |
| `<leader>fk` | Normal | Keymaps |
| `<leader>fc` | Normal | Commands |
| `<leader>f:` | Normal | Command history |
| `<leader>f/` | Normal | Search history |
| `<leader>fm` | Normal | Marks |
| `<leader>fj` | Normal | Jumps |
| `<leader>fl` | Normal | Resume last search |

## Aerial (Code Outline)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>a` | Normal | Toggle Aerial outline sidebar |
| `<leader>aA` | Normal | Toggle Aerial floating nav window |
| `]s` | Normal | Next symbol (Aerial) |
| `[s` | Normal | Previous symbol (Aerial) |

### Inside Aerial Window
| Key | Description |
|-----|-------------|
| `<CR>` | Jump to symbol |
| `p` | Preview (scroll without jumping) |
| `o` / `za` | Toggle fold (expand/collapse) |
| `q` | Close aerial |
| `{` / `}` | Previous/next symbol |
| `<C-v>` | Jump in vertical split |
| `<C-s>` | Jump in horizontal split |
| `?` / `g?` | Show help |

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
| `<leader>s` | Normal | Surround word (then type delimiter like `"`, `'`, `)`, `]`, `}`) |
| `<leader>S` | Normal | Surround WORD |
| `<leader>sl` | Normal | Surround entire line |
| `<leader>sc` | Normal | Change surround (e.g., `<leader>sc"'` changes `"` to `'`) |
| `<leader>sd` | Normal | Delete surround (e.g., `<leader>sd"` removes quotes) |
| `gS` | Visual | Surround selection (line-wise) |
| `<C-s>s` | Insert | Surround selection |
| `<C-s>S` | Insert | Surround line |

## Flash Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual/Operator | Flash jump (multi-character search) |
| `S` | Normal/Visual/Operator | Flash treesitter |
| `r` | Operator | Remote flash |
| `R` | Operator/Visual | Treesitter search |
| `f/F/t/T` | Normal | Find character forward/backward, till character forward/backward |
| `;` | Normal | Repeat last f/F/t/T motion forward |
| `,` | Normal | Repeat last f/F/t/T motion backward |

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

## Config Operations

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ce` | Normal | Edit Neovim config |
| `<leader>cr` | Normal | Reload config & sync plugins |

## Editor Operations

### Ergonomic Line Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `H` | Normal/Visual | Go to first non-blank character (ergonomic alternative to `^`) |
| `L` | Normal/Visual | Go to end of line (ergonomic alternative to `$`) |

## Session Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>qs` | Normal | Restore session |
| `<leader>ql` | Normal | Restore last session |
| `<leader>qd` | Normal | Stop session recording |

## Zen Mode

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>z` | Normal | Toggle Zen Mode (distraction-free) |

## Completion (Blink.cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Insert | Next completion |
| `<C-p>` | Insert | Previous completion |
| `<C-d>` | Insert | Scroll docs down |
| `<C-f>` | Insert | Scroll docs up |
| `<Tab>` | Insert | Accept completion |
| `<CR>` | Insert | Accept completion |
| `<C-Space>` | Insert | Accept completion |
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
