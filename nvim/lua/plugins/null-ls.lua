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
--  local diagnostics = null_ls.builtins.diagnostics



  null_ls.setup{
    --  ***** workaround *****
    --  force utf-8
    --  https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    on_init = function(new_client, _)
    new_client.offset_encoding = "utf-16"
    end,
    --  ***** workaround *****

    debug = false,
    sources = {
        formatting.clang_format.with {
            extra_args = {
                  "--style=" ..
                    [[{
                      BasedOnStyle: Google, 
                      BreakBeforeBraces: Allman,
                      AlignConsecutiveAssignments: true,
                      IndentWidth: 4,
                      UseTab: Never,
                      TabWidth: 4,
                      AllowShortFunctionsOnASingleLine: None,
                      AllowShortBlocksOnASingleLine: Empty,
                      AllowShortIfStatementsOnASingleLine: Never,
                      AllowShortEnumsOnASingleLine: false,
                      AlignConsecutiveMacros: true,
                      IncludeBlocks: Preserve,
                      IncludeCategories: [
                        { Regex: "^<.*>$", Priority: 1 },
                        { Regex: "^\".*\"", Priority: 2 }
                      ],
                      SortIncludes: true,
                    }]]
            }
        },
        -- null_ls.builtins.diagnostics.python-lsp-server,

        -- formatting.pyright.with {
        --     extra_args = {
        --       "--line-length=120",
        --       "--skip-string-normalization"
        --     },
        -- },
    },
  }
end


return M
