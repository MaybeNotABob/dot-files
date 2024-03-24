local M = {
  "fedepujol/move.nvim",
  event = { "InsertEnter","BufReadPre", "BufNewFile" },
}
  

function M.config()
require('move').setup({
	line = {
		enable = true, -- Enables line movement
		indent = true  -- Toggles indentation
	},
	block = {
		enable = true, -- Enables block movement
		indent = true  -- Toggles indentation
	},
	word = {
		enable = true, -- Enables word movement
	},
	char = {
		enable = false -- Enables char movement
	}
})
end


return M

--  Alternative line move up/down without plugin
--  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")