-- look at open source alternative: https://github.com/dense-analysis/neural
-- main plugin
-- return {
--   "Exafunction/codeium.vim",
--   config = function()
--     -- change keymaps if desired
--     vim.keymap.set("i", "<C-g>", function()
--       return vim.fn["codeium#Accept"]()
--     end, { expr = true })
--     vim.keymap.set("i", "<c-;>", function()
--       return vim.fn["codeium#CycleCompletions"](1)
--     end, { expr = true })
--     vim.keymap.set("i", "<c-,>", function()
--       return vim.fn["codeium#CycleCompletions"](-1)
--     end, { expr = true })
--     vim.keymap.set("i", "<c-x>", function()
--       return vim.fn["codeium#Clear"]()
--     end, { expr = true })
--   end,
-- }
-- neovim native plugin
return {
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "jcdickinson/codeium.nvim" },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "codeium" } }))
    end,
  },
}
