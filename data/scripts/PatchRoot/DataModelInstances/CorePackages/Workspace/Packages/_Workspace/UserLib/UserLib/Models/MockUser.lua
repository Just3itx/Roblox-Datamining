-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local User = require(script.Parent.User)

local num1 = 0

local function func1(): string -- Luacid: Inlined by compiler; 1 call site recovered
    num1 += 1
    return tostring(num1)
end

local module = {}
module.__index = module

function module.new()
    local user = User.new()

    user.id = func1()

    user.isFetching = false
    user.isFriend = false
    user.friendRank = 0
    user.lastLocation = nil
    user.name = "USER NAME"
    user.universeId = nil
    user.placeId = nil
    user.rootPlaceId = nil
    user.gameInstanceId = nil
    user.presence = User.PresenceType.OFFLINE
    user.membership = nil
    user.thumbnails = nil
    user.lastOnline = nil
    user.displayName = "DN+" .. user.name
    user.externalAppDisplayName = "EXTERNAL APP DISPLAY NAME"
    user.hasVerifiedBadge = false
    user.hasRobloxSubscription = false

    setmetatable(user, { __index = User })

    return user
end

function module.mockEndpointResponse()
    return {
        created = "0001-01-01T06:00:00Z",
        displayName = "DN+12345",
        friendFrequentRank = 1,
        friendFrequentScore = 2,
        id = 12345,
        isBanned = false,
        isDeleted = false,
        isOnline = false,
        name = "USER NAME",
        presenceType = 0,
        hasVerifiedBadge = false
    }
end

return module
