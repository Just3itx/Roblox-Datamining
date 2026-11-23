-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local DataHydration = require(AppChatParent.DataHydration)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local RoactUtils = require(AppChatParent.RoactUtils)
local SetUserPresences = require(AppChatParent.UserLib).Thunks.SetUserPresences
local dependencyArray = RoactUtils.Hooks.dependencyArray
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local var1 = require(AppChat.Logger):new("AppChat.Realtime.ChatExternalEventReceiver2")
local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
local ChatFriendshipDestroyed = require(AppChat.App.Thunks.ChatFriendshipDestroyed)
local ChatFriendshipCreated = require(AppChat.App.Thunks.ChatFriendshipCreated)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local var2 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local tbl1 = { localUserId = 0 }

function ChatExternalEventReceiver2(tbl2)
    local var3 = Cryo.Dictionary.join(tbl1, tbl2)
    local var4 = useDispatch()

    RealtimeDelivery.useRealtimeNamespace("PresenceBulkNotifications", function(arg1)
        local var5 = Cryo.List.map(arg1, function(arg2): string
            return tostring(arg2.UserId)
        end)
        var1:info("Received PresenceBulkNotifications, user count: {}.", #var5)
        if var5 == nil or #var5 == 0 then
            return
        end

        if FFlagAppChatPresenceStoreMigration then
            for _, value in var5 do
                var2.RefreshPresenceByUserId(value)
            end

            return
        end

        var1:info("\tfetching user presence with a coroutine..")
        task.spawn(function()
            var4(NetworkingPresence.GetPresencesFromUserIds.API(var5)):andThen(function(arg2)
                var1:info("\tfetched user presence, storing response..")
                var4(SetUserPresences(arg2.responseBody.userPresences))
            end):catch(function(arg2)
                var1:warning(
                    "NetworkingPresence failure in PresenceBulkNotifications->GetPresencesFromUserIds, Status: " .. tostring(arg2)
                )
            end)
        end)
    end, dependencyArray(var4))

    RealtimeDelivery.useRealtimeNamespace("FriendshipNotifications", function(arg1)
        local str1 = tostring(var3.localUserId)
        local userId1 = arg1.EventArgs.UserId1
        local var5 = if str1 == tostring(userId1) then tostring(arg1.EventArgs.UserId2) else tostring(arg1.EventArgs.UserId1)
        var1:info("Received FriendshipNotifications: {}, otherUserId: {}.", arg1.Type, var5)

        if arg1.Type == "FriendshipDestroyed" then
            var4(ChatFriendshipDestroyed(var5))
        elseif arg1.Type == "FriendshipCreated" then
            var4(ChatFriendshipCreated(var5))
        end
    end, dependencyArray(var4, var3.localUserId))

    return nil
end

return ChatExternalEventReceiver2
