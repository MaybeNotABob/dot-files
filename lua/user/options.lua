-- ========================================================================= --
--  General
-- ========================================================================= --

-- disable compatibility with vi
vim.opt.compatible = false

-- allows neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- disable vim auto formatting clipboard
--vim.opt.paste = true

-- so that `` is visible in markdown files
vim.opt.conceallevel = 0                   

-- allow the mouse to be used in neovim
vim.opt.mouse = "a"                           

-- pop up menu height
vim.opt.pumheight = 10

-- faster completion (4000ms default)
vim.opt.updatetime = 300


-- ========================================================================= --
--  File handling
-- ========================================================================= --

-- enable file type detection by extension
vim.opt.filetype = "on"

-- the encoding written to a file
vim.opt.fileencoding = "utf-8"

-- keep all vim files together for easy housekeeping
local swap_dir = vim.fn.stdpath "config" .. "/lua/user/swap/"

local backup_dir = vim.fn.stdpath "config" .. "/lua/user/backup/"

local undo_dir = vim.fn.stdpath "config" .. "/lua/user/undo/"

-- function to check if a directory exists by attempting
-- to rename it
function path_exists(file_path)
   local result = os.rename(file_path, file_path)
    if (nil == result) then
    	return false
    else 
     	return true
    end
end

-- enable swap files
vim.opt.swapfile = true
vim.opt.directory = swap_dir

if (vim.opt.swapfile == true) then
  if not (path_exists(swap_dir)) then
    vim.loop.fs_mkdir(swap_dir, 493)
  end
end


-- enable backup file
vim.opt.backup = true
vim.opt.backupdir = backup_dir

if (vim.opt.backup == true) then
  if not (path_exists(backup_dir)) then
    vim.loop.fs_mkdir(backup_dir, 493)
  end
end


-- enable persistent undo
vim.opt.undofile = false
vim.opt.undodir = undo_dir

if (vim.opt.undofile == true) then
  if not (path_exists(undo_dir)) then
    vim.loop.fs_mkdir(undo_dir, 493)
  end
end


-- ========================================================================= --
--  Search
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
--  Interface
-- ========================================================================= --

-- completion menu 
vim.opt.completeopt = { "menuone", "noselect" }

-- panel splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- highlight the current line
vim.opt.cursorline = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = false

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

-- tab setup
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.cindent = false
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.filetype.indent = "off"
vim.cmd [[ :filetype indent off	]]

-- enable status bar
vim.opt.laststatus = 2

-- set color scheme
vim.cmd [[
try
  colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
