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
-- GENERAL
-- ========================================================================= --

-- default leader key "\"
keymap("n", " ", "<nop>", opts)
vim.g.mapleader = " "

-- no highlight
keymap("n", "nh", "<CMD>noh<CR>", opts)
-- unmap command history
keymap("n", "q:", "<nop>", opts)


-- ========================================================================= --
--  COPY / PASTE SYSTEM CLIPBOARD 
-- ========================================================================= --

keymap("n", '"+y', "<leader>y", opts)
keymap("n", '"+Y', "<leader>Y", opts)
keymap("n", '"+p', "<leader>p", opts)
keymap("n", '"+P', "<leader>P", opts)


-- ========================================================================= --
--  INDENTATION
-- ========================================================================= --

-- INDENT
-- ------------------------------------------------------------------------- -- 

keymap("n", "<Tab>", ">>_", opts)
keymap("x", "<Tab>", ">gv_", opts)
keymap("v", "<Tab>", ">gv_", opts)
-- <Tab> should operate as normal in insert mode.
-- <C-T> indents when in insert mode.


-- DE-INDENT
-- ------------------------------------------------------------------------- -- 

keymap("i", "<S-Tab>", "<C-D>", opts)
keymap("x", "<S-Tab>", "<gv$", opts)
keymap("v", "<S-Tab>", "<gv$", opts)
keymap("n", "<S-Tab>", "<<$", opts)


-- ========================================================================= --
--  BUFFERS
-- ========================================================================= --

keymap("n", "]b", "<CMD>bnext<CR>", opts)
keymap("n", "[b", "<CMD>bprev<CR>", opts)
keymap("n", "<leader>b", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "bd", "<CMD>bdelete<CR>", opts)
keymap("n", "bn", "<CMD>enew<CR>", opts)
-- ========================================================================= --
-- TABS
-- ========================================================================= --

keymap("n", "]t", "<CMD>tabnext<CR>", opts)
keymap("n", "[t", "<CMD>tabprevious<CR>", opts)
keymap("n", "td", "<CMD>tabclose<CR>", opts)
keymap("n", "<leader>t", "<CMD>tabs<CR>", opts)
keymap("n", "tn", "<CMD>tabnew<CR>", opts)

-- ========================================================================= --
--  TELESCOPE
-- ========================================================================= --

keymap("n", "ff", "<CMD>Telescope find_files initial_mode=insert theme=ivy<CR>", opts)
keymap("n", "fg", "<CMD>Telescope live_grep  initial_mode=insert theme=ivy<CR>", opts)
keymap("n", "fb", "<CMD>Telescope current_buffer_fuzzy_find initial_mode=insert theme=ivy<CR>", opts)
keymap("n", "fh", "<CMD>Telescope help_tags initial_mode=insert theme=ivy<CR>", opts)
keymap("n", "fr", "<CMD>Telescope registers initial_mode=insert theme=ivy<CR>", opts)
keymap("n", "<leader>m", "<CMD>Telescope man_pages theme-ivy<CR>", opts)


-- ========================================================================= --
-- COMMENT (defaults)
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

-- LSP DECLARATIONS
-- ------------------------------------------------------------------------- --

--keymap("n", "gD", "<CMD>Telescope lsp_declarations<CR>", opts)
--keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gF", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gD", "<CMD>lua require('goto-preview').goto_preview_declaration()<CR>", opts)


-- LSP DEFINITIONS
-- ------------------------------------------------------------------------- --

keymap("n", "gf", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gd", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>", opts)
--keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
--keymap("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions<CR>", opts)
--keymap("n", "gd", "<CMD>lua require('telescope.builtin').lsp_definitions({jump_type='never'})<CR>", opts)

--  quick peek, one line popup of definition
keymap("n", "<leader>d", function()
	function preview_location_callback(_, result)
		if result == nil or vim.tbl_isempty(result) then
			return nil
		end
		vim.lsp.util.preview_location(result[1])
	end

	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end, opts)


-- TYPE DEFINITIONS
-- ------------------------------------------------------------------------- --

--keymap("n", "gT", "<CMD>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "gT", "<CMD>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)


-- REFERENCES
-- ------------------------------------------------------------------------- --

-- keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
keymap("n", "gr", "<CMD>lua require('goto-preview').goto_preview_references()<CR>", opts)


-- SIGNATURE
-- ------------------------------------------------------------------------- --

keymap("n", "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)


-- IMPLEMENTION
-- ------------------------------------------------------------------------- --

-- keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)


-- SYMBOLS
-- ------------------------------------------------------------------------- --

keymap("n", "gI", "<CMD>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
-- keymap("n", "gI", "<CMD>lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({}))<CR>", opts)
-- keymap("n", "gI", "<CMD>Telescope lsp_document_symbols ignore_symbols=variable<CR>", opts)

keymap("n", "<leader>gI", "<CMD>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>", opts)
-- keymap("n", "<leader>gI", "<CMD>lua require'telescope.builtin'.lsp_workspace_symbols(require('telescope.themes').get_dropdown({}))<CR>", opts)
-- keymap("n", "<leader>gI", "<CMD>Telescope lsp_workspace_symbols ignore_symbols=variable<CR>", opts)

keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)


-- DIAGNOSTICS
-- ------------------------------------------------------------------------- --

keymap("n", "[d", "<CMD>lua vim.diagnostic.jump({count=-1, float=true})<CR>", opts)
keymap("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
-- keymap("n", "gL", "<CMD>lua require'telescope.builtin'.diagnostics(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "gL", "<CMD>Telescope diagnostics<CR>", opts)
keymap("n", "]d", "<CMD>lua vim.diagnostic.jump({count=1, float=true})<CR>", opts)
-- keymap("n", "<leader>q", "<CMD>lua vim.diagnostic.setloclist()<CR>", opts)


-- FORMATTING
-- ------------------------------------------------------------------------- --

keymap("n", "gq", vim.lsp.buf.format, opts)
keymap("v", "gq", vim.lsp.buf.format, opts)


-- ========================================================================= --
--  MOVEMENT
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
--  NVIM-TREE
-- ========================================================================= --

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
--  TROUBLE.NVIM
-- ========================================================================= --

-- keymap("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>",  opts)
keymap("n", "<leader>xx",
  function ()
    local trouble = require("trouble")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
    local opt = {
      focus = true,
      mode = "diagnostics",
      filter = {
        buf = currentBuf,
      }
    }

    if currentBufFt == "trouble" then
      trouble.toggle(opt)
    else
      trouble.open(opt)
    end

  end,

  opts
)


keymap("n", "<leader>xX", "<CMD>Trouble diagnostics toggle<CR>",  opts)
keymap("n", "<leader>cs", "<CMD>Trouble symbols toggle focus=false<CR>",  opts)
keymap("n", "<leader>cl", "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",  opts)
keymap("n", "<leader>xL", "<CMD>Trouble loclist toggle<CR>",  opts)
keymap("n", "<leader>xQ", "<CMD>Trouble qflist toggle<CR>",  opts)


-- ========================================================================= --
-- 
-- ========================================================================= --
