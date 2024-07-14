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
--		{
--			"hrsh7th/cmp-nvim-lsp-signature-help",
--			event = "InsertEnter",
--		},
		{
			"hrsh7th/cmp-nvim-lua",
			event = "InsertEnter",
		},
		{
			"ray-x/cmp-treesitter",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
	},
}

function M.config()
	local cmp = require("cmp")
	local icons = require("config.icons")
	local luasnip = require("luasnip")

	cmp.setup({

		-- gray
		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" }),
		-- blue
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" }),
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" }),
		-- light blue
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" }),
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" }),
		vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" }),
		-- pink
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" }),
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" }),
		-- front
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" }),
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" }),
		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" }),

		--  disable completion in comments
		enabled = function()
			local context = require("cmp.config.context")
			--  keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,

		-- snippets
		require("luasnip/loaders/from_vscode").lazy_load(),
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},

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
					luasnip = "",
					treesitter = "",
					buffer = "",
					path = "",
				})[entry.source.name]

				--  add treesitter icon lookup
				if entry.source.name == "treesitter" then
					vim_item.kind = icons.kind.Treesitter
				end

				--  trim the completion text to max of
				--  50 chars
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
			{ name = "luasnip" },
--      { name = 'nvim_lsp_signature_help' },
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
