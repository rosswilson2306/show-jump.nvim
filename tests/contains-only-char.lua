local contains_only_char = require("show-jump")._contains_only_char

local eq = assert.are.same

describe("contains_only_char", function()
  it("should return true if all characters in string are the same", function()
    eq(contains_only_char("00000000", "0"), true)
  end)

  it("should return false if any character is not the search char", function()
    eq(contains_only_char("00000100", "0"), false)
    eq(contains_only_char("00200000", "0"), false)
  end)
end)
