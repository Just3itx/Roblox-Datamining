-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local Rodux = require(FriendsRoduxParent.Rodux)

local receivedCount = require(script.receivedCount)
local byUserId = require(script.byUserId)
local mutualFriends = require(script.mutualFriends)
local sourceUniverseIds = require(script.sourceUniverseIds)
local nextPageCursor = require(script.nextPageCursor)
local sentAt = require(script.sentAt)
local originSourceType = require(script.originSourceType)
local order = require(script.order)
local senderNickname = require(script.senderNickname)
local isUnseen = require(script.isUnseen)
local newFriendRequestsCount = require(script.newFriendRequestsCount)

return function(arg1)
    return Rodux.combineReducers({
        receivedCount = receivedCount(arg1),
        byUserId = byUserId(arg1),
        mutualFriends = mutualFriends(arg1),
        sourceUniverseIds = sourceUniverseIds(arg1),
        nextPageCursor = nextPageCursor(arg1),
        sentAt = sentAt(arg1),
        originSourceType = originSourceType(arg1),
        order = order(arg1),
        senderNickname = senderNickname(arg1),
        isUnseen = isUnseen(arg1),
        newFriendRequestsCount = newFriendRequestsCount(arg1)
    })
end
