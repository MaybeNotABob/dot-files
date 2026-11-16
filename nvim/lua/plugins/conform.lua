local M = {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
}

local function has_project_config(filenames, dirname)
    local path = (dirname and dirname ~= "") and dirname or vim.fn.getcwd()
    return vim.fs.find(filenames, {
        upward = true,
        path = path,
    })[1] ~= nil
end

local default_clang_format_style = table.concat({
    "{",
    "BasedOnStyle: Google,",
    "BreakBeforeBraces: Allman,",
    "AlignConsecutiveAssignments: true,",
    "IndentWidth: 4",
    "}",
}, " ")

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
                prepend_args = function(_, ctx)
                    if has_project_config({ ".clang-format", "_clang-format" }, ctx.dirname) then
                        return {}
                    end
                    return {
                        "--style=" .. default_clang_format_style,
                    }
                end,
            },
            stylua = {
                prepend_args = function(_, ctx)
                    if has_project_config({ "stylua.toml", ".stylua.toml" }, ctx.dirname) then
                        return {}
                    end
                    return {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                    }
                end,
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
