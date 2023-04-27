return {
  "michaelb/sniprun",
  build = "bash ./install.sh",
  opts = {
    repl_enable = { "Python3_original" },
  },
  keys = {
    -- add keymaps
    {
      "<leader>r",
      "<Plug>SnipRun",
      desc = "snip run single line",
    },
    {
      "<leader>r",
      "<Plug>SnipRun",
      desc = "snip run selection",
      mode = "v",
    },
  },
}
