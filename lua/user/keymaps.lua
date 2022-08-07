local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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

-- no highlight
keymap("n", "nh", "<cmd>noh<cr>", opts)
keymap("n", "<C-e>", "<cmd>NvimTreeToggle<cr>", opts)

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

-- ========================================================================= --
-- Tabs
-- ========================================================================= --
keymap("n", "]t", "<cmd>tabnext<cr>", opts)
keymap("n", "[t", "<cmd>tabprevious<cr>", opts)
keymap("n", "td", "<cmd>tabclose<cr>", opts)
keymap("n", "tt", "<cmd>tabs<cr>", opts)

-- ========================================================================= --
--  Telescope
-- ========================================================================= --
keymap("n", "ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "fr", "<cmd>Telescope registers<cr>", opts)

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

-- Telescope lsp_declarations throws an error
-- command not found, therefore, falling back vim version.
--keymap("n", "gD", "<cmd>Telescope lsp_declarations<cr>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

--keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

-- keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

-- keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

keymap("n", "gI", "<cmd>Telescope lsp_document_symbols<CR>", opts)

--keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap("n", "gl",'<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap("n", "gL",'<cmd>Telescope diagnostics<CR>', opts)
keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

-- ========================================================================= --
   
-- ========================================================================= --
