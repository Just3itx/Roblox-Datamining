-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local User = require(UserLib.Models.User)
local WebPresenceMap = require(UserLib.Enum.WebPresenceMap)
local ConvertUniverseIdToString = require(UserLibParent.SharedFlags).ConvertUniverseIdToString

game:DefineFastFlag("LuaAppFixActiveGameLoadingCheck", false)

return function(arg1, arg2)
    local result = {}

    if game:GetFastFlag("LuaAppFixActiveGameLoadingCheck") and not arg2:getState().UniversePlaceInfos then
        return result
    end

    for _, value in pairs(arg1) do
        local var1 = ConvertUniverseIdToString(value.universeId)

        if WebPresenceMap[value.userPresenceType] == User.PresenceType.IN_GAME and not arg2:getState().UniversePlaceInfos[var1] then
            table.insert(result, value.placeId)
        end
    end

    return result
end
