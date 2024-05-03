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


  for _, server in pairs(mason_lspconfig.get_installed_servers()) do
    require("lspconfig")[server].setup ({
          on_attach = function(client, bufnr)
   
              --  turn off formatting as this will be carried out by
              --  null-ls

              local client_filetypes = client.config.filetypes or {}
              for _, filetype in ipairs(client_filetypes) do

                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                     
              end


              --if client.name == "clangd" then
              --  client.offset_encoding = "utf-16"
              --end

          end,


        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    })
  end




end


return M