-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(AppChatParent.React)

local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local ConversationChannels = require(AppChat.Models.ConversationChannels)

local refreshConversationUnfilteredThreadsDetails = require(AppChat.Conversations.Thunks.refreshConversationUnfilteredThreadsDetails)
local reloadMessagesForConversations = require(AppChat.Conversations.Thunks.reloadMessagesForConversations)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local TrustedConnections = require(script.Parent.Constants).TrustedConnections
local _TrustedConnectionsNotificationTypes = require(script.Parent.TrustedConnectionsNotificationTypes)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local ConversationModerationTypeChanged = require(AppChat.Conversations.Actions.ConversationModerationTypeChanged)
local Cryo = require(AppChatParent.Cryo)
local var1 = require(AppChat.Logger):new(script.Name)

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(AppChatParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner

local function useChatTrustedConnectionsEvents(tbl1)
    local var2 = useDispatch()
    local var3 = useSelector(function(arg1)
        return arg1.ChatAppReducer.Conversations
    end)

    local var4 = useGetConversationFromId(tbl1.activeConversationId)
    local var5 = useIsInExperience()
    local var6 = useLocalUserId()

    local var7 = React.useCallback(function(str1: string)
        if not var4 or not var4.participants or var4.type ~= ConversationChannels.Type.OneToOne or not str1 then
            return
        end

        for _, participant in var4.participants do
            if participant == str1 then
                var2(refreshConversationUnfilteredThreadsDetails(var4.id, var5))
                return
            end
        end
    end, { var2, var4, var5 })

    local var8 = React.useCallback(function(str1: string, str2: string)
        for _, value in var3 do
            if value.type == ConversationChannels.Type.OneToOne
                and value.participants
                and value.source == ConversationChannels.Source.Friends
                and Cryo.List.find(value.participants, str1)
            then
                var2(ConversationModerationTypeChanged(value.id, str2))
                return
            end
        end
    end, { var2, var3 })

    local var9 = React.useCallback(function(str1: string)
        local tbl2 = {}
        for _, value in var3 do
            if value.participants and Cryo.List.find(value.participants, str1) then
                table.insert(tbl2, value.id)
            end
        end

        if #tbl2 == 0 then
            return
        end
        var2(reloadMessagesForConversations(tbl2))
    end, { var2, var3 })

    RealtimeDelivery.useRealtimeNamespace(TrustedConnections.Namespace, function(arg1)
        local var10 = var1

        local namespace = TrustedConnections.Namespace

        local str1 = tostring(arg1.Actor)

        local str2 = tostring(arg1.Target)

        local eventType = arg1.EventType
        var10:debug(
            "Received Realtime Event " .. namespace .. " -> Actor: " .. str1 .. ", Target: " .. str2 .. ", EventType: " .. tostring(eventType)
        )

        local str3 = tostring(arg1.Actor)
        local str4 = tostring(arg1.Target)

        local eventType2 = arg1.EventType

        if eventType2 == TrustedConnections.EventTypes.TrustedConnectionCreated
            or eventType2 == TrustedConnections.EventTypes.TrustedConnectionDeleted
        then
            if str3 == var6 then
                str3 = str4
            end

            if eventType2 == TrustedConnections.EventTypes.TrustedConnectionCreated then
                var7(str3)
                var8(str3, ConversationChannels.ModerationType.TrustedComms)
            else
                var8(str3, ConversationChannels.ModerationType.Moderated)
            end
            var9(str3)
            return
        end

        if eventType2 ~= TrustedConnections.EventTypes.TrustedConnectionRequestSent then
            var1:debug("EventType: " .. tostring(eventType2) .. " is not suppoprted.")
            return
        end

        if str3 ~= var6 then
            var7(str3)
            return
        end

        if FFlagAppChatConversationTrustedFriendUpsellBanner then
            var7(str4)
        end
    end, {
        var6,
        var7,
        var8,
        var9
    })
end

return useChatTrustedConnectionsEvents
