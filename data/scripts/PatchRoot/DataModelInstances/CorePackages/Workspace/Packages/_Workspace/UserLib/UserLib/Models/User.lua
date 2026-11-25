-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local GetFFlagInviteListRerank = require(UserLibParent.SharedFlags).GetFFlagInviteListRerank

local module = {
    PresenceType = {
        OFFLINE = "OFFLINE",
        ONLINE = "ONLINE",
        IN_GAME = "IN_GAME",
        IN_STUDIO = "IN_STUDIO"
    }
}

function module.new()
    return {}
end

function module.fromData(arg1, arg2, isFriend, friendRank)
    local module2 = module.new()

    module2.id = tostring(arg1)

    module2.isFetching = false
    module2.isFriend = isFriend
    module2.friendRank = friendRank or 0
    module2.lastLocation = nil
    module2.name = arg2
    module2.displayName = arg2
    module2.externalAppDisplayName = arg2
    module2.universeId = nil
    module2.placeId = nil
    module2.rootPlaceId = nil
    module2.gameInstanceId = nil

    module2.presence = if Players.LocalPlayer and module2.id == tostring(Players.LocalPlayer.UserId) then module.PresenceType.ONLINE or nil else nil

    module2.DEPRECATED_thumbnails = nil
    module2.lastOnline = nil

    return module2
end

function module.fromDataTable(arg1)
    local module2 = module.new()

    module2.id = tostring(arg1.id)
    module2.isFriend = arg1.isFriend
    module2.friendRank = arg1.friendRank
    module2.presence = if Players.LocalPlayer and module2.id == tostring(Players.LocalPlayer.UserId) then module.PresenceType.ONLINE or nil else nil

    module2.isFetching = false
    module2.lastLocation = nil
    module2.name = arg1.name
    module2.displayName = arg1.displayName or arg1.name
    module2.externalAppDisplayName = arg1.externalAppDisplayName
    module2.universeId = nil
    module2.placeId = nil
    module2.rootPlaceId = nil
    module2.gameInstanceId = nil
    module2.DEPRECATED_thumbnails = nil
    module2.lastOnline = nil
    module2.hasVerifiedBadge = arg1.hasVerifiedBadge

    if GetFFlagInviteListRerank() then
        module2.friendFrequentRank = arg1.friendFrequentRank
    end

    return module2
end

function module.compare(arg1, arg2)
    assert(not (arg1 == nil and arg2 == nil), "user1 and user2 cannot both be nil")
    assert(arg1 == nil or typeof(arg1) == "table", "user1 must be a table or nil")
    assert(arg2 == nil or typeof(arg2) == "table", "user2 must be a table or nil")

    if not (arg1 and arg2) then
        return false
    end

    for k, value in pairs(arg2) do
        if arg1[k] ~= value then
            return false
        end
    end

    for k, value in pairs(arg1) do
        if arg2[k] ~= value then
            return false
        end
    end

    return true
end

function module.userPresenceToText(arg1, arg2)
    local presence = arg2.presence
    local lastLocation = arg2.lastLocation

    if not presence then
        return ""
    elseif presence == module.PresenceType.OFFLINE then
        return arg1:Format("Common.Presence.Label.Offline")
    elseif presence == module.PresenceType.ONLINE then
        return arg1:Format("Common.Presence.Label.Online")
    elseif presence == module.PresenceType.IN_GAME or presence == module.PresenceType.IN_STUDIO then
        if lastLocation ~= nil then
            return lastLocation
        end
        return arg1:Format("Common.Presence.Label.Online")
    end
end

return module
