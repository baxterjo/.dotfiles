# Nvim Config

## Markdown

Markdown uses Marksman for links, heading completion, definitions, references,
and document symbols; render-markdown for in-editor rendering; bullets.nvim for
lists; and mdformat through Conform for formatting on save. MdKite provides the
browser preview, including Mermaid and math.

Prose wraps at word boundaries on screen without inserting hard line breaks.
`j` and `k` move through screen lines; counted motions such as `5j` keep their
usual meaning. English spell checking is enabled for Markdown (`z=` for
suggestions, `zg` to add a word, `:setlocal nospell` to turn it off).

| Key | Action |
| --- | --- |
| `<leader>cp` | Open the MdKite browser preview |
| `<leader>mr` | Toggle rendering for the current buffer |
| `<leader>mx` | Toggle the task checkbox on the current line |
| `Enter` in insert mode | Accept a selected completion, otherwise continue the list |
| `o` | Open the next line, continuing a list when applicable |
| `Ctrl-t` / `Ctrl-d` in insert mode | Indent / unindent a list item |
| `gN` in normal / visual mode | Renumber the current list / selection |

Press Enter again on an empty list item to finish the list. Task checkboxes use
`[ ]` and `[x]`. Tables and list spacing are formatted when saving; mdformat
preserves paragraph line breaks by default and respects project configuration.
Use `:MdKite stop` to stop the browser preview.

On a new machine:

1. Open Neovim and run `:Lazy sync` to install the plugins.
2. Run `:TSInstallAll` to install the configured parsers, including Markdown,
   inline Markdown, and HTML. Neovim 0.12 also bundles Markdown parsers.
3. Run `:MasonInstall mdformat`. Marksman is installed by mason-lspconfig.
4. For table formatting, install `mdformat-gfm` in mdformat's environment:
   `~/.local/share/nvim/mason/packages/mdformat/venv/bin/python -m pip install mdformat-gfm mdformat-frontmatter`.

Conform prefers a project's `.venv/bin/mdformat`, then Mason's mdformat,
then `mdformat` on PATH. Project virtualenvs also need `mdformat-gfm` for tables.
Use `:ConformInfo` to inspect formatter availability and
`:checkhealth render-markdown` to check rendering dependencies.

## Debugging Config
