-- ========================================================================= --
--  Packer Boiler Plate
-- ========================================================================= --

-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

  -- packer plugin declaration
  use "wbthomason/packer.nvim"

-- ========================================================================= --
-- ** User plugins **
-- ========================================================================= --

  -- pop-up API for neovim
  use "nvim-lua/popup.nvim"

  -- useful functions used by many plugins 
  use "nvim-lua/plenary.nvim"

  -- colour schemes
  -- use "rebelot/kanagawa.nvim"
  use "MaybeNotABob/nordtheme"

-- ========================================================================= --
-- Completion 
-- ========================================================================= --

  -- completion plugins
  use "hrsh7th/nvim-cmp"

  -- buffer completion
  use "hrsh7th/cmp-buffer"

  -- path completion
  use "hrsh7th/cmp-path"

  -- command line completion
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippet completion
  use "saadparwaiz1/cmp_luasnip"

  -- Treesitter completion source
  use "ray-x/cmp-treesitter"

  -- snippet engine
  use "L3MON4D3/LuaSnip"

-- ========================================================================= --
-- LSP 
-- ========================================================================= --

  -- Language Server Protocol [LSP]

  -- Mason plugin manager
  use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
  }
  -- LSP settings
  use "tamago324/nlsp-settings.nvim"

  -- function signature help
  use "ray-x/lsp_signature.nvim"

 -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

 -- preview peek
 use "rmagatti/goto-preview"

-- ========================================================================= --
-- Telescope 
-- ========================================================================= --

  -- fuzzy finder
  use 'nvim-telescope/telescope.nvim'
  -- telescope requires the following tools to be installed for full
  -- functionality:
  --  
  -- BurntSushi/ripgrep     -- https://github.com/BurntSushi/ripgrep
  -- sharkdp/fd             -- https://github.com/sharkdp/fd

  -- indentation guide lines
  use 'lukas-reineke/indent-blankline.nvim'

-- ========================================================================= --
-- File management 
-- ========================================================================= --

  -- file explorer      
  use {
        'kyazdani42/nvim-tree.lua',
        requires = {
                       -- optional, for file icon
                        'kyazdani42/nvim-web-devicons',
                    },
        config = function() require'nvim-tree'.setup {} end
  }

-- ========================================================================= --
-- Editing 
-- ========================================================================= --

  -- line commenting
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- line or block rearrangement
  use "fedepujol/move.nvim"

  -- navigation
  use "christoomey/vim-tmux-navigator"

-- ========================================================================= --
-- **   User plugins END    **
-- ========================================================================= --


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
