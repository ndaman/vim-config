# vim-config

I wanted to centralize my vim config settings and any other installation instructions so that I can more easily keep things consistent. I will also keep track of things to improve to make the process easier.

Currently have four files to track: 
- init.vim (vimrc) 
- ginit.vim (gui settings) 
- snippets/markdown.snip (custom snippets for markdown)
- Makefile (build file for platformio projects)

## installation
1. Install python 3 (if needed, in windows I like to use conda, make sure Python 3 is default)
2. Install neovim (on windows use `choco install neovim`, which installs nvim-qt by default)
3. Install pynvim
```
pip install --user pynvim
```
4. Install [vim-plug](https://github.com/junegunn/vim-plug)
5. Install fzf binary (`choco install fzf`)
6. Install [source code pro font](https://github.com/adobe-fonts/source-code-pro)

### chromebook
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
cd MyProject
pio init --ide vim --board <ID>
cp vim-config/Makefile MyProject/Makefile
```

## TODO
want to find/edit a plugin so that on keypress (<C-m> possibly) a window pops up with make targets
Can this be done in Neomake?
