-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local makeActionCreator = require(UserLibParent.Rodux).makeActionCreator

local DateTime = require(UserLibParent.Time).DateTime

return makeActionCreator(script.Name, function(userId, presence, lastLocation, placeId, rootPlaceId, gameInstanceId, arg1, universeId, previousUniverseId)
    local num1 = 0
    if arg1 ~= nil then
        local isoDate = DateTime.fromIsoDate(arg1)
        if isoDate ~= nil then
            num1 = isoDate:GetUnixTimestamp()
        end
    end

    return {
        userId = userId,
        presence = presence,
        lastLocation = lastLocation,
        placeId = placeId,
        rootPlaceId = rootPlaceId,
        gameInstanceId = gameInstanceId,
        lastOnline = num1,
        universeId = universeId,
        previousUniverseId = previousUniverseId
    }
end)
