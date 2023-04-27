return {
  {
    "AckslD/nvim-FeMaco.lua",
    keys = {
      {
        "<leader>cb",
        function()
          require("femaco.edit").edit_code_block()
        end,
        desc = "edit code block with full LSP environment",
      },
    },
  },
}
