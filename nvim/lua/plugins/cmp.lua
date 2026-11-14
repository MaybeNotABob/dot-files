local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
    },
}

function M.config()
    local cmp = require("cmp")
    local icons = require("config.icons")

    cmp.setup({
        enabled = function()
            if vim.bo[0].buftype == "prompt" then
                return false
            end

            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end,

        mapping = cmp.mapping.preset.insert({
            ["<C-d>"] = cmp.mapping.scroll_docs(-1),
            ["<C-f>"] = cmp.mapping.scroll_docs(1),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),

        formatting = {
            fields = { "kind", "abbr" },
            format = function(entry, vim_item)
                vim_item.kind = icons.kind[vim_item.kind]
                vim_item.menu = ({
                    nvim_lsp = "",
                    nvim_lua = "",
                    buffer = "",
                    path = "",
                })[entry.source.name]

                local function trim(value)
                    local max_len = 50
                    if value and #value > max_len then
                        return value:sub(1, max_len) .. " ..."
                    end
                    return value
                end

                vim_item.abbr = trim(vim_item.abbr)
                return vim_item
            end,
        },

        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "buffer", keyword_length = 3 },
            { name = "path", keyword_length = 3 },
        },

        window = {
            completion = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
                col_offset = -3,
                side_padding = 1,
                scrollbar = false,
                scrolloff = 8,
            },
            documentation = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            },
        },

        experimental = {
            ghost_text = false,
        },
    })
end

return M
