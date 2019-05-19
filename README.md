# vim-config

I wanted to centralize my vim config settings and any other installation instructions so that I can more easily keep things consistent. I will also keep track of things to improve to make the process easier.

Currently have three files to track: 
- init.vim (vimrc) 
- ginit.vim (gui settings) 
- snippets/markdown.snip (custom snippets for markdown)

## installation
1. Install python 3 (if needed)
2. Install neovim (on windows use chocolatey, which installs nvim-qt by default)
3. Install pynvim
```
pip install --user pynvim
```
4. Install [vim-plug](https://github.com/junegunn/vim-plug)
4. Install fzf binary (```choco install fzf```)

### chromebook
1. install pynvim
``` pip3 install --user pynvim ```
2. manually install old version of deoplete [link](https://github.com/Shougo/deoplete.nvim/releases/tag/4.1) (unzip to ~/.config/nvim/)
3. proceed as usual

### platformio
1. install python 2
``` 
conda activate py27
pip install platformio
```
2. copy makefile

## TODO
On windows, it works best if Python 3 is the default, python 2.7 installed as a separate environment

remap <c-k> in insert mode (for inserting special characters)

add snippets for commonly used characters? (sigma, epsilon)

add instructions for setting up platformio in vim
  find a simple way to create a new project and set it up with a makefile
  automake shortcuts? neomake?
