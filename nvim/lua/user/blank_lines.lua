local status_ok, blankline = pcall(require, "ibl")
if not status_ok then
  return
end

vim.opt.termguicolors = true

blankline.setup {
    scope = {
        enabled=false
    }
}

-- turn on white space markings
--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"

-- local highlight_colors = {
--    "Gray1",
--    "Gray2",
--    "Gray3",
--    "Gray4",
--    "Gray5",
--    "Gray6",
-- }


-- local hooks = require "ibl.hooks"
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--    vim.api.nvim_set_hl(0, "Gray1", { fg = "#a7a7a7" })
--    vim.api.nvim_set_hl(0, "Gray2", { fg = "#ababab" })
--    vim.api.nvim_set_hl(0, "Gray3", { fg = "#828282" })
--    vim.api.nvim_set_hl(0, "Gray4", { fg = "#595959" })
--    vim.api.nvim_set_hl(0, "Gray5", { fg = "#303030" })
--    vim.api.nvim_set_hl(0, "Gray6", { fg = "#080808" })
-- end)

-- blankline.setup {
--    indent = { highlight = highlight_colors }
-- }
