-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Url = require(GameDetailRoduxParent.Http).Url

return function(arg1, arg2)
    assert(type(arg2) == "table", "GamesMultigetDetails request expects universeIds to be a table")

    if #arg2 == 0 or #arg2 > 100 then
        error("GamesMultigetDetails request expects universeIds count between 1-100")
    end

    local str1 = table.concat(arg2, ",")
    return arg1(string.format("%sv1/games?universeIds=%s", Url.GAME_URL, str1), "GET")
end
