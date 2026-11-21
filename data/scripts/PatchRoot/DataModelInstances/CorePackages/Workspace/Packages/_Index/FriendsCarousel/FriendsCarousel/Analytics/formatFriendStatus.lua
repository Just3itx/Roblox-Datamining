-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local FriendStatuses = require(scriptParentParent.dependencies).SocialLuaAnalytics.Analytics.Enums.FriendStatuses
local _LocalTypes = require(scriptParentParent.Common.LocalTypes)

return function(arg1)
    if arg1.isFriendWithUser then
        return FriendStatuses.Friends
    end

    if arg1.hasPendingFriendRequest then
        return FriendStatuses.RequestSent
    end

    if arg1.hasIncomingFriendRequest then
        return FriendStatuses.RequestReceived
    end

    return FriendStatuses.NotFriends
end
