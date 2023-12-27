local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
}
  

function M.config()
  require("nvim-tree").setup({})
end

return M