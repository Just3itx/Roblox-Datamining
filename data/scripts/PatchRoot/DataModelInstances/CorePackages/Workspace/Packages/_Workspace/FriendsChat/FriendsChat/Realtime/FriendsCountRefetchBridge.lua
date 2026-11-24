-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local RealtimeDelivery = require(FriendsChatParent.RealtimeDelivery)
local DataHydration = require(FriendsChatParent.DataHydration)

local getLocalUserId = require(script.Parent.Parent.Utils.getLocalUserId)
local FriendshipNotifications = require(script.Parent.FriendshipNotifications)

local function FriendsCountRefetchBridge()
    RealtimeDelivery.useRealtimeNamespace(FriendshipNotifications.Namespace, function(arg1)
        if arg1 == nil
            or arg1.Type ~= FriendshipNotifications.EventType.Created and arg1.Type ~= FriendshipNotifications.EventType.Destroyed
        then
            return
        end

        local localUserId = getLocalUserId()
        if localUserId == nil then
            return
        end
        DataHydration.Friends.FriendsStore.get().RefreshFriendsCountByUserId(tostring(localUserId))
    end, {})

    return nil
end

return FriendsCountRefetchBridge
