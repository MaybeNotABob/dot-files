local M = {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
        "mason-org/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
}

function M.config()
    require("mason").setup({
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", {
        capabilities = capabilities,
    })

    require("mason-lspconfig").setup({
        ensure_installed = {
            "clangd",         -- C/C++
            "lua_ls",         -- Lua language server
            "vimls",          -- Vim language server
            "pyright",        -- Python
        },
        automatic_enable = true,
    })

    require("mason-tool-installer").setup({
        ensure_installed = {
            "clang-format",   -- C/C++
            "stylua",         -- Lua
            "ruff",           -- Python
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        --debounce_hours = 1,
    })
end

return M
