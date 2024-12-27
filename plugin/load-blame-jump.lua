vim.keymap.set("n", "gb", function()
  -- TODO change the initiation method to something other than test
  require("blame-jump").test()
end)
