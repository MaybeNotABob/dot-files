local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",

    config = function()
        local plugin_indent_blankline = require("ibl")

        plugin_indent_blankline.setup({
            scope = {
                enabled = true,
            },
        })
    end,
}

return M