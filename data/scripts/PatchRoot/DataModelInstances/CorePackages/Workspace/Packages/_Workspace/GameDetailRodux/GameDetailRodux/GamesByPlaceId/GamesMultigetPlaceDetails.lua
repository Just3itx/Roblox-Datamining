-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Url = require(GameDetailRoduxParent.Http).Url

return function(arg1, placeIds)
    local var1 = Url:makeQueryString({ placeIds = placeIds })
    return arg1(string.format("%s/v1/games/multiget-place-details?%s", Url.GAME_URL, var1), "GET")
end
