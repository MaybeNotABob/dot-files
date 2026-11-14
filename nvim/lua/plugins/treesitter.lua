local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
}

local parsers = {
    "c",
    "cpp",
    "lua",
    "python",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
}

function M.config()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        vim.notify("nvim-treesitter could not be loaded", vim.log.levels.ERROR)
        return
    end

    treesitter.setup({})

    if vim.fn.executable("tree-sitter") ~= 1 then
        vim.notify(
            "tree-sitter-cli is not installed. Install it to download Tree-sitter parsers.",
            vim.log.levels.WARN,
            { title = "Tree-sitter dependency missing" }
        )
    end

    local install_ok, install_error = pcall(treesitter.install, parsers)
    if not install_ok then
        vim.notify(
            "Unable to start Tree-sitter parser installation: " .. tostring(install_error),
            vim.log.levels.WARN
        )
    end

    local started = {}
    local function start_parser(bufnr)
        if started[bufnr] or not vim.api.nvim_buf_is_valid(bufnr) then
            return
        end

        local parser_ok = pcall(vim.treesitter.start, bufnr)
        if parser_ok then
            started[bufnr] = true

            if vim.api.nvim_get_current_buf() == bufnr then
                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
        end
    end

    local group = vim.api.nvim_create_augroup("user-treesitter", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        group = group,
        callback = function(args)
            start_parser(args.buf)
        end,
    })

    vim.api.nvim_create_autocmd("BufWipeout", {
        group = group,
        callback = function(args)
            started[args.buf] = nil
        end,
    })
end

return M
