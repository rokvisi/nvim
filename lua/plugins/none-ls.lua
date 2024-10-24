return {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.black,
        --   require("none-ls.diagnostics.eslint_d"),
        }
      })
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        desc = "Autoformat on write, insert mode enter or leave",
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end,
  }