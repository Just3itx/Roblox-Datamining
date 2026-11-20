-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloPresenceParent = script:FindFirstAncestor("ApolloPresence").Parent

local Cryo = require(ApolloPresenceParent.Cryo)

local PresenceType = require(ApolloPresenceParent.GraphQLServer).types.PresenceType

local tbl1 = {
    [PresenceType.Offline] = 0,
    [PresenceType.Online] = 1,
    [PresenceType.InGame] = 2,
    [PresenceType.InStudio] = 3
}

local var1 = Cryo.List.foldLeft(Cryo.Dictionary.keys(tbl1), function(arg1, arg2)
    local var1 = tbl1[arg2]
    arg1[tostring(var1)] = arg2
    return arg1
end, {})

local function convertToStringWithDefault(arg1): string -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 then
        return tostring(arg1)
    end

    return ""
end

local function formatNumberToPresenceType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 and var1[tostring(arg1)] or PresenceType.Offline
end

return {
    formatNumberToPresenceType = formatNumberToPresenceType,
    formatPresenceTypeToNumber = function(arg1)
        return arg1 and tbl1[arg1] or tbl1[PresenceType.Offline]
    end,
    formatUserPresence = function(tbl2)
        local tbl3 = {
            id = tbl2.id,
            userPresenceType = 0,
            lastLocation = 0,
            lastOnline = 0,
            gameId = 0,
            placeId = 0,
            rootPlaceId = 0,
            universeId = 0
        }
        local userPresenceType

        if tbl2.userPresenceType then
            userPresenceType = tbl2.userPresenceType
        else
            local userPresenceNumber = tbl2.userPresenceNumber
            userPresenceType = userPresenceNumber and var1[tostring(userPresenceNumber)] or formatNumberToPresenceType(false)
        end

        tbl3.userPresenceType = userPresenceType

        tbl3.lastLocation = tbl2.lastLocation or ""
        tbl3.lastOnline = tbl2.lastOnline or ""
        tbl3.gameId = convertToStringWithDefault(tbl2.gameId)
        tbl3.placeId = convertToStringWithDefault(tbl2.placeId)
        tbl3.rootPlaceId = convertToStringWithDefault(tbl2.rootPlaceId)
        tbl3.universeId = convertToStringWithDefault(tbl2.universeId)
        return tbl3
    end
}
