local M = {
  "folke/trouble.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { 
    "nvim-tree/nvim-web-devicons" 
  },
  cmd = {
    "Trouble",
  },
}


function M.config()
  local trouble = require("trouble").setup({
    focus = true,
    auto_close = true
  })
end


return M