local M = {
  "fedepujol/move.nvim",
  event = { "BufReadPre", "BufNewFile" },
}
  

function M.config()
-- No setup to be called
end


return M

--  Alternative line move up/down without plugin
--  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")