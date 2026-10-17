# Neovim keybindings — sorted and grouped (v2)

Leader is `<Space>`. Modes: `n` normal · `x` visual · `o` operator-pending · `s`
select · `i` insert · `c` command-line · `v` = `x` + `s`. Sections 1–10 are your
own mappings (set in `init.lua`). Sections 11–13 are Neovim 0.12 defaults and
plugin built-ins.

## Total binds

| Source                    | Entries | Unique Keys |
| ------------------------- | ------- | ----------- |
| This config               | 201     | 163         |
| Neovim 0.12               | 59      | 53          |
| Plugin built-ins          | 15      | 7           |
| Internal `<Plug>` targets | 16      | 16          |
| Total                     | 275     | 220         |

## Leader map at a glance

| `<Space>` + | Group                                                                                 | Plugin                          |
| ----------- | ------------------------------------------------------------------------------------- | ------------------------------- |
| `b…`        | Buffers                                                                               | bufferline / bufdelete          |
| `cc`        | Colour picker                                                                         | ccc                             |
| `d…`        | Debug                                                                                 | nvim-dap                        |
| `e`         | Focus file tree                                                                       | Neo-tree                        |
| `f…`        | Pickers (`ff fg fb fh fl* fv*`…) and `fz` = fzf files                                 | Telescope / fzf-lua             |
| `g…`        | Git pickers (`gb gd gs`)                                                              | fzf-lua                         |
| `h…`        | Hunks (`hs hr hS hR hu hP hb hd hD`)                                                  | Gitsigns                        |
| `j…`        | Jujutsu (`jj` status picker, `jd*` describe/diff, `jg*` pickers, `jb*`, `jt*`, `jp*`) | jj.nvim                         |
| `k`         | Toggle hover docs                                                                     | LSP                             |
| `l…`        | LSP lists (`ld lr lwd`), `lo` otter                                                   | Trouble / otter                 |
| `m…`        | SSH mounts                                                                            | sshfs.nvim                      |
| `n…`        | New buffer (`nn`), tree toggle (`nt`)                                                 | Neo-tree                        |
| `r…`        | Rustlings                                                                             | rustlings.nvim                  |
| `s…`        | Leap (`ss sS sx sX`), `sj` JJ squash                                                  | Leap                            |
| `t…`        | Toggles (`tt tb td`), todo lists (`tdt tds tdq`)                                      | misc / Gitsigns / todo-comments |
| `u`         | Undo history                                                                          | fzf-lua                         |
| `x…`        | Diagnostics/lists (`xx xX xs xl xL xq xQ`)                                            | Trouble                         |
| `/` `;`     | Live grep, resume last picker                                                         | fzf-lua                         |

---

## What changed since the previous file

**Moved or renamed**

- JJ describe: `<Space>jd` → `<Space>jdd`.
- JJ diff / hdiff current buffer: `<Space>df` / `dF` → `<Space>jdf` / `jdF`.
- JJ status picker: `<Space>gj` → `<Space>jj`.
- `<Tab>` is now next buffer and `<S-Tab>` previous (they were the other way
  round).
- Arrow-key versions of mini.move added (`<M-Up>` `<M-Down>` `<M-Left>`
  `<M-Right>`), alongside `<M-h/j/k/l>`.
- Most mappings now have descriptions.

**Present before, gone now** (check these were removed on purpose)

- lazygit: `<Space>gg`.
- Harpoon: `<Space>a`, `<C-E>`, `<C-J>`, `<C-K>`, `<C-L>`, `<C-;>`.
- Git-conflict: `<Space>co` `ct` `cb` `c0`, `[x`, `]x`.
- `<Space>cs` (colour schemes), `<Space>d` (diagnostic float).
- `K` (toggle LSP hover), `f<Space>` (format), visual `J` / `K` (move lines).
- `<C-Q>` and `<C-X>` in modes other than normal.
- `<C-L>` is back to the Neovim default (clear highlight and redraw).

---

## 1. Core editing, files and quitting

| Mode        | Key        | Action                                                    |
| ----------- | ---------- | --------------------------------------------------------- |
| n           | `<Esc>`    | Clear highlights                                          |
| n x o s i c | `<C-S>`    | Save                                                      |
| n x o s i c | `<M-q>`    | Save, then force-quit (`:write` + `:q!`)                  |
| n           | `<C-Q>`    | Force-quit, discards changes (`:q!`)                      |
| n           | `<C-X>`    | Force-delete buffer (`:bdelete!`)                         |
| n           | `<M-w>`    | Delete buffer (`:bdelete`)                                |
| n           | `<Tab>`    | Next buffer                                               |
| n           | `<S-Tab>`  | `:previous` (arglist command, labelled "previous buffer") |
| n           | `<M-Left>` | Go to end of previous word (`ge`)                         |
| n           | `-`        | Open Oil file explorer                                    |
| n           | `<C-T>`    | Toggle terminal (toggleterm)                              |
| n           | `jj`       | Open jujutsu (`:J`)                                       |
| n           | `j`        | Disabled (`<Nop>`)                                        |
| n           | `x`        | Disabled (`<Nop>`)                                        |
| n x o s i c | `<F1>`     | Disabled (`<Nop>`)                                        |
| i           | `<M-t>`    | Insert a literal Tab                                      |

### Move lines and selections (mini.move)

| Mode | Key                                        | Action                                  |
| ---- | ------------------------------------------ | --------------------------------------- |
| n    | `<M-h>` `<M-j>` `<M-k>` `<M-l>`            | Move line left / down / up / right      |
| n    | `<M-Up>` `<M-Down>` `<M-Right>`            | Move line up / down / right             |
| x    | `<M-h>` `<M-j>` `<M-k>` `<M-l>`            | Move selection left / down / up / right |
| v    | `<M-Up>` `<M-Down>` `<M-Left>` `<M-Right>` | Move selection up / down / left / right |

### Comments

| Mode | Key   | Action                          |
| ---- | ----- | ------------------------------- |
| n    | `gcc` | Toggle current line comment     |
| n    | `gc`  | Toggle line comment (operator)  |
| x    | `gc`  | Toggle selected comment         |
| o    | `gc`  | Comment text object             |
| n    | `gb`  | Toggle block comment (operator) |
| n    | `gbc` | Toggle current block comment    |
| x    | `gb`  | Toggle selected block           |

---

## 2. Buffers

| Mode | Key          | Action                       |
| ---- | ------------ | ---------------------------- |
| n    | `<Tab>`      | Next buffer                  |
| n    | `<Space>bn`  | Next buffer (bufferline)     |
| n    | `<Space>bp`  | Previous buffer (bufferline) |
| n    | `<Space>bc`  | Pick buffer                  |
| n    | `<Space>bx`  | Close buffer (bufdelete)     |
| n    | `<M-w>`      | Close buffer (`:bdelete`)    |
| n    | `<C-X>`      | Force close buffer           |
| n    | `<Space>bmn` | Move buffer next             |
| n    | `<Space>bmp` | Move buffer previous         |
| n    | `<Space>bsd` | Sort by directory            |
| n    | `<Space>bse` | Sort by extension            |
| n    | `<Space>bsi` | Sort by ID                   |
| n    | `<Space>nn`  | New empty buffer (`:enew`)   |

---

## 3. Navigation

### File tree and explorers

| Mode | Key         | Action                         |
| ---- | ----------- | ------------------------------ |
| n    | `-`         | Oil                            |
| n    | `<Space>e`  | Neo-tree: focus                |
| n    | `<Space>nt` | Neo-tree: toggle               |
| n    | `gO`        | Toggle aerial (symbol outline) |

### Leap

| Mode  | Key         | Action             |
| ----- | ----------- | ------------------ |
| n x o | `<Space>ss` | Leap forward       |
| n x o | `<Space>sS` | Leap backward      |
| n x o | `<Space>sx` | Leap forward till  |
| n x o | `<Space>sX` | Leap backward till |
| n x o | `gs`        | Leap from window   |

---

## 4. Search and pickers

### fzf-lua

| Mode | Key          | Action             |
| ---- | ------------ | ------------------ |
| n    | `<Space>fz`  | Files              |
| n    | `<Space>fz/` | Live grep          |
| n    | `<Space>fz;` | Resume last picker |
| n    | `<Space>u`   | Undo history       |
| n    | `<Space>gb`  | Git branches       |
| n    | `<Space>gd`  | Git diff           |
| n    | `<Space>gs`  | Git status         |

### Telescope: general

| Mode | Key         | Action                 |
| ---- | ----------- | ---------------------- |
| n    | `<Space>ff` | Find files             |
| n    | `<Space>fg` | Live grep              |
| n    | `<Space>fb` | Buffers                |
| n    | `<Space>fh` | Help tags              |
| n    | `<Space>ft` | Open Telescope         |
| n    | `<Space>fr` | Resume previous search |
| n    | `<Space>fp` | Projects               |
| n    | `<Space>fs` | Treesitter             |

### Telescope: git (`<Space>fv…`)

| Mode | Key           | Action             |
| ---- | ------------- | ------------------ |
| n    | `<Space>fvf`  | Git files          |
| n    | `<Space>fvs`  | Git status         |
| n    | `<Space>fvb`  | Git branches       |
| n    | `<Space>fvcw` | Git commits        |
| n    | `<Space>fvcb` | Git buffer commits |
| n    | `<Space>fvx`  | Git stash          |

### Telescope: LSP (`<Space>fl…`)

| Mode | Key           | Action            |
| ---- | ------------- | ----------------- |
| n    | `<Space>fld`  | Diagnostics       |
| n    | `<Space>flD`  | Definitions       |
| n    | `<Space>flt`  | Type definitions  |
| n    | `<Space>fli`  | Implementations   |
| n    | `<Space>flr`  | References        |
| n    | `<Space>flsb` | Document symbols  |
| n    | `<Space>flsw` | Workspace symbols |

### SSH remote search (`<Space>m…`)

| Mode | Key         | Action             |
| ---- | ----------- | ------------------ |
| n    | `<Space>mf` | Find files         |
| n    | `<Space>mg` | Grep files         |
| n    | `<Space>mF` | Live find (remote) |
| n    | `<Space>mG` | Live grep (remote) |

---

## 5. LSP, diagnostics and todo lists

### Your mappings

| Mode | Key         | Action                         |
| ---- | ----------- | ------------------------------ |
| n    | `<Space>k`  | Toggle hover docs              |
| n    | `<Space>lo` | Activate LSP at cursor (otter) |

### Trouble

| Mode | Key          | Action                                   |
| ---- | ------------ | ---------------------------------------- |
| n    | `<Space>xx`  | Diagnostics (all)                        |
| n    | `<Space>xX`  | Diagnostics (current buffer)             |
| n    | `<Space>xs`  | Symbols                                  |
| n    | `<Space>xq`  | Quickfix                                 |
| n    | `<Space>xQ`  | Quickfix (`Trouble qflist toggle`)       |
| n    | `<Space>xl`  | Location list                            |
| n    | `<Space>xL`  | Location list (`Trouble loclist toggle`) |
| n    | `<Space>ld`  | Document diagnostics                     |
| n    | `<Space>lwd` | Workspace diagnostics                    |
| n    | `<Space>lr`  | LSP references                           |

### Todo comments

| Mode | Key          | Action             |
| ---- | ------------ | ------------------ |
| n    | `<Space>tdt` | Todos in Trouble   |
| n    | `<Space>tds` | Todos in Telescope |
| n    | `<Space>tdq` | Todos in quickfix  |

---

## 6. Git (Gitsigns and fzf-lua)

### Gitsigns

| Mode | Key         | Action               |
| ---- | ----------- | -------------------- |
| n    | `]c` / `[c` | Next / previous hunk |
| n v  | `<Space>hs` | Stage hunk           |
| n v  | `<Space>hr` | Reset hunk           |
| n    | `<Space>hS` | Stage buffer         |
| n    | `<Space>hR` | Reset buffer         |
| n    | `<Space>hu` | Undo stage hunk      |
| n    | `<Space>hP` | Preview hunk         |
| n    | `<Space>hb` | Blame line           |
| n    | `<Space>hd` | Diff this            |
| n    | `<Space>hD` | Diff project         |
| n    | `<Space>tb` | Toggle blame         |
| n    | `<Space>td` | Toggle deleted       |

### Pickers

| Mode | Key          | Action                            |
| ---- | ------------ | --------------------------------- |
| n    | `<Space>gb`  | fzf-lua: git branches             |
| n    | `<Space>gd`  | fzf-lua: git diff                 |
| n    | `<Space>gs`  | fzf-lua: git status               |
| n    | `<Space>fv…` | Telescope git pickers (section 4) |

---

## 7. Jujutsu (`<Space>j…`)

| Mode | Key          | Action              |
| ---- | ------------ | ------------------- |
| n    | `jj`         | Open jujutsu (`:J`) |
| n    | `<Space>js`  | Status              |
| n    | `<Space>jy`  | Picker: status      |
| n    | `<Space>jl`  | Log                 |
| n    | `<Space>jL`  | Log all             |
| n    | `<Space>jdd` | Describe            |
| n    | `<Space>je`  | Edit                |
| n    | `<Space>jn`  | New                 |
| n    | `<Space>jq`  | Squash              |
| n    | `<Space>jr`  | Rebase              |
| n    | `<Space>ja`  | Abandon             |
| n    | `<Space>ju`  | Undo                |
| n    | `<Space>jy`  | Redo                |
| n    | `<Space>jf`  | Fetch               |
| n    | `<Space>jtt` | Tug                 |

### Diff

| Mode | Key          | Action               |
| ---- | ------------ | -------------------- |
| n    | `<Space>jdf` | Diff current buffer  |
| n    | `<Space>jdF` | hdiff current buffer |

### Push and PRs

| Mode | Key          | Action                                              |
| ---- | ------------ | --------------------------------------------------- |
| n    | `<Space>jpp` | Push                                                |
| n    | `<Space>jpa` | Push all to origin                                  |
| n    | `<Space>jpr` | Open PR from bookmark in current revision or parent |
| n    | `<Space>jpl` | Open PR listing available bookmarks                 |

### Bookmarks and tags

| Mode | Key          | Action           |
| ---- | ------------ | ---------------- |
| n    | `<Space>jbc` | Bookmark create  |
| n    | `<Space>jbm` | Bookmark move    |
| n    | `<Space>jbd` | Bookmark delete  |
| n    | `<Space>jba` | Bookmark advance |
| n    | `<Space>jts` | Tag set          |
| n    | `<Space>jtd` | Tag delete       |
| n    | `<Space>jtp` | Tag push         |

### Pickers

| Mode | Key          | Action                    |
| ---- | ------------ | ------------------------- |
| n    | `<Space>jj`  | Picker: status            |
| n    | `<Space>jgh` | Picker: history           |
| n    | `<Space>jgc` | Picker: conflicts         |
| n    | `<Space>jgs` | Picker: conflict sections |

---

## 8. Debugging (nvim-dap, `<Space>d…`)

| Mode | Key          | Action              |
| ---- | ------------ | ------------------- |
| n    | `<Space>db`  | Toggle breakpoint   |
| n    | `<Space>dc`  | Continue            |
| n    | `<Space>dgc` | Continue to cursor  |
| n    | `<Space>dgj` | Next step           |
| n    | `<Space>dgi` | Step into           |
| n    | `<Space>dgo` | Step out            |
| n    | `<Space>dgk` | Step back           |
| n    | `<Space>dvo` | Go up stacktrace    |
| n    | `<Space>dvi` | Go down stacktrace  |
| n    | `<Space>dh`  | Hover               |
| n    | `<Space>dr`  | Toggle REPL         |
| n    | `<Space>d.`  | Re-run last session |
| n    | `<Space>dR`  | Restart             |
| n    | `<Space>dq`  | Terminate           |

---

## 9. SSH mounts (sshfs.nvim, `<Space>m…`)

`<Space>m` itself is a `<Nop>` used as the "mount" group label.

| Mode | Key                        | Action                             |
| ---- | -------------------------- | ---------------------------------- |
| n    | `<Space>mm`                | Mount a server                     |
| n    | `<Space>mu`                | Unmount a server                   |
| n    | `<Space>mU`                | Unmount all servers                |
| n    | `<Space>me`                | Explore mount                      |
| n    | `<Space>md`                | Change dir to mount                |
| n    | `<Space>mo`                | Run command on mount               |
| n    | `<Space>mt`                | Open SSH terminal                  |
| n    | `<Space>mc`                | Edit SSH config                    |
| n    | `<Space>mr`                | Reload SSH config                  |
| n    | `<Space>mf` `mg` `mF` `mG` | Remote find / grep (see section 4) |

---

## 10. Misc

| Mode | Key           | Action                                           |
| ---- | ------------- | ------------------------------------------------ |
| n    | `<Space>cc`   | Colour picker (ccc)                              |
| n    | `<Space>tt`   | Toggle transparency and regenerate matugen theme |
| n    | `<Space>rn`   | Rustlings: next exercise                         |
| n i  | `<MouseMove>` | Bufferline hover                                 |

---

## 11. Insert, select and command-line mode

| Mode | Key                    | Action                                                 |
| ---- | ---------------------- | ------------------------------------------------------ |
| i    | `<C-S>` `<M-q>` `<F1>` | Same as section 1                                      |
| i    | `<M-t>`                | Insert a literal Tab                                   |
| c    | `<C-S>` `<M-q>` `<F1>` | Same as section 1                                      |
| s    | `<C-S>` `<M-q>` `<F1>` | Same as section 1                                      |
| s i  | `<Tab>` / `<S-Tab>`    | Jump in active snippet, otherwise normal key (default) |
| i    | `<C-W>` / `<C-U>`      | Delete word / line, with undo break (default)          |
| c    | `<C-R><C-G>`           | Insert fugitive object path (fugitive)                 |

---

## 12. Neovim 0.12 defaults

### LSP

| Mode | Key   | Action          |
| ---- | ----- | --------------- |
| n    | `grn` | Rename          |
| n x  | `gra` | Code action     |
| n    | `grr` | References      |
| n    | `gri` | Implementation  |
| n    | `grt` | Type definition |
| n    | `grx` | Run codelens    |

### Diagnostics

| Mode | Key                     | Action                        |
| ---- | ----------------------- | ----------------------------- |
| n    | `[d` / `]d`             | Previous / next diagnostic    |
| n    | `[D` / `]D`             | First / last diagnostic       |
| n    | `<C-W>d` / `<C-W><C-D>` | Show diagnostics under cursor |

### Bracket pairs (previous / next)

| Mode | Key                     | Action                          |
| ---- | ----------------------- | ------------------------------- |
| n    | `[b` / `]b`             | `:bprevious` / `:bnext`         |
| n    | `[B` / `]B`             | `:brewind` / `:blast`           |
| n    | `[l` / `]l`             | `:lprevious` / `:lnext`         |
| n    | `[L` / `]L`             | `:lrewind` / `:llast`           |
| n    | `[<C-L>` / `]<C-L>`     | `:lpfile` / `:lnfile`           |
| n    | `[a` / `]a`             | `:previous` / `:next` (arglist) |
| n    | `[A` / `]A`             | `:rewind` / `:last`             |
| n    | `[t` / `]t`             | `:tprevious` / `:tnext`         |
| n    | `[T` / `]T`             | `:trewind` / `:tlast`           |
| n    | `[<C-T>` / `]<C-T>`     | `:ptprevious` / `:ptnext`       |
| n    | `[<Space>` / `]<Space>` | Add empty line above / below    |

The quickfix pairs `[q` `]q` `[Q` `]Q` `[<C-Q>` `]<C-Q>` do not appear in this
export.

### Treesitter selection

| Mode | Key         | Action                              |
| ---- | ----------- | ----------------------------------- |
| x    | `[n` / `]n` | Select previous / next node         |
| x    | `[N` / `]N` | Select previous / next sibling node |
| x o  | `an`        | Select parent (outer) node          |
| x o  | `in`        | Select child (inner) node           |

### Other

| Mode | Key       | Action                                            |
| ---- | --------- | ------------------------------------------------- |
| n    | `<C-L>`   | Clear highlight, update diff, redraw              |
| n x  | `gx`      | Open path or URI under cursor with system handler |
| n    | `&`       | Repeat last `:s` (`:&&`)                          |
| n    | `Y`       | Yank to end of line (`y$`)                        |
| x    | `*` / `#` | Search selection forward / backward               |
| x    | `@`       | Run macro on each selected line (linewise)        |
| x    | `Q`       | Replay last recorded macro on each selected line  |

---

## 13. Plugin built-ins

| Plugin   | Mode  | Key                     | Action                           |
| -------- | ----- | ----------------------- | -------------------------------- |
| matchit  | n x o | `%`                     | Jump to matching pair (forward)  |
| matchit  | n x o | `g%`                    | Jump to matching pair (backward) |
| matchit  | n x o | `[%` / `]%`             | Previous / next unmatched group  |
| matchit  | x     | `a%`                    | Select matching-pair text object |
| fugitive | n     | `y<C-G>`                | Yank fugitive object path        |
| fugitive | c     | `<C-R><C-G>`            | Insert fugitive object path      |
| plenary  | n     | `<Plug>PlenaryTestFile` | Run current file as a test       |

---

## 14. Cleanup flags

### Likely bugs

- `<S-Tab>` runs `:previous` (argument list), not `:bprevious`. Its description
  says "previous buffer", so this probably should be `:bprevious`.
- `<M-Left>` in normal mode is `ge`, which overrides mini.move's "move line
  left". `<M-h>` still moves the line left, so only the arrow version is
  affected.

### Prefix clashes (the shorter key waits for `timeoutlen` before firing)

- `<Space>f` (fzf files) vs every `<Space>f…` Telescope map.
- `<Space>td` (toggle deleted) vs `<Space>tdt` / `tds` / `tdq`.

The old `<Space>d` clash is gone now that the diagnostic float is removed.

### Overlapping functionality

- Two pickers: fzf-lua and Telescope both cover files, grep, resume, git status
  and git branches.
- Trouble duplicates: `xl` / `xL` (loclist) and `xq` / `xQ` (quickfix).
- Diagnostics lists: `xX`, `ld` and `fld`.
- Git status: `<Space>gs` (fzf), `fvs` (Telescope), `js` / `jj` (JJ).
- Close buffer: `<Space>bx`, `<M-w>` and `<C-X>`.
- Next buffer: `<Tab>`, `<Space>bn` and `]b`.
- Mini.move: arrow keys and `<M-hjkl>` do the same thing.

### Mnemonic outliers

- `<Space>rn` is Rustlings, but rename is `grn`.
- `<Space>t` mixes transparency, Gitsigns toggles and todo lists.
- `<Space>g` now holds only fzf git pickers, while the `fv…` Telescope git
  pickers live under `f`.

### Risky keys

- `<C-Q>` (`:q!`) and `<C-X>` (`:bdelete!`) discard unsaved changes without a
  prompt.
- `<M-q>` writes first but works in insert and command-line mode too, so a stray
  press closes Neovim.
- `<F1>` is disabled in every mode, `j` and `x` in normal mode (intentional per
  their descriptions).

### Shadowed built-ins

- `<Tab>` = `<C-I>` (jumplist forward).
- `<C-T>` (tag stack pop).
- `<C-Q>` (alternate visual-block key).
- `<C-X>` is no longer shadowed in insert mode.
