local cmd = vim.cmd

-- Pack Path
cmd 'set packpath-=~/.config/nvim'
cmd 'set packpath-=~/.config/nvim/after'
cmd 'set packpath-=~/.local/share/nvim/site'
cmd 'set packpath-=~/.local/share/nvim/site/after'
cmd 'set packpath-=/etc/xdg/nvim'
cmd 'set packpath-=/etc/xdg/nvim/after'
cmd 'set packpath-=/usr/local/share/nvim/site'
cmd 'set packpath-=/usr/local/share/nvim/site/after'
cmd 'set packpath-=/usr/share/nvim/site'
cmd 'set packpath-=/usr/share/nvim/site/after'
cmd 'set packpath^=~/.config/nvim-nightly'
cmd 'set packpath+=~/.config/nvim-nightly/after'
cmd 'set packpath^=~/.local/share/nvim-nightly/site'
cmd 'set packpath+=~/.local/share/nvim-nightly/site/after'

-- -- Runtime Path
cmd 'set runtimepath-=~/.config/nvim'
cmd 'set runtimepath-=~/.config/nvim/after'
cmd 'set runtimepath-=~/.local/share/nvim/site'
cmd 'set runtimepath-=~/.local/share/nvim/site/after'
cmd 'set runtimepath-=/etc/xdg/nvim'
cmd 'set runtimepath-=/etc/xdg/nvim/after'
cmd 'set runtimepath-=/usr/share/nvim/site'
cmd 'set runtimepath-=/usr/share/nvim/site/after'
cmd 'set runtimepath-=/usr/local/share/nvim/site'
cmd 'set runtimepath-=/usr/local/share/nvim/site/after'
cmd 'set runtimepath+=~/.config/nvim-nightly/after'
cmd 'set runtimepath^=~/.config/nvim-nightly'
cmd 'set runtimepath+=~/.local/share/nvim-nightly/site/after'
cmd 'set runtimepath^=~/.local/share/nvim-nightly/site'

local CONFIG_DIR = os.getenv('HOME') .. '/.config/nvim-nightly'
local LOCAL_DIR = os.getenv('HOME') .. '/.local/share/nvim-nightly'
