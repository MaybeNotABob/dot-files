local M = {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  }
}

function M.config ()
  require("Comment").setup({
    require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
  })
end

return M