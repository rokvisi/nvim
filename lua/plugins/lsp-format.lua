-- LSP-format.nvim is a wrapper around Neovims native LSP formatting.
-- It does:
-- Asynchronous or synchronous formatting on save
-- Sequential formatting with all attached LSP servers
-- Add commands for disabling formatting (globally or per filetype)
-- Make it easier to send format options to the LSP
-- Allow you to exclude specific LSP servers from formatting.
-- Preserves old buffer and only writes the diff. (Retains folds!!)

---@type LazySpec
return {
    'lukas-reineke/lsp-format.nvim',
    opts = {}
}
