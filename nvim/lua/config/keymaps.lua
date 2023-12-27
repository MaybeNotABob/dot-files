local opts = { noremap = true, silent = true, nowait = true }
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
keymap("n", "nh", "<CMD>noh<CR>", opts)


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
keymap("n", "]b", "<CMD>bnext<CR>", opts)
keymap("n", "[b", "<CMD>bprev<CR>", opts)
keymap("n", "bb", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "bd", "<CMD>bdelete<CR>", opts)
keymap("n", "bn", "<CMD>enew<CR>", opts)

-- ========================================================================= --
-- Tabs
-- ========================================================================= --
keymap("n", "]t", "<CMD>tabnext<CR>", opts)
keymap("n", "[t", "<CMD>tabprevious<CR>", opts)
keymap("n", "td", "<CMD>tabclose<CR>", opts)
keymap("n", "tt", "<CMD>tabs<CR>", opts)
keymap("n", "tn", "<CMD>tabnew<CR>", opts)

-- ========================================================================= --
--  Telescope
-- ========================================================================= --
keymap("n", "ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "fg", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "fb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "fh", "<CMD>Telescope help_tags<CR>", opts)
keymap("n", "fr", "<CMD>Telescope registers<CR>", opts)
keymap("n", "<leader>m", "<CMD>Telescope man_pages<CR>", opts)


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
--keymap("n", "gD", "<CMD>Telescope lsp_declarations<CR>", opts)
--keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gD", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>", opts)

--
-- LSP DEFINITIONS
--
--keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>", opts)
--keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
--keymap("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions<CR>", opts)
--keymap("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions({jump_type='never'})<CR>", opts)

--  quick peek, one line popup of definition
keymap("n", "<leader>d", 
 function ()
  function preview_location_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
      return nil
    end
    vim.lsp.util.preview_location(result[1])
  end

    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end,
  opts
)
 

--
-- TYPE DEFINITIONS
--
--keymap("n", "gT", "<CMD>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "gT", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)

--
-- REFERENCES
--
-- keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
keymap("n", "gr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>", opts)

--
-- SIGNATURE
--
-- keymap("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)

--
-- IMPLEMENTION
--
-- keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)

--
-- SYMBOLS
--
keymap("n", "gI", "<CMD>Telescope lsp_document_symbols<CR>", opts)
keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)

--
-- DIAGNOSTICS
--
keymap("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
-- keymap("n", "gL", "<CMD>lua require'telescope.builtin'.diagnostics(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "gL", "<CMD>Telescope diagnostics<CR>", opts)
keymap("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", opts)
-- keymap("n", "<leader>q", "<CMD>lua vim.diagnostic.setloclist()<CR>", opts)

--
-- FORMATTING
--

-- https://vi.stackexchange.com/a/41430
--function FormatFunction()
--  vim.lsp.buf.format({
--    async = true,
--    range = {
--      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
--      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
--    }
--  })
--end


--keymap("x", "gF", "<Esc><cmd>lua FormatFunction()<CR>", opts)
--keymap("v", "gF", "<Esc><cmd>lua FormatFunction()<CR>", opts)

--keymap("v", "gF", "<ESC><CMD>lua vim.lsp.buf.range_formatting()<CR>", opts)


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

--keymap("n", "<leader>f", "<CMD>NvimTreeToggle<CR>", opts)
--keymap("n", "<leader>f", "<CMD>NvimTreeOpenOrFocus<CR>", opts)


keymap("n", "<leader>f", 
  function ()
--
--  if nvim-tree is closed, open and focus it
--
--  if nvim-tree is opened and focused, close it
--
--  if nvim-tree is open, but another buffer is focused,
--  focus nvim-tree
--
    local nvimTree = require("nvim-tree.api")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
     if currentBufFt == "NvimTree" then
	      nvimTree.tree.toggle()
      else
	      nvimTree.tree.focus()
      end
    end,
  opts
)
 

-- ========================================================================= --
-- 
-- ========================================================================= --
