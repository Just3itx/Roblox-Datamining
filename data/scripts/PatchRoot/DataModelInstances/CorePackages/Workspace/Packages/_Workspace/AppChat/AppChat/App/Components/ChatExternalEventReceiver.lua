-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
if require(AppChat.Flags.FFlagAppChatMigrateChatExternalEventReceiver) then
    return (require(script.Parent.ChatExternalEventReceiver2))
end

local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local DataHydration = require(AppChatParent.DataHydration)
local React = require(AppChatParent.React)
local RoactUtils = require(AppChatParent.RoactUtils)
local SetUserPresences = require(AppChatParent.UserLib).Thunks.SetUserPresences
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect

local var1 = require(AppChat.Logger):new("AppChat.RealtimeExternal")
local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
local ChatFriendshipDestroyed = require(AppChat.App.Thunks.ChatFriendshipDestroyed)
local ChatFriendshipCreated = require(AppChat.App.Thunks.ChatFriendshipCreated)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local var2 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local tbl1 = { localUserId = 0 }

function ChatExternalEventReceiver(tbl2)
    local var3 = Cryo.Dictionary.join(tbl1, tbl2)
    local var4 = useDispatch()

    useEffect(function()
        local var5 = var3.robloxEventReceiver:observeEvent("PresenceBulkNotifications", function(arg1)
            local var5 = Cryo.List.map(arg1, function(arg2): string
                return tostring(arg2.UserId)
            end)
            if FFlagAppChatPresenceStoreMigration then
                for _, value in var5 do
                    var2.RefreshPresenceByUserId(value)
                end

                return
            end

            var4(NetworkingPresence.GetPresencesFromUserIds.API(var5)):andThen(function(arg2)
                var4(SetUserPresences(arg2.responseBody.userPresences))
            end):catch(function(arg2)
                var1:warning(
                    "NetworkingPresence failure in ChatExternalEventReceiver->PresenceBulkNotifications, Status: " .. tostring(arg2)
                )
            end)
        end)

        return function()
            if var5 and var5.disconnect then
                var5:disconnect()
            end
        end
    end, { var4, var3.robloxEventReceiver })

    useEffect(function()
        local var5 = var3.robloxEventReceiver:observeEvent("FriendshipNotifications", function(arg1)
            local var5 = tostring(var3.localUserId) == tostring(arg1.EventArgs.UserId1) and tostring(arg1.EventArgs.UserId2)
                or tostring(arg1.EventArgs.UserId1)

            if arg1.Type == "FriendshipDestroyed" then
                var4(ChatFriendshipDestroyed(var5))
            elseif arg1.Type == "FriendshipCreated" then
                var4(ChatFriendshipCreated(var5))
            end
        end)

        return function()
            if var5 and var5.disconnect then
                var5:disconnect()
            end
        end
    end, { var4, var3.robloxEventReceiver, var3.localUserId })

    return nil
end

return ChatExternalEventReceiver
