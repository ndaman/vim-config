-- set common neovim options
local o = vim.opt

o.completeopt = { "menu", "menuone", "preview" }
vim.g.rg_command = 'rg --vimgrep -S'

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.hidden = true
o.ignorecase = true
o.scrolloff = 8
o.shiftround = true
o.sidescrolloff = 8
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.wildmode = {"longest:full,full"}
o.list = true
o.number = true
o.relativenumber = true
o.wrap = false
o.timeoutlen = 250
o.clipboard = 'unnamedplus'
o.inc = 'nosplit'
o.foldlevel = 99

-- code highlighting for other languages inside markdown
vim.g.markdown_fenced_languages = {'html', 'css', 'python', 'bash=sh', 'tex'}

--setup telescope stuff
