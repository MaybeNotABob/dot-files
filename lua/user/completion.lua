local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local check_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
--  window = {
--   completion = cmp.config.window.bordered(),
--   documentation = cmp.config.window.bordered(), 
--  },
  mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert, select = true
        }),
        ["<Tab>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert, select = true
        }),

        -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

        -- ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

  }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
            -- order of appearance in pop-up menu
            nvim_lsp = "",
            luasnip = "",
            rg = "",
            treesitter = "",
            buffer = "",
            path = "",
        }) [entry.source.name]
            return vim_item
        end,
  },
  sources = cmp.config.sources ({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "rg" },
    { name = "treesitter"},
    { name = "buffer" },
    { name = "path" },
  }),
}
