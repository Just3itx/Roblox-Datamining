-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local var1 = require(DataHydrationParent.RealtimeDelivery).RobloxEventReceiver.new(NotificationService)

local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local TrustedConnectionStatus = require(DataHydration.TrustedConnections.Enums.TrustedConnectionStatus)

local FFlagAddFriendsPageTrustedFriendRequestSection = require(DataHydrationParent.SharedFlags).FFlagAddFriendsPageTrustedFriendRequestSection

local tbl1 = {
    Namespace = "TrustedConnectionNotifications",
    EventTypes = {
        TrustedConnectionCreated = 1,
        TrustedConnectionDeleted = 2,
        TrustedConnectionRequestSent = 3,
        TrustedConnectionRequestAccepted = 4,
        TrustedConnectionRequestIgnored = 5
    }
}

local function createTrustedConnectionEventListener(callback: (...any) -> (...any))
    local localPlayerUserId = getLocalPlayerUserId()
    local connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
        local localPlayerUserId2 = getLocalPlayerUserId()
        if localPlayerUserId2 ~= localPlayerUserId then
            localPlayerUserId = localPlayerUserId2
        end
    end)

    local var2 = var1:observeEvent(tbl1.Namespace, function(tbl2)
        if not (tbl2.Actor and tbl2.Target and localPlayerUserId) then
            return
        end

        local str1 = tostring(tbl2.Actor)
        local str2 = tostring(tbl2.Target)
        local str3 = tostring(localPlayerUserId)

        if tbl2.EventType == tbl1.EventTypes.TrustedConnectionCreated then
            local str4 = if str1 == str3 then str2 else str1
            callback(str4, TrustedConnectionStatus.TrustedFriends)
        end

        if tbl2.EventType == tbl1.EventTypes.TrustedConnectionDeleted then
            if str3 ~= str1 then
                callback(str1, TrustedConnectionStatus.RequestSent)
            elseif FFlagAddFriendsPageTrustedFriendRequestSection then
                callback(str2, TrustedConnectionStatus.RequestIgnored)
            else
                callback(str2, TrustedConnectionStatus.RequestReceived)
            end
        end

        if tbl2.EventType ~= tbl1.EventTypes.TrustedConnectionRequestSent then
            return
        end

        if str3 == str1 then
            callback(str2, TrustedConnectionStatus.RequestSent)
            return
        end
        callback(str1, TrustedConnectionStatus.RequestReceived)
    end)

    return function()
        if connection then
            connection:Disconnect()
            connection = nil
        end

        if var2 then
            var2:disconnect()
            connection = nil
        end
    end
end

return createTrustedConnectionEventListener
