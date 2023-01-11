-- Copied and modified from https://github.com/nvim-lua/kickstart.nvim by TJ DeVries

require('techcarpenter')

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd.packadd('packer.nvim')
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim', -- Useful status updates for LSP
      'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
      require('nvim-treesitter.install').compilers = { 'zig' } -- requires running `choco install zig` on Windows
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'gaoDean/autolist.nvim'
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'Glench/Vim-Jinja2-Syntax'
  use 'folke/zen-mode.nvim'
  use 'folke/which-key.nvim'

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable('make') == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- local pandoc_syntax = vim.api.nvim_create_augroup("PandocSyntax", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
--   pattern = { "*.md" },
--   callback = function()
--     vim.cmd("set filetype=markdown.pandoc")
--     print('changed filetype!')
--   end,
--   group = pandoc_syntax
-- })

-- Bracket wrap key bindings
-- vim.keymap.set('i', '(', '()<left>')
-- vim.keymap.set('i', '[', '[]<left>')
-- vim.keymap.set('i', '{', '{}<left>')
-- vim.keymap.set('i', '<', '<><left>')
--
-- function MakeSession()
--   local pwd = string.gsub(vim.fn.getcwd(), 'C:', '', 1)
--
--   local sessionDir = (vim.fn.stdpath('data') .. '\\sessions' .. pwd)
--   if vim.fn.filewritable(sessionDir) ~= 2 then
--     vim.fn.mkdir(sessionDir, 'p')
--     vim.cmd.redraw()
--   end
--
--   local sessionFile = sessionDir .. '\\session.vim'
--   vim.cmd.mksession(sessionFile)
-- end

-- MakeSession()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
