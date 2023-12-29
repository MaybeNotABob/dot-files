local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  
  config = function ()

    local plugin_indent_blankline = require("ibl")

    plugin_indent_blankline.setup {
      scope = { 
        enabled = false
      }
    }

  end
}


return M


  --
  --  local hooks = require("ibl.hooks")
  --  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --    vim.api.nvim_set_hl(0, "Gray1", { fg = "#a7a7a7" })
  --    vim.api.nvim_set_hl(0, "Gray2", { fg = "#ababab" })
  --    vim.api.nvim_set_hl(0, "Gray3", { fg = "#828282" })
  --    vim.api.nvim_set_hl(0, "Gray4", { fg = "#595959" })
  --    vim.api.nvim_set_hl(0, "Gray5", { fg = "#303030" })
  --    vim.api.nvim_set_hl(0, "Gray6", { fg = "#080808" })
  --  end)
