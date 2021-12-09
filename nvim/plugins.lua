--install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim' .. install_path)
end

vim.cmd [[
  augroup packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
  ]]

local use = require('packer').use
return require('packer').startup(function()
	use { 'wbthomason/packer.nvim', opt=True } -- package manager

	--editor
<<<<<<< HEAD
	use {'junegunn/fzf.vim'} -- fuzzy search
  use {'ggandor/lightspeed.nvim'} -- alternative to hop, motions around screen
	use {'windwp/nvim-autopairs'} -- parenthesis and brackets and such
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup{
				options = {
					theme = 'onedark',
					icons_enabled = true,
				},
				extensions = {'fzf'}
			}
		end
	} -- fancy and lightweight status line
  use {'vijaymarupudi/nvim-fzf'} -- some neovim bindings for fzf
	use {'jremmen/vim-ripgrep'} -- ripgrep in neovim
	use {'stefandtw/quickfix-reflector.vim'} -- allow better interaction w/ quickfex
	use {'jpalardy/vim-slime'} -- send commands to other tmux panes, not sure if I prefer it to neoterm
  use {'kassio/neoterm'} -- send commands to neovim terminal in a new persistent buffer
	use {'vimwiki/vimwiki'} -- handy diary and todo list keeping stuff
	use {'tpope/vim-obsession'} -- saving and reloading sessions
=======
	use {'junegunn/fzf', run = ':fzf#install'}
	use {'junegunn/fzf.vim'}
	use {'justinmk/vim-sneak'}
	use {'windwp/nvim-autopairs'}
	use {'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup{
        options = {
          theme = 'onedark',
          icon_separators = true,
        },
        extensions = { 'fzf' }
      }
    end
  }
	use {'jremmen/vim-ripgrep'}
	use {'stefandtw/quickfix-reflector.vim'}
	use {'jpalardy/vim-slime'}
	use {'vimwiki/vimwiki', branch='dev' }
	use {'tpope/vim-obsession'}
>>>>>>> 4459edfc2ce272ad3c30794635f922b0bbdf770d
	use {'mhinz/neovim-remote'}
	use {'ojroques/vim-oscyank'}
--  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	--lsp 
  use {'neovim/nvim-lspconfig'}
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      {'jc-doyle/cmp-pandoc-references'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-vsnip'},
    }
  })
	use {'ojroques/nvim-lspfuzzy'}
--	use {'honza/vim-snippets'}
  use {'hrsh7th/vim-vsnip'}

	--themes and syntax)
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use {'godlygeek/tabular'}
	use {'plasticboy/vim-markdown'}
	use {'vim-pandoc/vim-pandoc'}
	use {'vim-pandoc/vim-pandoc-syntax'}
	use {'ayu-theme/ayu-vim'}
	use {'elementx54/moosefw_vim'}
	use {'lervag/vimtex'}
  use {'Pocco81/Catppuccino.nvim'}
  use {'ful1e5/onedark.nvim'}
end)
-- markdown live preview, TODO figure out proper syntax
-- might not be useful on remote machine?
-- use {'iamcco/markdown-preview.nvim', hook=fn['mkdp#util#install()']}

-- file browser
-- use 'ms-jpq/chadtree', {'branch': 'chad', 'do':':UpdateRemotePlugins'}

-- lua status line
-- local lualine = require('lualine')
-- lualine.theme = 'onedark'
-- lualine.extensions = { 'fzf' }
-- lualine.status()

-- autogenerate toc
-- paq {'ndaman/vim-markdown-toc'}

-- no longer needed
-- Plug 'neomake/neomake'
-- Plug 'ndaman/vim-lsdyna'

