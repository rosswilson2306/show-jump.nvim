vim.keymap.set("n", "gc", function()
  require("show-jump").show_commit()
end)
