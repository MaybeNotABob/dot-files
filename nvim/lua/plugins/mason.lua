local M = {
  "mason-org/mason-lspconfig.nvim",
  lazy = false,

  dependencies = {
    "mason-org/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },

  cmd = {
    "Mason", "MasonInstall", "MasonUpdate"
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
  
  -- mason_lspconfig.setup({
  --     -- list of servers for mason to install
  --   automatic_enable = false,
  --   ensure_installed = {
  --     "clangd",								--  C/C++
  --   }
  -- })

  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- local capabilities = cmp_nvim_lsp.default_capabilities()
      capabilities.offsetEncoding     = { "utf-16" }
      capabilities.positionEncodings  = { "utf-16" } 

  local lspconfig = require("lspconfig")

  --  turn off formatting as this will be carried out by
  --  null-ls
  local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider       = false
      client.server_capabilities.documentRangeFormattingProvider  = false
  end

  for _, server in ipairs(mason_lspconfig.get_installed_servers()) do

      -- local server_capabilities = vim.tbl_deep_extend("force", {}, capabilities)

      lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          -- capabilities = server_capabilities,
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
  local null_ls = require("plugins.null-ls")

  
end


return M
