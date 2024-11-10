local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"ray-x/cmp-treesitter",
		},
}

function M.config()
	local cmp = require("cmp")
	local icons = require("config.icons")

	cmp.setup({

    -- disable auto-complete in certain contexts:
		enabled = function()
			local context = require("cmp.config.context")

      -- stop auto-complete in telescope prompt
      local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
      if buftype == 'prompt' then
        return false
      end

      -- disable auto-complete for comments
      local context = require('cmp.config.context')
      if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
        return false
      end

      -- enable auto-complete otherwise
      return true
		end,

		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				--  behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			}),
			["<Tab>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		}),

		formatting = {
			--  fields = { "kind", "abbr", "menu" },

			--  mimic VSCode popup menu
			fields = { "kind", "abbr" },
			format = function(entry, vim_item)
				--  icons loaded here
				vim_item.kind = icons.kind[vim_item.kind]

				--  order of appearance in pop-up menu
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					treesitter = "",
					buffer = "",
					path = "",
				})[entry.source.name]

				--  add treesitter icon lookup
				if entry.source.name == "treesitter" then
					vim_item.kind = icons.kind.Treesitter
				end

				--  trim the completion text to max of 50 chars
				--
				--  Yuki Uthman
				--  youtube.com/watch?v=uDPZ2yJS6os

				local function trim(text)
					local max_len = 50
					if text and text:len() > max_len then
						text = text:sub(1, max_len) .. " ..."
					end
					return text
				end
				vim_item.abbr = trim(vim_item.abbr)

				return vim_item
			end,
		},

		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "treesitter", keyword_length = 3 },
			{ name = "buffer", keyword_length = 3 },
			{ name = "path", keyword_length = 3 },
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
			document = function()
				local win_width = vim.fn.winwidth(0)
				if win_width > 80 then
					return {
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
					}
				else
					return {}
				end
			end,
		},

		experimental = {
			ghost_text = false,
		},
	})
end

return M
