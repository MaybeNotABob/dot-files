local M = {
  "williamboman/mason.nvim",
  lazy = false,

  dependencies = {
    "williamboman/mason-lspconfig",
    "jay-babu/mason-null-ls.nvim",
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
      "clangd",								--  C/C++
    }
  })


  for _, server in ipairs(mason_lspconfig.get_installed_servers()) do

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      --  turn off formatting as this will be carried out by
      --  null-ls
      local on_attach = function(client, bufnr)
          --client.server_capabilities.documentFormattingProvider       = false
          --client.server_capabilities.documentRangeFormattingProvider  = false
      end

      capabilities.offsetEncoding = { "utf-16" }

      require("lspconfig")[server].setup({
          on_attach     = on_attach,
          capabilities  = capabilities,
      })

  end

	-- auto configure formatters and ensure tooling 
	-- is installed
	local mason_null_ls = require("mason-null-ls")
	mason_null_ls.setup({
    ensure_installed = {
    	"clang-format",								--  C/C++
    	
    },
    automatic_installation = true,
    handlers = {},
	})


	-- override formatting settings
	-- e.g. clang-format
  local null_ls = require("plugins.null-ls").config()

  
end


return M
