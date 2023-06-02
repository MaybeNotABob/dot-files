local status_ok, blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.opt.termguicolors = true

-- rainbow tones
--vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- grey tones
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#a7a7a7 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#ababab gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#828282 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#595959 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#303030 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#080808 gui=nocombine]]

-- turn on white space markings
--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"

blankline.setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
