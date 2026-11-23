-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    getPlaceId = function(): number
        return game.PlaceId
    end,
    teleport = function(num1: number)
        game:GetService("TeleportService"):Teleport(num1)
    end
}

local function respawnIntoExperience(tbl2): boolean
    local var1 = tbl2 or tbl1
    local placeId = var1.getPlaceId()

    if placeId == 0 then
        warn("AccountUpgrade: cannot rejoin, PlaceId is 0")
        return false
    end

    local success, result = pcall(function()
        var1.teleport(placeId)
    end)

    if not success then
        warn(`AccountUpgrade: rejoin failed, {tostring(result)}`)
    end

    return success
end

return respawnIntoExperience
