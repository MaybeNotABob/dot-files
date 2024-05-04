# Neovim dot-files  

Documenting my config progression as I explore the Neo(Vim) world.

## Screenshot of curent theme/config: <br>
<br>
<img src="https://user-images.githubusercontent.com/292349/115295327-7afdce80-a10e-11eb-89b3-2591262bf95a.png"> 
<sub>Image cedit: Folke</sub>

## File Structure

```
├── init.lua
├── lazy-lock.json
├── lazyvim.json
├── lua
│   ├── config
│   │   ├── icons.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   ├── plugins
│   │   ├── cmp.lua
│   │   ├── colorscheme.lua
│   │   ├── comment.lua
│   │   ├── goto-preview.lua
│   │   ├── indent_blankline.lua
│   │   ├── lspconfig.lua
│   │   ├── mason.lua
│   │   ├── move.lua
│   │   ├── null-ls.lua
│   │   ├── nvim-tree.lua
│   │   ├── telescope.lua
│   │   ├── tmux-nav.lua
│   │   ├── treesitter.lua
│   │   └── trouble.lua
│   └── user
│       ├── backup
│       └── swap


```

## Change log

- [17-APR-2024]:  Fixed None-ls UTF-8 warning, changed colorscheme to Tokyonight.
- [13-APR-2024]:  Added None-ls (wraps null-ls) for formattng.
- [20-DEC-2023]:  Moved to Lazy plugin manager from packer.


## Acknowledgements

__ChrisAtMachine / C@M__  
Massive thank you for the instructional videos (NeoVim setup with Lua).  
Go checkout his YouTube: https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ

__ColorSchemes__  
https://github.com/nordtheme/vim
https://github.com/folke/tokyonight.nvim

__Yuki Uthman__  
youtube.com/watch?v=uDPZ2yJS6os
