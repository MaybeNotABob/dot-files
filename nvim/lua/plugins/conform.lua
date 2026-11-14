local M = {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
}

function M.config()
    require("conform").setup({
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            lua = { "stylua" },
            python = { "ruff_format" },
            -- python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        },
        formatters = {
            clang_format = {
                prepend_args = {
                    "--fallback-style={BasedOnStyle: Google, BreakBeforeBraces: Allman, AlignConsecutiveAssignments: true, IndentWidth: 4}",
                },
            },
            stylua = {
                prepend_args = {
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                },
            },
            ruff_format = {},
        },
        default_format_opts = {
            lsp_format = "never",
        },
        notify_on_error = true,
    })
end

return M
