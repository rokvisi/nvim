# Generic

- Configure a way to grep search like in VSCode.
- Harpoon remove (generic) keybind just removes from the end of the list. Need to remove the current file if its in the list.

# Svelte specific

- Detect ambient types in svelte projects (For context: Infer load function type in +page.ts files.)
- Jump to / create +page.ts|+page.server.ts +server.ts files relative to current .svelte file and vice-versa.

# Known Issues

- using 'vim.cmd.Format' (provided by 'lsp-format' plugin) also writes the file.
- lsp-format doesn't format on first write. using 'vim.lsp.buf.format()' instead breaks folded regions >:(
- folding actions (za, zM, zR) take a while to start working because 'ufo.nvim' uses 'lsp' as the primary provider. the lsp attaches rather fast, but it takes a while for folds to strat working. need to figure out why.
- Harpoon marks with 'snacks.picker' can point to invalid rows or columns. this causes an error on navigation. Can be fixed with a custom accept function to check. (The rows and columns are update when)
