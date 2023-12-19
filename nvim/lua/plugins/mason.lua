local M = {
  "williamboman/mason.nvim",
  lazy = false,

  dependencies = { 
   "williamboman/mason-lspconfig",
   "neovim/nvim-lspconfig"
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
    ensure_installed = {
      -- servers to install e.g. "pyright", "clangd"
    },
  })

  require("mason-lspconfig").setup_handlers({

    function (server_name)
        require("lspconfig")[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
    end

  })


end



return M
