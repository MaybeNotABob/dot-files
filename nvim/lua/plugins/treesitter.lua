-- tree-sitter-cli required with 0.12 >
--
-- sudo apt install tree-sitter-cli
-- pacman -S tree-sitter-cli
--
local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
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
    require("nvim-treesitter").setup({
        auto_install = true,
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
        },
        highlight = { enable = true },
    })
end

return M
