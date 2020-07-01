# vim-config

I wanted to centralize my vim config settings and any other installation instructions so that I can more easily keep things consistent. I will also keep track of things to improve to make the process easier.

## wsl setup
1. Check windows 10 version, for >2004 we can set up wsl 2
  1. follow instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
  2. install windows terminal, edit settings to remove ctl-c and ctl-v bindings
2. install arch from bootstrap per [these](https://www.reddit.com/r/bashonubuntuonwindows/comments/gxbufo/running_arch_on_wsl_from_the_source_images_the/) instructions
3. install (non AUR) packages in pkglist.txt with
```
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
```
4. add user with sudo permissions
```
useradd -m -G wheel -s /usr/sbin/zsh nick
```
  1. modify sudoers to include wheel group, uncomment line near end
  ```
  EDITOR=nvim visudo
  ```
  2. login to new user as default using method [here](https://github.com/microsoft/WSL/issues/3974)
5. install [yay](https://github.com/Jguer/yay)
  1. install foreign packages from list (may need to su to new user first)
  ```
  yay -S --needed - < pkglist.txt 
  ```
6. setup zsh
``` 
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
```
7. setup tmux
  1. clone tmux package manager
  ```
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```
  2. edit ~/.tmux.conf to source ~/vim-config/tmux/tmux.conf
  3. prefix + I to install plugins (C-b then I)
 
## installation
1. Install python 3 (if needed, in windows I like to use conda, make sure Python 3 is default)
2. Install git
3. Install neovim (on windows use `choco install neovim`, which installs nvim-qt by default)
	On Ubuntu, install the AppImage for the latest version. To use in WSL, must unpack fist
4. Install pynvim (need to do this in both python 2 and 3 environments if both are to be used)
```
pip install --user pynvim
```
or
```
pip3 install pynvim
```
5. Install [vim-plug](https://github.com/junegunn/vim-plug)
6. Install fzf binary (`choco install fzf`)
7. Install ripgrep (`choco install ripgrep`)
8. Install [source code pro font](https://github.com/adobe-fonts/source-code-pro)
9. Edit init.vim so it reads (~/.config/nvim/init.vim) (first 2 lines not needed in linux)
```
let g:python3_host_prog = '/path/to/python3'
let g:python_host_prog = '/path/to/python2'
source /path/to/vim-config/init.vim
```
10. Edit ginit.vim (not needed if using console)
```
source /path/to/vim-config/ginit.vim
```
11. make a symlink from vim-config/ultisnips to coc/ultisnips
```
cmd /c mklink /D ~/AppData/Local/coc/ultisnips /path/to/vim-config/ultisnips
```
or
```
ln -s /path/to/vim-config/ultisnips ~/.config/coc/ultisnips
```
12. make a symlink from vim-config/ftdetect to nvim/
```
cmd /c mklink /D ~/AppData/Local/nvim/ftdetect /path/to/vim-config/ftdetect
``` 
some more work is needed to edit the lsdyna plugin to avoid having it overwrite the default colorscheme

### platformio
1. ~~install python 2~~
no longer necessary (platformio now works in python 3)
``` 
conda create -n py27 python=2.7
conda activate py27
pip install platformio
```
2. initialize project with
```
mkdir MyProject
cp vim-config/platformio/* MyProject/
```
Edit the platformio.ini to match your board and platform, then init with
```
make init
```
3. to get autocomplete working properly, install [clangd](https://clang.llvm.org/extra/clangd/) and configure it for [coc.nvim](https://github.com/neoclide/coc.nvim/wiki/Language-servers). 
The ```make init``` command should generate the correct ```compile_commands.json``` file for clangd to use and find the appropriate libraries/includes.
4. looks for src/main.cpp to find setup() and loop() functions.

## TODO

want to find/edit a plugin so that on keypress (<C-m> possibly) a window pops up with make targets
Can this be done in Neomake?
  
Split LS-DYNA plugin into separate files and modify them. One for Deoplete autocompletion and one for syntax highlighting.

## Issues

coc.nvim causes some very annoying delays when I'm working on LS-DYNA files. I think this is related to the omnifunc completion?

I would like to transition from using coc.nvim to the new built-in lsp [link](https://github.com/neovim/nvim-lsp)

## bluetooth controllers
```
sudo systemctl start bluetooth
sudo bluetoothctl
power on
scan on
pair <MAC>
trust <MAC>
connect <MAC>
```
