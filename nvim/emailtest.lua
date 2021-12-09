local fzf = require("fzf")

coroutine.wrap(function()
  local result = fzf.fzf("notmuch address %s")
  if result then
    vim.cmd('norm i ' .. result[1])
  end
end)()
