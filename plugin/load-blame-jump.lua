vim.keymap.set("n", "gb", function()
  require("blame-jump").show_commit()
end)
