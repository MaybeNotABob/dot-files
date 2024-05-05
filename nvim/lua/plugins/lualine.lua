local M = {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  --event = { "InsertEnter","BufReadPre", "BufNewFile" },
  dependencies = { 'nvim-tree/nvim-web-devicons'},
}

function M.config ()

local icons = require("config.icons")

-- override and hide the command line bar
vim.opt.cmdheight = 0


require('lualine').setup {
  options = {
    icons_enabled = true,

    -- use already applied theme
    theme = 'auto',

    symbols = {
                  error = ' ' .. icons.diagnostics['Error'] .. ' ',
                  warn  = ' ' .. icons.diagnostics['Warning'] .. ' ',
                  info  = ' ' .. icons.diagnostics['Information'] .. ' ', 
                  hint  = ' ' .. icons.diagnostics['Hint'] .. ' ',
    },
    component_separators = { 
                  left = '|',
                  right = '|'
    },

    section_separators = {
                left = '',
                right = ''
    },

    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {
        "NvimTree"
    },

    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'selectioncount'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

end



return M
