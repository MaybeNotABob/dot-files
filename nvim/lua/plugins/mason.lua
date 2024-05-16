local M = {
  "williamboman/mason.nvim",
  lazy = false,

  dependencies = {
    "williamboman/mason-lspconfig",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },

  cmd = {
    "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate"
  },

}

function M.config()

  require("mason").setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })

  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
      "clangd",         --  C/C++
      "pyright",        --  Python
    }
  })

  for _, server in ipairs(mason_lspconfig.get_installed_servers()) do

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      --  turn off formatting as this will be carried out by
      --  null-ls
      local on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
      end

      capabilities.offsetEncoding = { "utf-16" }

      require("lspconfig")[server].setup({
          capabilities = capabilities,
      })

  end


end


return M
