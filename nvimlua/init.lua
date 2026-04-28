local path_package = vim.fn.stdpath("data") .. "/site/"

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.termguicolors = true

local function set_transparent()
  local groups = {
    "Normal",
    "NormalNC",
    "EndOfBuffer",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "ColorColumn",
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "none" })
  end
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 4
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 10
vim.opt.smartindent = true
vim.opt.incsearch = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.opt.hlsearch = true

local undodir = vim.fn.expand("~/.vim/undodir")
if
  vim.fn.isdirectory(undodir) == 0
then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.keymap.set('n', '<leader>cd', function()
  local dir = vim.fn.expand('%:p:h')
  vim.api.nvim_set_current_dir(dir)
end, { desc = 'CD to current file' })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.pack.add({
--	{ src = 'https://github.com/neovim/nvim-lspconfig', name = 'lspconfig' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/chrisbra/csv.vim" },
  { src = 'https://github.com/nvim-mini/mini.indentscope' },
  { src = 'https://github.com/nvim-mini/mini.jump2d' },
  { src = 'https://github.com/nvim-mini/mini.sessions' },
  { src = 'https://github.com/Saghen/blink.cmp', { confirm = false } },
  { src = 'https://github.com/ibhagwan/fzf-lua', name = 'fzf-lua' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons', name = 'devicons' },
  { src = 'https://github.com/windwp/nvim-autopairs', name = 'nvim-autopairs' },
  { src = 'https://github.com/kylechui/nvim-surround', name = 'nvim-surround' },
  { src = 'https://github.com/folke/persistence.nvim' },
  { src = 'https://github.com/OXY2DEV/markview.nvim' },
  { src = 'https://github.com/jmbuhr/otter.nvim' },
  { src = 'https://github.com/quarto-dev/quarto-nvim' },
})

-- color scheme
require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  transparent_background = false,
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
  },
})
vim.cmd.colorscheme("catppuccin-nvim")

-- treesitter
require("nvim-treesitter.install").update("all")
require("nvim-treesitter.config").setup({
  sync_install = true,

  modules = {},
  ignore_install = {},

  ensure_installed = {
    "lua",
    "c", "cpp",
    "python", "csv",
    "markdown","css", "html", "markdown_inline",
    "dockerfile", "yaml", "json", "latex",
  },

  auto_install = true,

  highlight = {
    enable = true,
  },
})

-- undotree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- wsl clipboard
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

local nas_drive = "Z:\\"
local is_nas_connected = vim.fn.isdirectory(nas_drive) == 1

if is_nas_connected then
  vim.g.nas_mode = true
else
  vim.g.nas_mode = false
end

-- tsv files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.txt",
  callback = function(args)
    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1]

    if first_line and first_line:find("\t") then
      vim.bo[args.buf].filetype = "tsv"
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tsv",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 20
		vim.opt_local.shiftwidth = 20
	end,
})

-- find python
local function get_python_path()
  if os.getenv("VIRTUAL_ENV") then
    return os.getenv("VIRTUAL_ENV") .. "/bin/python"
  end

  local venv_path = vim.fn.finddir(".venv", ".;")
  if type(venv_path) == "string" and venv_path ~= "" then
    return vim.fn.fnamemodify(venv_path, ":p") .. "bin/python"
  end

  return "python3"
end

--lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('ty', {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  capabilities = capabilities,
  root_markers = { ".git", "pyproject.toml", "setup.py", "requirements.txt", ".venv" },
  settings = {
      analysis = {
        indexing = true,
      },
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end,
})

vim.lsp.enable('ty')

vim.lsp.config('lua_ls', {
  cmd = { "lua-language-server" },

  capabilities = capabilities,

  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})
vim.lsp.enable('lua_ls')

---- C/C++
--vim.lsp.config('clangd', {
--  cmd = { "clangd", "--background-index", "--clang-tidy" },
--  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
--})
--vim.lsp.enable('clangd')
--
---- Arduino
---- Note: Requires arduino-cli installed on your system
--vim.lsp.config('arduino_language_server', {
--  cmd = { "arduino-language-server" },
--  filetypes = { "arduino" },
--})
--vim.lsp.enable('arduino_language_server')


-- try Oil instead of tree
require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["-"] = false,
    ["<BS>"] = "actions.parent",
  },
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- indentscope
require('mini.indentscope').setup({
  symbol = '|',
  options = {
    border = 'both',
    indent_at_cursor = true,
    try_as_border = false,
  },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tsv", "csv", "help", "terminal", "nvim-tree", "oil" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- jump
require('mini.jump2d').setup({
  mappings = {
    start_jumping = '<leader>j',
  },
  view = {
    dim = true,
  },
})

--sessions
require('mini.sessions').setup({
  autoread = false,
  autowrite = true,
  directory = vim.fn.stdpath('state') .. '/sessions/',
  file = 'Session.vim',
})
local sessions = require('mini.sessions')
vim.keymap.set('n', '<leader>sw', function() sessions.write('Session.vim') end, { desc = 'Save session' })
vim.keymap.set('n', '<leader>sr', function() sessions.read('Session.vim') end, { desc = 'Restore session' })
vim.keymap.set('n', '<leader>sf', function() sessions.select() end, { desc = 'Find sessions' })

-- blink autocomplete
require('blink.cmp').setup({
  keymap = { preset = 'super-tab' },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  signature = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  completion = {documentation = {auto_show = true } },

  fuzzy = { implementation = "prefer_rust_with_warning" },

})

-- fzf-lua
local fzf = require('fzf-lua')
fzf.setup({
	{"fzf-native", "hide" },
  winopts = {
	  height = 0.85,
	  width = 0.80,
	  preview = {
		  layout = 'vertical',
	  },
  },
})
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = 'FZF Buffers' })
vim.keymap.set('n', '<leader>f', fzf.files, { desc = 'FZF Files' })
vim.keymap.set('n', '<leader>g', fzf.live_grep, { desc = 'FZF Grep' })

-- nvim-autopairs
require('nvim-autopairs').setup {}

-- nvim-surround
-- :h nvim-surround.usage for a guide, sounds useful
require('nvim-surround').setup {}

-- persistence
require('persistence').setup {}
vim.keymap.set("n", "<leader>qs", function() require("persistence").select() end)
vim.keymap.set("n", "<leader>qS", function() require("persistence").load() end)
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)

-- markview
require('markview').setup({
  preview = {
    icon_provider = "devicons",
  },
})
vim.api.nvim_set_keymap("n", "<leader>ms", "<CMD>Markview splitToggle<CR>", { desc = "Toggles `splitview` for current buffer." })
vim.api.nvim_set_keymap("n", "<leader>mm", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." })

--quarto
require('otter').setup {}
local quarto = require('quarto')
quarto.setup()
vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })
