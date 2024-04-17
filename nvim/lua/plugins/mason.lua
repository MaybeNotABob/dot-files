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
  })

  require('mason-lspconfig').setup({
      -- list of servers for mason to install
      ensure_installed = {
      "clangd",         --  C/C++
      "pyright",        --  Python
    }
  })  

  require("mason-lspconfig").setup_handlers({
      function (server_name)
          require("lspconfig")[server_name].setup({})
      end,
  })


end


return M