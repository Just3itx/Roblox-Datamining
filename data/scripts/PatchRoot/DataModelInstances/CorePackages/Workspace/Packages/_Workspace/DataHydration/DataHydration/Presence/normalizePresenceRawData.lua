-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local FFlagPresenceLocationType = require(DataHydration.Parent.SharedFlags).FFlagPresenceLocationType
local PresenceType = require(script.Parent.Enums.PresenceType)

local tbl1 = {
    [0] = PresenceType.Offline,
    [1] = PresenceType.Online,
    [2] = PresenceType.InGame,
    [3] = PresenceType.InStudio
}

local function coerceStringField(arg1): string -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 == nil then
        return ""
    end
    return tostring(arg1)
end

local function mapRawPresenceTypeToEnum(userPresenceType)
    if type(userPresenceType) == "number" then
        return tbl1[userPresenceType] or PresenceType.Offline
    end

    if type(userPresenceType) == "string"
        and (userPresenceType == "Offline"
            or userPresenceType == "Online"
            or userPresenceType == "InGame"
            or userPresenceType == "InStudio")
    then
        return userPresenceType
    end

    if userPresenceType == PresenceType.Offline
        or userPresenceType == PresenceType.Online
        or userPresenceType == PresenceType.InGame
        or userPresenceType == PresenceType.InStudio
    then
        return userPresenceType
    end

    return PresenceType.Offline
end

local function fromApiPresenceTable(tbl2, arg1): {gameId: string, id: string, lastLocation: string, lastOnline: any, locationType: number, placeId: string, rootPlaceId: string, universeId: string, userPresenceType: any}?
    if tbl2 then
        arg1 = tbl2.userId or arg1
    end
    if not tbl2 or type(tbl2) ~= "table" or not arg1 then
        return nil
    end

    return {
        id = tostring(arg1),
        userPresenceType = mapRawPresenceTypeToEnum(tbl2.userPresenceType),
        lastLocation = coerceStringField(tbl2.lastLocation),
        lastOnline = tbl2.lastOnline,
        gameId = coerceStringField(tbl2.gameId),
        placeId = coerceStringField(tbl2.placeId),
        rootPlaceId = coerceStringField(tbl2.rootPlaceId),
        universeId = coerceStringField(tbl2.universeId),
        locationType = if FFlagPresenceLocationType then tbl2.locationType else nil
    }
end

return fromApiPresenceTable
