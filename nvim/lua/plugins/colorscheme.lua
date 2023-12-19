local M = {
  -- colorscheme repo
	"MaybeNotABob/nordtheme",
  lazy = false,
  priority = 1000,
}


function M.config ()
  -- load the colorscheme here
  vim.cmd([[colorscheme nord]])
end


return M