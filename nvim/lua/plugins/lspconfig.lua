local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "nvim-telescope/telescope.nvim",
    },
}

function M.config()
    local icons = require("config.icons")

    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
        },
    })

    -- Neovim 0.11+ native LSP configuration. Keep LSP keymaps centralised
    -- in config/keymaps.lua and install them only for attached buffers.
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(args)
            require("config.keymaps").on_lsp_attach(args)

        end,
    })
end

return M
