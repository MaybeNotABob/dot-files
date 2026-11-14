-- n    normal mode
-- i    insert mode
-- v    visual and select
-- x    visual block
-- t    term mode
-- c    command-line mode
-- s    select

local M = {}

local keymap = vim.keymap.set
local opts = {
    noremap = true,
    silent = true,
--    nowait = true,
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.tmux_navigator_no_mappings = 1

local function telescope_live_grep()
    if vim.fn.executable("rg") ~= 1 and vim.fn.executable("grep") ~= 1 then
        vim.notify(
            "Telescope live_grep requires ripgrep (rg) or grep. Install ripgrep for the best experience.",
            vim.log.levels.ERROR,
            { title = "Telescope dependency missing" }
        )
        return
    end

    vim.cmd("Telescope live_grep")
end

local function map(mode, lhs, rhs, desc, extra)
    local map_opts = vim.tbl_extend("force", opts, {
        desc = desc,
    }, extra or {})

    keymap(mode, lhs, rhs, map_opts)
end

-- ========================================================================= --
-- GENERAL
-- ========================================================================= --

map("n", "<Space>", "<Nop>", "Disable the space key's default action")
map("n", "<leader>nh", "<CMD>nohlsearch<CR>", "Clear search highlighting")
map("n", "<leader>?", function()
    require("which-key").show({ global = true })
end, "Show all keymaps")
map("n", "q:", "<Nop>", "Disable command-line window")

-- ========================================================================= --
-- CLIPBOARD
-- ========================================================================= --

map({ "n", "x" }, "<leader>y", '"+y', "Yank to system clipboard")
map("n", "<leader>Y", '"+Y', "Yank line to system clipboard")
map({ "n", "x" }, "<leader>p", '"+p', "Paste from system clipboard")
map("n", "<leader>P", '"+P', "Paste before cursor from system clipboard")

-- ========================================================================= --
-- INDENTATION
-- ========================================================================= --

map("n", "<Tab>", ">>", "Indent current line")
map("x", "<Tab>", ">gv_", "Indent selection")
map("v", "<Tab>", ">gv_", "Indent selection")
-- <Tab> should operate as normal in insert mode.
-- <C-T> indents when in insert mode.
-- overwrites Ctrl + I (Tab) (forward in jump list)

map("i", "<S-Tab>", "<C-D>", "De-indent current line")
map("x", "<S-Tab>", "<gv$", "De-indent selection")
map("v", "<S-Tab>", "<gv$", "De-indent selection")
map("n", "<S-Tab>", "<<$",  "De-indent current line")


-- ========================================================================= --
-- BUFFERS
-- ========================================================================= --

map("n", "]b", "<CMD>bnext<CR>", "Go to next buffer")
map("n", "[b", "<CMD>bprevious<CR>", "Go to previous buffer")
map("n", "<leader>bb", "<CMD>Telescope buffers<CR>", "Find open buffers")
map("n", "<leader>bd", "<CMD>bdelete<CR>", "Delete current buffer")
map("n", "<leader>bn", "<CMD>enew<CR>", "Create new buffer")

-- ========================================================================= --
-- TABS
-- ========================================================================= --

map("n", "]t", "<CMD>tabnext<CR>", "Go to next tab")
map("n", "[t", "<CMD>tabprevious<CR>", "Go to previous tab")
map("n", "<leader>td", "<CMD>tabclose<CR>", "Close current tab")
map("n", "<leader>tt", "<CMD>tabs<CR>", "List tabs")
map("n", "<leader>tn", "<CMD>tabnew<CR>", "Create new tab")

-- ========================================================================= --
-- WINDOW MANAGEMENT
-- ========================================================================= --

map("n", "<leader>sv", "<CMD>vsplit<CR>", "Split window vertically")
map("n", "<leader>sh", "<CMD>split<CR>", "Split window horizontally")
map("n", "<leader>se", "<CMD>wincmd =<CR>", "Equalise window sizes")
map("n", "<leader>sx", "<CMD>close<CR>", "Close current window")
map("n", "<leader>so", "<CMD>only<CR>", "Close all other windows")
map("n", "<C-k>", "<CMD>resize +2<CR>", "Increase window height")
map("n", "<C-j>", "<CMD>resize -2<CR>", "Decrease window height")
map("n", "<C-h>", "<CMD>vertical resize -2<CR>", "Decrease window width")
map("n", "<C-l>", "<CMD>vertical resize +2<CR>", "Increase window width")

-- Use vim-tmux-navigator commands so these mappings work across Neovim
-- splits and tmux panes. The plugin's default mappings are disabled so that
-- descriptions and ownership remain centralised in this file.
map("n", "<C-Left>", "<CMD>TmuxNavigateLeft<CR>", "Move to the left window or tmux pane")
map("n", "<C-Down>", "<CMD>TmuxNavigateDown<CR>", "Move to the lower window or tmux pane")
map("n", "<C-Up>", "<CMD>TmuxNavigateUp<CR>", "Move to the upper window or tmux pane")
map("n", "<C-Right>", "<CMD>TmuxNavigateRight<CR>", "Move to the right window or tmux pane")

-- ========================================================================= --
-- MOVEMENT
-- ========================================================================= --

map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("x", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("x", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- ========================================================================= --
-- JUMP LIST
-- ========================================================================= --

map("n", "<leader>jj", "<CMD>jumps<CR>", "Show jump list")
map("n", "]j", "<C-i>", "Jump forward")
map("n", "[j", "<C-o>", "Jump backward")

-- ========================================================================= --
-- TELESCOPE
-- ========================================================================= --

map("n", "ff", "<CMD>Telescope find_files<CR>", "Find file")
map("n", "fg", telescope_live_grep, "Search project text")
map("n", "fb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Search current buffer")
map("n", "fh", "<CMD>Telescope help_tags<CR>", "Search help tags")
map("n", "fr", "<CMD>Telescope registers<CR>", "Search registers")

map("n", "<leader>gq", function()
    require("conform").format({ async = true, lsp_format = "never" })
end, "Format current buffer")

map("v", "<leader>gq", function()
    require("conform").format({ async = true, lsp_format = "never" })
end, "Format current buffer")

-- ========================================================================= --
-- LSP
-- ========================================================================= --

-- LSP mappings are installed only for buffers with an attached LSP client.
-- Keep their definitions here so all user keymaps remain centrally managed.
function M.on_lsp_attach(args)
    local bufnr = args.buf
    local map_opts = {
        buffer = bufnr,
        noremap = true,
        silent = true,
    }

    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration", map_opts)
    map("n", "gd", vim.lsp.buf.definition, "Go to definition", map_opts)
    map("n", "gT", "<CMD>Telescope lsp_type_definitions<CR>", "Find type definitions", map_opts)
    map("n", "gr", "<CMD>Telescope lsp_references<CR>", "Find references", map_opts)
    map("n", "gs", vim.lsp.buf.signature_help, "Show signature help", map_opts)
    map("n", "gi", "<CMD>Telescope lsp_implementations<CR>", "Find implementations", map_opts)
    map("n", "gI", "<CMD>Telescope lsp_document_symbols symbols=function,method<CR>", "Find document symbols", map_opts)
    map("n", "<leader>gI", "<CMD>Telescope lsp_workspace_symbols symbols=function,method<CR>", "Find workspace symbols", map_opts)
    map("n", "K", vim.lsp.buf.hover, "Show symbol documentation", map_opts)

    map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, "Go to previous diagnostic", map_opts)

    map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, "Go to next diagnostic", map_opts)

    map("n", "gl", vim.diagnostic.open_float, "Show line diagnostics", map_opts)
    map("n", "gL", "<CMD>Telescope diagnostics<CR>", "Find diagnostics", map_opts)
    map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol", map_opts)
    map("n", "<leader>la", vim.lsp.buf.code_action, "Code action", map_opts)
end

-- ========================================================================= --
-- NVIM-TREE
-- ========================================================================= --

map("n", "<leader>f", function()
    local ok, tree_api = pcall(require, "nvim-tree.api")
    if not ok then
        vim.notify("nvim-tree is not available", vim.log.levels.ERROR)
        return
    end

    local current_filetype = vim.bo.filetype
    if current_filetype == "NvimTree" then
        tree_api.tree.close()
    else
        tree_api.tree.open()
        tree_api.tree.focus()
    end
end, "Toggle and focus file explorer")


return M
