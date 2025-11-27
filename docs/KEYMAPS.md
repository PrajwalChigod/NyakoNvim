# NyakoNvim Keymaps Cheatsheet

## Basic Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `jj` | Insert | Exit insert mode |
| `<Esc>` | Normal/Insert/Visual | Clear search highlights (also exit mode if in insert/visual) |
| `gg` | Normal | Go to top of file |
| `gG` | Normal | Go to end of file |
| `<C-h/j/k/l>` | Normal | Navigate between splits |
| `<C-d>` | Normal | Page down (centered) |
| `<C-u>` | Normal | Page up (centered) |
| `n` / `N` | Normal | Next/Previous search (centered) |
| `J` | Normal | Join lines (keep cursor position) |

## Insert Mode Navigation

> `<localleader>` is set to `;` (configured via `maplocalleader`).

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

## Quickfix

| Key | Mode | Description |
|-----|------|-------------|
| `<localleader>q` | Normal | Toggle quickfix list |
| `<localleader>qa` | Normal | Add current line to quickfix |
| `<leader>qc` | Normal | Clear quickfix list |

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

## File Explorer (Fyler)

| Key | Mode | Description |
|-----|------|-------------|
| `-` | Normal | Open Fyler at the current file |
| `_` | Normal | Open Fyler in floating window |

## Fuzzy Finding (FZF)

### Find (by name/location)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>f` | Normal | Find files |
| `<leader>fg` | Normal | Find git files |
| `<leader>fo` | Normal | Find recent files |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Help tags |
| `<leader>fk` | Normal | Keymaps |
| `<leader>fc` | Normal | Commands |
| `<leader>fm` | Normal | Marks |
| `<leader>fj` | Normal | Jumps |
| `<leader>fl` | Normal | Resume last search |
| `<leader>fa` | Normal | Symbols in current file (fzf) |
| `<leader>fA` | Normal | Symbols in workspace (fzf) |

### Search (by content)
| Key | Mode | Description |
|-----|------|-------------|
| `/` | Normal | Native search (forward) |
| `?` | Normal | Native search (backward) |
| `<leader>s` | Normal | Grep current buffer |
| `<leader>sw` | Normal | Search word under cursor |
| `<leader>sW` | Normal | Search WORD under cursor |
| `<leader>sg` | Normal | Live grep |
| `<leader>sc` | Normal | Command history |
| `<leader>sh` | Normal | Search history |

## Comments (gc*)

| Key | Mode | Description |
|-----|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gcf` | Normal | Comment function |
| `gcO` | Normal | Add comment above |
| `gco` | Normal | Add comment below |
| `gcA` | Normal | Add comment at end of line |
| `gc` | Visual | Comment selection |

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

### Add Surround
| Key | Mode | Description |
|-----|------|-------------|
| `ys{motion}{char}` | Normal | Surround motion with character (e.g., `ysiw"` = surround word with quotes) |
| `yss{char}` | Normal | Surround entire line (e.g., `yss)` = surround line with parentheses) |
| `yS{motion}{char}` | Normal | Surround motion (linewise with newlines) |
| `ySS{char}` | Normal | Surround line (linewise with newlines) |
| `S{char}` | Visual | Surround selection |
| `gS{char}` | Visual | Surround selection (linewise with newlines) |
| `<C-g>s{char}` | Insert | Surround selection |
| `<C-g>S{char}` | Insert | Surround line (linewise with newlines) |

### Change Surround
| Key | Mode | Description |
|-----|------|-------------|
| `cs{old}{new}` | Normal | Change surround (e.g., `cs"'` = change `"` to `'`) |
| `cS{old}{new}` | Normal | Change surround (linewise with newlines) |

### Delete Surround
| Key | Mode | Description |
|-----|------|-------------|
| `ds{char}` | Normal | Delete surround (e.g., `ds"` = remove quotes) |

### Aliases (shortcuts for common pairs)
- `a` = `>` (angle brackets)
- `b` = `)` (round brackets/parentheses)
- `B` = `}` (curly Brackets)
- `r` = `]` (square bRackets)
- `q` = any quote (`"`, `'`, `` ` ``)
- `s` = any surround (`}`, `]`, `)`, `>`, quotes)
- `t` = HTML/XML tag

**Examples:**
- `ysiw"` = surround inner word with quotes
- `yss)` = surround line with parentheses
- `cs"'` = change double quotes to single quotes
- `ds{` = delete surrounding braces
- `dsb` = delete surrounding parentheses (using alias)
- `ySiwB` = surround word with braces on new lines

## Flash Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual | Flash jump (multi-character search) |
| `S` | Normal | Flash treesitter (Visual mode reserved for surround) |
| `r` | Operator | Remote flash |
| `R` | Operator/Visual | Treesitter search |

**Note**: `f/F/t/T` motions are disabled in favor of Flash navigation (`s` key). `;` is used as localleader.

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

### Swap
| Key | Mode | Description |
|-----|------|-------------|
| `]S` | Normal | Swap with next parameter |
| `[S` | Normal | Swap with previous parameter |
| `]s` | Normal | Swap with next function |
| `[s` | Normal | Swap with previous function |

## Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>g` | Normal | Open LazyGit |
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
| `<leader>gco` | Normal | Pick ours in conflict |
| `<leader>gct` | Normal | Pick theirs in conflict |
| `<leader>gcb` | Normal | Keep both sides in conflict |
| `<leader>gcn` | Normal | Keep none in conflict |
| `]x` | Normal | Next conflict marker |
| `[x` | Normal | Previous conflict marker |
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
- **Local leader key**: `;`
- Most commands work with counts (e.g., `3gcc` comments 3 lines)
- Visual mode works with most text operations
- LSP features require active language server
- `f/F/t/T` motions are disabled - use Flash navigation (`s`) instead
