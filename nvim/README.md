# Neovim dot-files  

Documenting my config progression as I explore the Neo(Vim) world.

## Screenshot of curent theme/config: <br>
<br>
  <img src="https://github.com/MaybeNotABob/nordtheme/blob/ca1787b07aa3a8e0f13e7226b1f54bf81d57ce0f/nord-dark.png">

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
│   │   ├── lsp_signature.lua
│   │   ├── mason.lua
|   |   ├── null-ls.lua
│   │   ├── telescope.lua
│   │   └── treesitter.lua
│   └── user
│       ├── backup
│       └── swap


```

## Change log

- [13-APR-2024]:  Added None-ls (wraps null-ls) for formattng.
- [20-DEC-2023]:  Moved to Lazy plugin manager from packer.


## Acknowledgements

__ChrisAtMachine / C@M__  
Massive thank you for the instructional videos (NeoVim setup with Lua).  
Go checkout his YouTube: https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ

__NordTheme__  
https://github.com/nordtheme/vim

__Yuki Uthman__  
youtube.com/watch?v=uDPZ2yJS6os
