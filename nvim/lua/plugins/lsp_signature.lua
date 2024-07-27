local M = {
  "ray-x/lsp_signature.nvim",
  event = { "InsertEnter", "BufReadPre", "BufNewFile" },
}


function M.config()
  require("lsp_signature").setup({
    doc_lines = 0,
    floating_window = true,
    close_timeout = 2000,
    hint_enable = false,
    hint_prefix = "",
    timer_interval = 50,
  })
end


return M
