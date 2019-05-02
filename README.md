# vim-config

I wanted to centralize my vim config settings and any other installation instructions so that I can more easily keep things consistent. I will also keep track of things to improve to make the process easier.

Currently have three files to track: 
- init.vim (vimrc) 
- ginit.vim (gui settings) 
- snippets/markdown.snip (custom snippets for markdown)

## installation
1. Install python 3 (if needed)
2. Install neovim (on windows use chocolatey, which installs nvim-qt by default)
3. Install [vim-plug](https://github.com/junegunn/vim-plug)
4. Install fzf binary

On chromebook (chromebrew), need to force installation of old version of deoplete to work with older supplied version of neovim.

## TODO
streamline python 3 on windows (currently is not default which is a pain)
remap <c-k> in insert mode (for inserting special characters)
add snippets for commonly used characters? (sigma, epsilon)
