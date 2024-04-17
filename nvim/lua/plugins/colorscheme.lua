local M = {
  -- colorscheme repo
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}


function M.config ()
  -- load the colorscheme here
  vim.cmd.colorscheme "tokyonight-night"

end


return M
