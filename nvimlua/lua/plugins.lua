local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("setup/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
	-- plugins list
	use("wbthomason/packer.nvim")

	-- lsp-related plugins
	use({ "neovim/nvim-lspconfig", config = get_config("lsp") })	
	use({
		"hrsh7th/nvim-cmp",
    		requires = {
    		  "hrsh7th/cmp-nvim-lsp",
    		  "hrsh7th/cmp-buffer",
    		  "hrsh7th/cmp-path",
    		  "hrsh7th/cmp-cmdline",
    		  "f3fora/cmp-spell",
    		  "hrsh7th/cmp-calc",
    		  "lukas-reineke/cmp-rg",
    		  "hrsh7th/cmp-nvim-lsp-signature-help",
    		},
    		config = get_config("cmp"),
	})
	use({ "rafamadriz/friendly-snippets" })
	use({
  	  "L3MON4D3/LuaSnip",
  	  requires = "saadparwaiz1/cmp_luasnip",
  	  config = get_config("luasnip"),
  	})
	use({ "onsails/lspkind-nvim" })

	-- telescope related plugins
	use({
	  "nvim-telescope/telescope.nvim",
  	  requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
  	  config = get_config("telescope"),
  	})
  use({ "jvgrootveld/telescope-zoxide" })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({ "folke/which-key.nvim", config = get_config("which-key") })

	-- other editor plugins
	use({
	  "nvim-lualine/lualine.nvim",
  	  config = get_config("lualine"),
  	  event = "VimEnter",
  	  requires = { "kyazdani42/nvim-web-devicons", opt = true },
  	})
	use({ "windwp/nvim-autopairs", config = get_config("nvim-autopairs") })
	use({ "SmiteshP/nvim-navic" })
	use({ "ggandor/lightspeed.nvim", config = get_config("lightspeed") })
	use({ 'stefandtw/quickfix-reflector.vim' })
	use({ 'michaelb/sniprun', run = 'bash ./install.sh', config = get_config("sniprun")})
	use({ 'vimwiki/vimwiki', config = get_config("vimwiki") })
	use({ 'ojroques/vim-oscyank' })
	use({ 'jremmen/vim-ripgrep' })
	use({ 'kdheepak/lazygit.nvim' })

	-- treesitter
	use({
	  "nvim-treesitter/nvim-treesitter",
  	  config = get_config("treesitter"),
  	  run = ":TSUpdate",
  	})
  	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  	use({ "RRethy/nvim-treesitter-endwise" })

	-- themes and extra syntax highlighting
	use({ 'plasticboy/vim-markdown' })
  use({ 'chrisbra/csv.vim' })
	use({ 'vim-pandoc/vim-pandoc', config = get_config("pandoc") })
	use({ 'vim-pandoc/vim-pandoc-syntax' })
	use({ 'elementx54/moosefw_vim' })
	use({ "catppuccin/nvim", as = "catppuccin", config = get_config("catppuccin") })
end)
