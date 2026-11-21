-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRoduxParent = script:FindFirstAncestor("GameProductInfoRodux").Parent
local Url = require(GameProductInfoRoduxParent.Http).Url

return function(arg1, arg2)
    assert(type(arg2) == "table", "GamesGetProductInfo request expects universeIds to be a table")
    assert(#arg2 > 0, "GamesGetProductInfo request expects universeIds count to be greater than 0")
    assert(#arg2 <= 100, "GamesGetProductInfo request expects universeIds count to not exceed " .. 100)

    local str1 = table.concat(arg2, ",")
    return arg1(string.format("%sv1/games/games-product-info?universeIds=%s", Url.GAME_URL, str1), "GET")
end
