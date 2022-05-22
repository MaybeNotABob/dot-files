local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
  return
end

local cfg = {

  -- set to true to enable debug logging
  debug = false, 

  -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log_path
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
       
  -- show debug line number
  verbose = false,     

  -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  bind = true,     

  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by defaulti
  -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  doc_lines = 10, 

  -- show hint in a floating window, set to false for virtual text only mode
  floating_window = true, 

  -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  floating_window_above_cur_line = true, 

  -- adjust float windows x position.
  floating_window_off_x = 1,
  -- adjust float windows y position.
  floating_window_off_y = 1, 

  -- set to true, the floating window will not auto-close until finish all parameters
  fix_pos = false,  
  hint_enable = true,
  hint_prefix = "",
  hint_scheme = "String",

  -- how your parameter will be highlight
  hi_parameter = "LspSignatureActiveParameter", 

  -- max height of signature floating_window, if content is more than max_height, you can scroll down
  -- to view the hiding contents
  max_height = 12,     

  -- max_width of signature floating_window, line will be wrapped if exceed max_width
  max_width = 80, 

  handler_opts = {
    -- double, rounded, single, shadow, none
    border = "single"    
  },

  -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  always_trigger = false, 

  -- autoclose signature float win after x sec, disabled if nil.
  auto_close_after = nil, 

  -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  extra_trigger_chars = {},  

  -- by default it will be on top of all floating windows, set to <= 49 send it to bottom
  zindex = 200, 

  -- character to pad on left and right of signature can be ' ', or '|'  etc
  padding = '', 

  -- disabled by default, allow floating win transparent value 1~100
  transparency = nil,

  -- if you using shadow as border use this set the opacity
  shadow_blend = 36, 
  
  -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  shadow_guibg = 'Black', 

  -- default timer check interval set to lower value if you want to reduce latency
  timer_interval = 200,  
   
  -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  toggle_key = nil 
}

-- recommended: -- no need to specify bufnr if you don't use toggle_key
signature.setup(cfg) 

signature.on_attach(cfg)

