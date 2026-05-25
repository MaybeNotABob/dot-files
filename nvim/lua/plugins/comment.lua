local M = {
  "nvim-mini/mini.comment",
  event = { "InsertEnter","BufReadPre", "BufNewFile" },
}


function M.config ()
  require('mini.comment').setup()
end


return M