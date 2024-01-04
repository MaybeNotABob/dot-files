local M = {
  "folke/trouble.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { 
    "nvim-tree/nvim-web-devicons" 
  },
}


function M.config()
-- No setup to be called
end


return M