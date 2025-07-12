local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
}

function M.config()
  local lspconfig = require "lspconfig"
  local icons = require "config.icons"


  vim.diagnostic.config {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      header = "",
      prefix = "",
    },
  }

end


return M
