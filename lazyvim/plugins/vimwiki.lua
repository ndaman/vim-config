return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vim-config/vimwiki",
          syntax = "markdown",
          ext = ".wiki",
        },
        {
          path = "/mnt/c/Users/ndama/scriptures",
          syntax = "markdown",
          ext = ".wiki",
        },
        {
          path = "~/ssladmin/vimwiki",
          syntax = "markdown",
          ext = ".wiki",
        },
      }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".mdown"] = "markdown",
        [".wiki"] = "markdown",
      }
    end,
  },
}
