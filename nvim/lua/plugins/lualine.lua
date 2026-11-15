local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

local FUNCTION_NODES = {
    function_definition = true,      -- C, C++, Python, Lua (anonymous), Bash
    function_declaration = true,     -- Lua (named), Go, JS/TS
    function_item = true,            -- Rust
    method_definition = true,        -- JS/TS, Ruby
    method_declaration = true,       -- Go, Java, C#
    constructor_declaration = true,  -- Java, C#
    destructor_declaration = true,   -- C#
}

local function extract_function_name(node, bufnr)
    local name_node = node:field("name")[1]
    if name_node then
        return vim.treesitter.get_node_text(name_node, bufnr)
    end

    local decl = node:field("declarator")[1]
    while decl do
        local t = decl:type()
        if t == "identifier"
            or t == "field_identifier"
            or t == "qualified_identifier"
            or t == "destructor_name"
            or t == "operator_name"
        then
            return vim.treesitter.get_node_text(decl, bufnr)
        end

        local next_decl = decl:field("declarator")[1]
        if not next_decl and t == "parenthesized_declarator" then
            next_decl = decl:named_child(0)
        end
        decl = next_decl
    end

    return ""
end

local function update_current_function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    -- Rely on Neovim's already-parsed tree instead of forcing parser:parse()
    local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr })
    if not ok or not node then
        vim.b[bufnr].lualine_current_func = ""
        return
    end

    while node do
        if FUNCTION_NODES[node:type()] then
            vim.b[bufnr].lualine_current_func = extract_function_name(node, bufnr)
            return
        end
        node = node:parent()
    end

    vim.b[bufnr].lualine_current_func = ""
end

function M.config()
    local icons = require("config.icons")
    local lualine = require("lualine")
    local augroup = vim.api.nvim_create_augroup("LualineCustom", { clear = true })

    -- Debounced Treesitter context updates so typing/scrolling stays fast
    local ts_timer = nil
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "InsertLeave" }, {
        group = augroup,
        callback = function(args)
            if ts_timer then
                ts_timer:stop()
                ts_timer:close()
            end
            ts_timer = vim.defer_fn(function()
                ts_timer = nil
                update_current_function(args.buf)
            end, 50)
        end,
    })

    -- Instant macro recording indicator updates
    vim.api.nvim_create_autocmd("RecordingEnter", {
        group = augroup,
        callback = function()
            lualine.refresh({ place = { "statusline" } })
        end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
        group = augroup,
        callback = function()
            vim.defer_fn(function()
                lualine.refresh({ place = { "statusline" } })
            end, 50)
        end,
    })

    local bg_dark = "#16161e"
    local section_bg = { bg = bg_dark }

    lualine.setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = {
                "mode",
                {
                    function()
                        local reg = vim.fn.reg_recording()
                        return reg ~= "" and ("Recording @" .. reg) or ""
                    end,
                },
            },
            lualine_b = {
                {
                    "filename",
                    path = 1,
                    color = { fg = "#9EADB5", bg = bg_dark },
                },
                {
                    function()
                        return vim.b.lualine_current_func or ""
                    end,
                    icon = { "󰊕", color = {fg = "#4EA6DE", bg = bg_dark }},
                    color = { fg = "#9EADB5", bg = bg_dark },
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    color = section_bg,
                    diagnostics_color = {
                        error = { fg = "#c14242", bg = bg_dark },
                        warn  = { fg = "#e0af68", bg = bg_dark },
                        info  = { fg = "#6b8dd6", bg = bg_dark },
                        hint  = { fg = "#83aa5c", bg = bg_dark },
                    },
                    symbols = {
                        error = icons.diagnostics.Error .. " ",
                        warn  = icons.diagnostics.Warning .. " ",
                        info  = icons.diagnostics.Information .. " ",
                        hint  = icons.diagnostics.Hint .. " ",
                    },
                },
            },
            lualine_x = {
                {
                    "branch",
                    color = section_bg,
                },
                {
                    "diff",
                    color = section_bg,
                    diff_color = {
                        added    = { fg = "#42b545", bg = bg_dark },
                        modified = { fg = "#ABABAB", bg = bg_dark },
                        removed  = { fg = "#c14242", bg = bg_dark },
                    },
                    symbols = {
                        added    = " ",
                        modified = " ",
                        removed  = " ",
                    },
                },
            },
            lualine_y = { "selectioncount" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "nvim-tree", "lazy" },
    })
end

return M
