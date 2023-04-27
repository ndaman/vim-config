# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt notify
unsetopt beep
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nick/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
export LS_COLORS="$(vivid generate molokai)$"

# used for cross-platform copy/paste ( not needed with windows terminal )
# export DISPLAY=:0

export EDITOR=/usr/bin/nvim
#export EDITOR=~/.local/bin/nv
export VISUAL=/usr/bin/nvim

# make ls pretty
alias ls='ls --color=auto'
# shortcut to yayfzf and pacfzf
alias yf=yayfzf
alias pf=pacfzf
alias nv=nvim
alias vi=nv
alias gitu='git add . && git commit && git push'
# pacbak to backup pacman installed packages
alias pacbak='pacman -Qqe > ~/vim-config/pkglist.txt'
# pacrst to restore/install packages from list
alias pacrst='yay -S --needed - < ~/vim-config/pkglist.txt'

# case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# fish-style autocomplete
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# shift-tab to accept completion
bindkey '^[[Z' autosuggest-execute

# open urls in firefox
export BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'

# dotfiles status anywhere
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'

# fzf to kill processes
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

#source nnn settings
source ~/vim-config/zsh/nnn
