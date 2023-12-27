local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- n    normal mode
-- i    insert mode
-- v    visual and select
-- x    visual block
-- t    term mode
-- c    command-line mode
-- s    select

-- ========================================================================= --
-- General 
-- ========================================================================= --
-- default leader key "\"
vim.g.mapleader = " "

-- no highlight
keymap("n", "nh", "<cmd>noh<cr>", opts)


-- ========================================================================= --
--  Indentation
-- ========================================================================= --

-- indent
keymap("n", "<Tab>", ">>_", opts)
keymap("x", "<Tab>", ">gv_", opts)
keymap("v", "<Tab>", ">gv_", opts)
-- <Tab> should operate as normal in insert mode.
-- <C-T> indents when in insert mode.

-- de-indent
keymap("i", "<S-Tab>", "<C-D>", opts)
keymap("x", "<S-Tab>", "<gv$", opts)
keymap("v", "<S-Tab>", "<gv$", opts)
keymap("n", "<S-Tab>", "<<$", opts)

-- ========================================================================= --
--  Buffers
-- ========================================================================= --
keymap("n", "]b", "<cmd>bnext<cr>", opts)
keymap("n", "[b", "<cmd>bprev<cr>", opts)
keymap("n", "bb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "bd", "<cmd>bdelete<cr>", opts)
keymap("n", "bn", "<cmd>enew<cr>", opts)

-- ========================================================================= --
-- Tabs
-- ========================================================================= --
keymap("n", "]t", "<cmd>tabnext<cr>", opts)
keymap("n", "[t", "<cmd>tabprevious<cr>", opts)
keymap("n", "td", "<cmd>tabclose<cr>", opts)
keymap("n", "tt", "<cmd>tabs<cr>", opts)
keymap("n", "tn", "<cmd>tabnew<cr>", opts)

-- ========================================================================= --
--  Telescope
-- ========================================================================= --
keymap("n", "ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "fr", "<cmd>Telescope registers<cr>", opts)
keymap("n", "<leader>m", "<cmd>Telescope man_pages<cr>", opts)


-- ========================================================================= --
-- Comment (defaults)
-- ========================================================================= --
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

-- ========================================================================= --
-- LSP
-- ========================================================================= --

--
-- LSP DECLARATIONS
--
--keymap("n", "gD", "<cmd>Telescope lsp_declarations<cr>", opts)
--keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", opts)

--
--
--
--keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
--keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
--keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions<CR>", opts)
--keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions({jump_type='never'})<CR>", opts)

--
-- TYPE DEFINITIONS
--
--keymap("n", "gT", "<cmd>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "gT", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)

--
-- REFERENCES
--
-- keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
keymap("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)

--
-- SIGNATURE
--
-- keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

--
-- IMPLEMENTION
--
-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

--
-- SYMBOLS
--
keymap("n", "gI", "<cmd>Telescope lsp_document_symbols<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

--
-- DIAGNOSTICS
--
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- keymap("n", "gL", "<cmd>lua require'telescope.builtin'.diagnostics(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "gL", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

--
-- FORMATTING
-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

-- ========================================================================= --
-- Movement
-- ========================================================================= --
keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)


-- ========================================================================= --
--  nvim-tree
-- ========================================================================= --

--keymap("n", "<leader>f", "<cmd>NvimTreeToggle<cr>", opts)
--keymap("n", "<leader>f", "<cmd>NvimTreeOpenOrFocus<cr>", opts)

--
--  if nvim-tree is closed, open and focus it
--
--  if nvim-tree is opened and focused, close it
--
--  if nvim-tree is open, but another buffer is focused,
--  focus nvim-tree
--

keymap("n", "<leader>f", 
  function ()
    local nvimTree = require("nvim-tree.api")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
     if currentBufFt == "NvimTree" then
	      nvimTree.tree.toggle()
      else
        nvimTree.tree.open()
	      nvimTree.tree.focus()
      end
    end,
  { noremap = true, silent = true, nowait = true }
)
 

-- ========================================================================= --
-- 
-- ========================================================================= --