local M = {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	--event = { "InsertEnter","BufReadPre", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local icons = require("config.icons")
  local lualine = require("lualine")


  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
  end

  vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
      lualine.refresh({
        place = { "statusline" },
      })
    end,
  })

  vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
    local timer = vim.loop.new_timer()
      timer:start(
        50,
        0,
        function()
          timer:stop()
          timer:close()
          vim.schedule_wrap(function()
              lualine.refresh({
                  place = { "statusline" },
              })
          end)
        end
      )
    end,
  })

	-- override and hide the command line bar
	vim.opt.cmdheight = 0

	lualine.setup({
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

			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},

		sections = {
			lualine_a = { "mode",
                    {
                      "macro-recording",
                      fmt = show_macro_recording,
                    }
      },
			lualine_b = {
				{
					"filename",
					colored = true,
					color = {
						bg = "#16161e",
					},
				},
				-- {
				-- 	"filetype",
				-- 	colored = true,
				-- 	color = {
				-- 		bg = "#16161e",
				-- 	},
				-- },
				-- {
				-- 	"encoding",
				-- 	colored = true,
				-- 	color = {
				-- 		bg = "#16161e",
				-- 	},
				-- },
				-- {
				-- 	"fileformat",
				-- 	colored = true,
				-- 	color = {
				-- 		bg = "#16161e",
				-- 	},
				-- },
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
						warn = icons.diagnostics["Warning"] .. " ",
						info = icons.diagnostics["Information"] .. " ",
						hint = icons.diagnostics["Hint"] .. " ",
					},
				},
			},

			lualine_x = {
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
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
			},

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
