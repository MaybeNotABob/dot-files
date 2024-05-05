local M = {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	--event = { "InsertEnter","BufReadPre", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local icons = require("config.icons")

	-- override and hide the command line bar
	vim.opt.cmdheight = 0

	require("lualine").setup({
		options = {
			icons_enabled = true,

			-- use already applied theme
			--theme = 'auto',

			component_separators = {
				left = "|",
				right = "|",
			},

			section_separators = {
				left = "",
				right = "",
			},

			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {
				"NvimTree",
			},

			always_divide_middle  = true,
			globalstatus          = false,
			refresh = {
				statusline  = 1000,
				tabline     = 1000,
				winbar      = 1000,
			},
		},


		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"branch",
					colored = true,
					color = {
						bg = "#16161e",
					},
				},
				{
					"diff",
					colored = true,
					color = {
						bg = "#16161e",
					},
					diff_color = {
						added = {
							fg = "#42b545", --'LuaLineDiffAdd',
							bg = "#16161e",
						},
						modified = {
							fg = "#ABABAB", --'LuaLineDiffChange',
							bg = "#16161e",
						},
						removed = {
							fg = "#c14242", --'LuaLineDiffDelete',
							bg = "#16161e",
						},
					},
					symbols = {
						added     = " ",
						modified  = " ",
						removed   = " ",
					},
				},
			},

			lualine_c = {
				{
					"diagnostics",
					colored = true,
					color = {
						bg = "#16161e",
					},

					diagnostics_color = {
						error = {
							fg = "#c14242",
							bg = "#16161e",
						},
						warn = {
							fg = "#e0af68",
							bg = "#16161e",
						},
						info = {
							fg = "#6b8dd6",
							bg = "#16161e",
						},
						hint = {
							fg = "#83aa5c",
							bg = "#16161e",
						},
					},

					symbols = {
						error = icons.diagnostics["Error"] .. " ",
						warn  = icons.diagnostics["Warning"] .. " ",
						info  = icons.diagnostics["Information"] .. " ",
						hint  = icons.diagnostics["Hint"] .. " ",
					},
				},
			},

			lualine_x = { "filename", "encoding", "fileformat", "filetype" },
			lualine_y = { "selectioncount" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

return M
