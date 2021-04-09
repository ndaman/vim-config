vim.cmd 'packadd packer.nvim'
local packer = require('packer')

packer.init({
	package_root = '~/.local/share/nvim-nightly/site/pack',
	compile_path = '~/.config/nvim-nightly/plugin/packer_compiled.vim'
})

return packer.startup(function()
	use { 'wbthomason/packer.nvim', opt = true }

	--editor
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
	use {'mhinz/neovim-remote'}
	use {'ojroques/vim-oscyank'}
--  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	--lsp 
	use {'shougo/deoplete-lsp'}
	use {'shougo/deoplete.nvim', run = ':remote#UpdateRemotePlugins'}
  use {'paretje/deoplete-notmuch', ft='mail'}
	use {'neovim/nvim-lspconfig'}
	use {'ojroques/nvim-lspfuzzy'}
	use {'honza/vim-snippets'}

	--themes and syntax)
	use {'nvim-treesitter/nvim-treesitter'}
	use {'godlygeek/tabular'}
	use {'plasticboy/vim-markdown'}
	use {'vim-pandoc/vim-pandoc'}
	use {'vim-pandoc/vim-pandoc-syntax'}
	use {'ayu-theme/ayu-vim'}
	use {'elementx54/moosefw_vim'}
	use {'lervag/vimtex'}
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

-- autogenerate toc
-- paq {'ndaman/vim-markdown-toc'}

