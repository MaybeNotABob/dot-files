local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
        opts = {
          config = {
            c = { __default = "// %s", __multiline = "/* %s */" },
            cpp = { __default = "// %s", __multiline = "/* %s */" },
          },
        },
    },
  },
}


function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { 
    -- languages to install
      "lua", "markdown", "markdown_inline", "bash", "python", "c", "cpp"
    }, 

    ignore_install = { "" },
    sync_install = false,
    highlight = {
      enable = true,
      disable = {},
      additional_vim_regex_highlighting = false,
    },

    indent = { 
      enable = true
     },
  }
  require("ts_context_commentstring").setup() 
end


return M