-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCurrentExperienceProject()
    local gameId = game.GameId
    local placeId = game.PlaceId

    local tbl1 = { universeId = 0, placeId = 0 }
    if gameId == 0 then
        gameId = nil
    end

    tbl1.universeId = gameId
    if placeId == 0 then
        placeId = nil
    end

    tbl1.placeId = placeId
    return tbl1
end

return getCurrentExperienceProject
