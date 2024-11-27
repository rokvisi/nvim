return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.black,
      },
    })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      desc = "Autoformat on write, insert mode enter or leave",
      callback = function()
        local mode = vim.api.nvim_get_mode().mode
        local filetype = vim.bo.filetype

        if vim.bo.modified == true then
            vim.cmd('lua vim.lsp.buf.format()')
        end
      end
    })
  end,
}
