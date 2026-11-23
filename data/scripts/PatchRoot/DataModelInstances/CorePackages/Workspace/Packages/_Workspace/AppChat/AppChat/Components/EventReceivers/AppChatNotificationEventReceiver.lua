-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local EventNames = require(AppChat.Analytics.EventNames)
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local useRealtimePlatformChat = require(script.Parent.useRealtimePlatformChat)
local useUnreadMessagesDispatch = require(AppChat.Contexts.UnreadMessages.useUnreadMessagesDispatch)
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)
local InExperienceAppChatModal = require(AppChat.App.InExperienceAppChatModal)

local GetUnreadMessageCountStore = require(AppChat.Stores.GetUnreadMessageCountStore)

local var1 = require(AppChat.Logger):new(script.Name)

return React.memo(function(tbl1) -- name: AppChatNotificationEventReceiver
    local var2 = useAnalytics()

    local var3 = useUnreadMessagesDispatch()
    local var4 = useDispatch()
    local var5 = useSignalState(GetUnreadMessageCountStore(false).getUnreadMessageCount)

    local var6 = useChatIsVisible()
    local var7, var8 = React.useState(function()
        return InExperienceAppChatModal:getVisible()
    end)

    React.useEffect(function()
        local connection = InExperienceAppChatModal.default.visibilitySignal.Event:Connect(var8)
        var8(InExperienceAppChatModal:getVisible())
        return function()
            connection:Disconnect()
        end
    end, {})

    if not tbl1.isInExperience then
        var7 = var6
    end

    React.useEffect(function()
        var1:debug("Fetching conversation metadata to get unread count")

        var4(AppChatNetworking.rodux.GetConversationMetadata.API()):andThen(function(arg1)
            local globalUnreadMessageCount = arg1.responseBody.global_unread_message_count
            var1:info("Initial unread message count: {}", globalUnreadMessageCount)

            if tbl1.isInExperience then
                InExperienceAppChatModal:markInitialUnreadCountReceived(globalUnreadMessageCount or 0)
            end

            var2.fireAnalyticsEvent(EventNames.preloadSocialTabDataEvent, { unreadConversationCount = globalUnreadMessageCount })
        end):catch(function(arg1)
            var1:error("Failure in GetConversationMetadata. Error: {}", tostring(arg1))
            var2.fireAnalyticsEvent(EventNames.preloadSocialTabDataFailedEvent, {})
        end)
    end, { var4, var2 })

    React.useEffect(function()
        var1:info("Dispatching unread messsage count as {}", var5)
        var3(var5)
    end, { var3, var5 })

    useRealtimePlatformChat(function(arg1)
        if arg1.Type ~= "ChannelMetadataUpdated" and arg1.Type ~= "ChannelMarkedRead" then
            return
        end

        var1:info("Received event {}, fetching conversation metadata to get unread count", arg1.Type)

        if var7 then
            var1:info("Chat tab is visible during realtime event, calling clear endpoint")
            var4(AppChatNetworking.rodux.ClearGlobalUnreadCount.API()):catch(function(arg2)
                var1:error("Failure in ClearGlobalUnreadCount. Error: {}", tostring(arg2))
            end)

            return
        end

        var4(AppChatNetworking.rodux.GetConversationMetadata.API()):catch(function(arg2)
            var1:error("Failure in GetConversationMetadata. Error: {}", tostring(arg2))
        end)
    end, { var4, var7 })

    RealtimeDelivery.useRealtimeConnectionStateChanged("CommunicationChannels", function(connectionState, arg1)
        if connectionState ~= Enum.ConnectionState.Connected or not arg1 then
            return
        end

        var1:info("Connection re-established, fetching conversation metadata to get unread count")

        if var7 then
            var1:info("Chat tab is visible during connection recovery, calling clear endpoint")
            var4(AppChatNetworking.rodux.ClearGlobalUnreadCount.API()):catch(function(arg2)
                var1:error("Failure in ClearGlobalUnreadCount. Error: {}", tostring(arg2))
            end)

            return
        end

        var4(AppChatNetworking.rodux.GetConversationMetadata.API()):catch(function(arg2)
            var1:error("Failure in GetConversationMetadata. Error: {}", tostring(arg2))
        end)
    end, { var4, var7 })

    return nil
end)
