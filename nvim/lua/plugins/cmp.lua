local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-cmdline",
     event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-nvim-lua",
     event = "InsertEnter",
    },
    {
      "ray-x/cmp-treesitter",
      event = "InsertEnter",
    },
  },
}

function M.on_attach()

end

function M.config()
  local cmp = require "cmp"
  local icons = require("config.icons")
  cmp.setup ({
--    snippet = {
--      expand = function(args)
--        luasnip.lsp_expand(args.body) 
--      end,
--    },
--    completion = {
--      completeopt = "menu,menuone,preview,noselect",
--    },

     -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' }),
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' }),
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' }),
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' }),
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' }),
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' }),
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' }),
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' }),
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' }),
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' }),
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' }),

    mapping = cmp.mapping.preset.insert {
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm { 
        behavior = cmp.ConfirmBehavior.Replace,
         --  behavior = cmp.ConfirmBehavior.Insert,
        select = false 
      },
      ["<Tab>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      },
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    },


    formatting = {
      -- fields = { "kind", "abbr", "menu" },

      -- mimic VSCode popup menu
      fields = { "kind", "abbr" },
      format = function(entry, vim_item)
        -- icons loaded here
        vim_item.kind = icons.kind[vim_item.kind]
        -- order of appearance in pop-up menu
        vim_item.menu = ({
          nvim_lsp = "",
          treesitter = "",
          buffer = "",
          path = "",
        })[entry.source.name]

        -- add treesitter icon lookup
        if entry.source.name == "treesitter" then
          vim_item.kind = icons.kind.Treesitter
        end

        return vim_item
      end,
    },

    sources = {
      { name = "nvim_lsp" },
      { name = "treesitter" },
      { name = "buffer" },
      { name = "path" },
    },

    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },

    window = {
      completion = {
        border = "rounded",
        winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
        col_offset = -3,
        side_padding = 1,
        scrollbar = false,
        scrolloff = 8,

      },

      --  hide the documentation if the WINDOW width is less than 80.
      --  NOTE: this is WINDOW width not TERMINAL width
      document = function ()
         local win_width = vim.fn.winwidth(0)
          if win_width > 80 then
            return {
              border = "rounded",
              winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            }
          else
              return {}
          end      
      end

    },
    experimental = {
      ghost_text = false,
    },
  })



end

return M
