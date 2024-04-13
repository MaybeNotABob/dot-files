local M = {
  "nvimtools/none-ls.nvim",
  event = { "InsertEnter","BufReadPre", "BufNewFile" },
  dependencies = {
    {"nvim-lua/plenary.nvim"}
  }
}
  

function M.config()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  --local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup{
    debug = false,
    sources = {
        formatting.clang_format.with {
            args = {
               '--style={BasedOnStyle: google, BreakBeforeBraces: Allman, AlignConsecutiveAssignments: true}'
            }
        },
        formatting.black.with{
          extra_args = {
            "--line-length=120",
            "--skip-string-normalization"
          },
        },
    },
  }
end


return M
