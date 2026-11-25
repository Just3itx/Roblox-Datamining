-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local ReceivedUserPresence = require(UserLib.Actions.ReceivedUserPresence)
local UpdateFriendPresenceCounts = require(UserLibParent.LegacyFriendsRodux).Actions.UpdateFriendPresenceCounts
local WebPresenceMap = require(UserLib.Enum.WebPresenceMap)

return function(arg1, arg2)
    for _, value in pairs(arg1) do
        local user = arg2:getState().Users[tostring(value.userId)]
        local universeId = user and user.universeId or nil

        local universeId2 = value.universeId

        local var1 = ReceivedUserPresence
        local str1 = tostring(value.userId)
        local var2 = WebPresenceMap[value.userPresenceType]
        local lastLocation = value.lastLocation
        local var3 = if value.placeId then tostring(value.placeId) or nil else nil
        local var4 = if value.rootPlaceId then tostring(value.rootPlaceId) or nil else nil
        local var5 = if value.gameId then tostring(value.gameId) or nil else nil
        arg2:dispatch(
            var1(
                str1,
                var2,
                lastLocation,
                var3,
                var4,
                var5,
                value.lastOnline and tostring(value.lastOnline) or nil,
                universeId2,
                universeId
            )
        )
    end

    local tbl1 = {}
    for _, user in pairs(arg2:getState().Users) do
        if user.isFriend and user.presence then
            local var1 = tbl1[user.presence] or 0
            tbl1[user.presence] = var1 + 1
        end
    end
    arg2:dispatch(UpdateFriendPresenceCounts(tbl1))
end
