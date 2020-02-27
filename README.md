# vim-config

I wanted to centralize my vim config settings and any other installation instructions so that I can more easily keep things consistent. I will also keep track of things to improve to make the process easier.

## installation
1. Install python 3 (if needed, in windows I like to use conda, make sure Python 3 is default)
2. Install neovim (on windows use `choco install neovim`, which installs nvim-qt by default)
3. Install pynvim (need to do this in both python 2 and 3 environments if both are to be used)
```
pip install --user pynvim
```
4. Install [vim-plug](https://github.com/junegunn/vim-plug)
5. Install fzf binary (`choco install fzf`)
6. Install [source code pro font](https://github.com/adobe-fonts/source-code-pro)
7. Edit init.vim so it reads
```
let g:python3_host_prog = '/path/to/python3'
let g:python_host_prog = '/path/to/python2'
source /path/to/vim-config/init.vim
```
8. Edit ginit.vim
```
source /path/to/vim-config/ginit.vim
```
9. make a symlink from vim-config/ultisnips to coc/ultisnips
```
cmd /c mklink /D ~/AppData/Local/coc/ultisnips /path/to/vim-config/ultisnips
```
10. make a symlink from vim-config/ftdetect to nvim/
```
cmd /c mklink /D ~/AppData/Local/nvim/ftdetect /path/to/vim-config/ftdetect
``` 
make my own fork of lsdyna plugin and download that instead of original
more work is needed to edit the lsdyna plugin to avoid having it overwrite the default colorscheme

### chromebook
*I don't think these steps are needed for coc.nvim now that I have switched*
1. install pynvim
``` 
pip3 install --user pynvim 
```
2. manually install old version of deoplete [link](https://github.com/Shougo/deoplete.nvim/releases/tag/4.1) (unzip to ~/.config/nvim/)
3. proceed as usual

### platformio
1. install python 2
``` 
conda create -n py27 python=2.7
conda activate py27
pip install platformio
```
2. initialize project with
```
mkdir MyProject
cp vim-config/Makefile MyProject/Makefile
```
Edit the Makefile init entry so that it contains a --board <ID> on the pio init line, then init with
```
make init
```
3. to get autocomplete working properly, install [clangd](https://clang.llvm.org/extra/clangd/) and configure it for [coc.nvim](https://github.com/neoclide/coc.nvim/wiki/Language-servers). 
The ```make init``` command should generate the correct ```compile_flags.txt``` file for clangd to use and find the appropriate libraries/includes.

## TODO
vim-ipython-cell [link](https://github.com/hanschen/vim-ipython-cell)

want to find/edit a plugin so that on keypress (<C-m> possibly) a window pops up with make targets
Can this be done in Neomake?
  
Split LS-DYNA plugin into separate files and modify them. One for Deoplete autocompletion and one for syntax highlighting.

