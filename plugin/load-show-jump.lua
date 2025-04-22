vim.keymap.set("n", "gs", function()
  require("show-jump").show_commit()
end)
