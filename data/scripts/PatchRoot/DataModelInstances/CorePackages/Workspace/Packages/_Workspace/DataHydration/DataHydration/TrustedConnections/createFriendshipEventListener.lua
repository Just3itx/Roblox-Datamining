-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local var1 = require(DataHydrationParent.RealtimeDelivery).RobloxEventReceiver.new(NotificationService)

local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local TrustedConnectionStatus = require(DataHydration.TrustedConnections.Enums.TrustedConnectionStatus)

local tbl1 = {
    Namespace = "FriendshipNotifications",
    EventTypes = {
        FriendshipCreated = "FriendshipCreated",
        FriendshipDestroyed = "FriendshipDestroyed",
        FriendshipRequested = "FriendshipRequested",
        FriendshipDeclined = "FriendshipDeclined"
    }
}

local function createFriendshipEventListener(callback: (...any) -> (...any))
    local localPlayerUserId = getLocalPlayerUserId()
    local connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
        local localPlayerUserId2 = getLocalPlayerUserId()
        if localPlayerUserId2 ~= localPlayerUserId then
            localPlayerUserId = localPlayerUserId2
        end
    end)

    local var2 = var1:observeEvent(tbl1.Namespace, function(arg1)
        if not (arg1.EventArgs and arg1.EventArgs.UserId1 and arg1.EventArgs.UserId2 and localPlayerUserId) then
            return
        end

        local var2 = tostring(localPlayerUserId) == tostring(arg1.EventArgs.UserId1) and tostring(arg1.EventArgs.UserId2)
            or tostring(arg1.EventArgs.UserId1)

        if arg1.Type == tbl1.EventTypes.FriendshipDestroyed or arg1.Type == tbl1.EventTypes.FriendshipDeclined then
            callback(var2, TrustedConnectionStatus.NotFriends)
        end
    end)

    return function()
        if connection then
            connection:Disconnect()
            connection = nil
        end

        if var2 then
            var2:disconnect()
            var2 = nil
        end
    end
end

return createFriendshipEventListener
