# Generic

-   Harpoon remove (generic) keybind just removes from the end of the list. Need to remove the current file if its in the list.
-   Null-ls uses the 'none-ls-extras.nvim' dependancy, but doesn't use it.

# Svelte specific

-   Jump to / create +page.ts|+page.server.ts +server.ts files relative to current .svelte file and vice-versa.

# Known Issues

-   For now, lsp formatting uses 'null-ls' only. If null-ls can't format or is not available, use the first available formatter instead.

-   folding actions (like za ) take a while to start working because 'ufo.nvim' uses 'lsp' as the primary provider. the lsp attaches rather fast, but it takes a while for folds to strat working. need to figure out why. or just use "treesitter" as the folding provider.

-   'vim.lsp.buf.hover()' invokes the hover in all language servers attached. Usually only 1 returns success and others notify about no available information.
    This can be silenced with 'snacks.notifier' option 'filter', but i'd rather prevent the notifications in general.
    The perfect behaviour would be to iterate over the results of all attached lsp servers and only send the notification if ALL servers return 'no information'.
    Another way to go about this would be to disable hover actions of specific language servers when attached to specific file types.
