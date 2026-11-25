-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRoduxParent = script:FindFirstAncestor("PlaceInfoRodux").Parent

local Url = require(PlaceInfoRoduxParent.Http).Url

return function(arg1, placeIds)
    local var1 = Url:makeQueryString({ placeIds = placeIds })
    return arg1(string.format("%s/v1/games/multiget-place-details?%s", Url.GAME_URL, var1), "GET")
end
