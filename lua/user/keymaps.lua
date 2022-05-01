local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- n    normal mode
-- i    insert mode
-- v    visual
-- x    visual block
-- t    term mode
-- c    command mode

-- ========================================================================= --
-- General 
-- ========================================================================= --

-- no highlight
keymap("n", "nh", "<cmd>noh<cr>", opts)

-- indent
keymap("i", "<Tab>", "<C-T>", opts)
-- de-indent
keymap("i", "<S-Tab>", "<C-D>", opts)

-- ========================================================================= --
--  Telescope
-- ========================================================================= --
keymap("n", "ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "fh", "<cmd>Telescope help_tags<cr>", opts)

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
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap("n", "gl",'<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

-- ========================================================================= --
   
-- ========================================================================= --
