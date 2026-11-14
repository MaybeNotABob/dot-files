-- ========================================================================= --
-- GENERAL
-- ========================================================================= --

-- disable compatibility with vi
vim.opt.compatible = false

-- allows neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- disable vim auto formatting clipboard
--vim.opt.paste = true

-- so that `` is visible in markdown files
-- vim.opt.conceallevel = 0

-- allow the mouse to be used in neovim
vim.opt.mouse = "a"

-- pop up menu height
vim.opt.pumheight = 10

-- faster completion (4000ms default)
vim.opt.updatetime = 300

-- ========================================================================= --
-- FILE HANDLING
-- ========================================================================= --

-- enable file type detection by extension
vim.opt.filetype = "on"

-- the encoding written to a file
vim.opt.fileencoding = "utf-8"

local state_dir = vim.fn.stdpath("config")
local directories = {
    swap = state_dir .. "/lua/state/swap/",
    backup = state_dir .. "/lua/state/backup/",
    undo = state_dir .. "/lua/state/undo/",
}

for _, path in pairs(directories) do
    local stat = vim.uv.fs_stat(path)

    if stat and stat.type ~= "directory" then
        error("Neovim state path exists but is not a directory: " .. path)
    end

    if not stat then
        vim.fn.mkdir(path, "p", 448)
        local created_stat = vim.uv.fs_stat(path)

        if not created_stat or created_stat.type ~= "directory" then
            error("Unable to create Neovim state directory: " .. path)
        end
    end
end

vim.opt.swapfile = true
vim.opt.directory = directories.swap .. "//"
vim.opt.backup = true
vim.opt.backupdir = directories.backup .. "//"
vim.opt.undofile = true
vim.opt.undodir = directories.undo .. "//"

-- ========================================================================= --
-- SEARCH
-- ========================================================================= --

-- highlight all matches on previous search pattern
vim.opt.hlsearch = true

-- ignore case in search patterns
vim.opt.ignorecase = true

-- make search incremental
vim.opt.incsearch = true

-- enable smart case
vim.opt.smartcase = true

-- ========================================================================= --
-- INTERFACE
-- ========================================================================= --

-- completion menu
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
--vim.opt.autocomplete = true

-- panel splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- highlight the current line
vim.opt.cursorline = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- always show the side coloumn
vim.opt.signcolumn = "yes"

-- set true terminal colors
vim.opt.termguicolors = true

-- draw column length markers
vim.opt.colorcolumn = "80,100"

-- enable syntax highlighting
vim.opt.syntax = "on"

-- disable word wrap
vim.opt.wrap = false

-- scroll passed the bottom of the buffer
vim.scrolloff = 10

-- enable status bar
vim.opt.laststatus = 2

-- ========================================================================= --
-- INDENTATION
-- ========================================================================= --

-- tab setup
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.cindent = false
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.filetype.indent = "on"
-- vim.cmd [[ :filetype indent on	]]

-- ========================================================================= --
-- FOLDING
-- ========================================================================= --

-- code folding
-- zR (open all folds)
-- zM (close all open folds)
-- za (toggle fold at cursor)
-- https://neovim.io/doc/user/fold.html

vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
    eob = " ",
}

vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
