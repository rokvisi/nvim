# Generic

Nothing.

# Svelte specific

-   After opening a svelte route file, attach harpoon marks to related route files (load, server, etc).

# Known Issues

-   For now, lsp formatting uses 'null-ls' only. If null-ls can't format or is not available, use the first available formatter instead.

-   folding actions (like za ) take a while to start working because 'ufo.nvim' uses 'lsp' as the primary provider.
    The lsp attaches rather quickly, but it takes a while for folds marks to appear. Need to figure out why or just use "treesitter" as the primary folding provider.

-   'vim.lsp.buf.hover()' invokes the hover in all language servers attached. Usually only 1 returns success and others notify about no available information.
    This can be silenced with 'snacks.notifier' option 'filter', but i'd rather prevent the notifications in general.
    The perfect behaviour would be to iterate over the results of all attached lsp servers and only send the notification if ALL servers return 'no information'.
    Another way to go about this would be to disable hover actions of specific language servers when attached to specific file types.
