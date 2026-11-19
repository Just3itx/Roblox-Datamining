-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Url = require(scriptParentParentParent.Network.Url)

return function(arg1, placeIds)
    for i, placeId in ipairs(placeIds) do
        placeIds[i] = tostring(placeId)
    end

    local var1 = Url:makeQueryString({ placeIds = placeIds })
    return arg1(string.format("%s/v1/games/multiget-place-details?%s", Url.GAME_URL, var1), "GET")
end
