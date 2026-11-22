-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayabilityRoduxParent = script:FindFirstAncestor("PlayabilityRodux").Parent

local Url = require(PlayabilityRoduxParent.Http).Url

return function(arg1, arg2)
    assert(type(arg2) == "table", "GamesMultigetPlayabilityStatus request expects universeId to be a table")

    local str1 = table.concat(arg2, ",")
    return arg1(string.format("%s/v1/games/multiget-playability-status?universeIds=%s", Url.GAME_URL, str1), "GET")
end
