-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local HttpService = game:GetService("HttpService")

local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local ToastNotification = require(AppChatParent.ToastNotification)
local default = require(AppChatParent.ToastNotificationsProtocol).ToastNotificationProtocol.default

local NotificationGroups = ToastNotification.NotificationGroups

local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local shouldHideFriendsChatToast = require(script.Parent.shouldHideFriendsChatToast)

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum
local ShowNotificationSnoozeMenuSignal = ToastNotification.Signals.ShowNotificationSnoozeMenuSignal
local DismissNotificationSnoozeMenuSignal = ToastNotification.Signals.DismissNotificationSnoozeMenuSignal

local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)
local SharedFlags = require(AppChatParent.SharedFlags)
local GetFFlagAppChatInExpToastSnoozeMenuDismissFix = SharedFlags.GetFFlagAppChatInExpToastSnoozeMenuDismissFix
local FFlagAppChatToastChatTerminologyFixEnabled = SharedFlags.FFlagAppChatToastChatTerminologyFixEnabled

local tbl1 = {
    hideAllChatToasts = false,
    isAppChatVisible = false,
    isInExperience = false,
    navigateToChat = function() end
}

return function(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useLocalization({
        snoozeDescription = "Feature.Chat.Description.SnoozeDescription",
        snoozeTitle = if FFlagAppChatToastChatTerminologyFixEnabled then if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Label.MuteInGameChatToastNotifications" else "Feature.Chat.Label.MuteInGamePartyToastNotifications" else "Feature.Chat.Label.MuteInGameChatToastNotifications"
    })
    local var3 = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then var1.isAppChatVisible else var1.hideAllChatToasts
    local var4 = UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTab()

    local var5 = useIsChatEnabled()
    local var6 = var3 or not var5

    React.useEffect(function()
        local var7 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.UserAction, NotificationTypeEnum.ChatNewMessage, function(arg1)
            if arg1
                and arg1.userActionType == "click"
                and arg1.notificationData
                and arg1.visualItem
                and arg1.visualItem.eventName == "ChatMessageBody"
                and arg1.visualItem.actionEventParams
            then
                local var7 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)
                default:dismissNotification(arg1.notificationData.id)
                var1.navigateToChat(var7.conversationId)
            end

            if not arg1
                or arg1.userActionType ~= "click"
                or not arg1.notificationData
                or not arg1.visualItem
                or arg1.visualItem.eventName ~= "ChatMessageSnoozeSingleMetaAction"
            then
                return
            end
            ShowNotificationSnoozeMenuSignal:fire({
                context = "Toast",
                description = var2.snoozeDescription,
                notificationType = NotificationGroups.ChatMessageGroup,
                title = var2.snoozeTitle
            })
        end)

        return function()
            var7()
        end
    end, { var1.navigateToChat, var2 })

    React.useEffect(function()
        local var7 = default:listenToDisplayNotification(function(arg1)
            if arg1.notificationType ~= NotificationTypeEnum.ChatNewMessage then
                return
            end

            local var7 = not (var1.visibleFriendsConversationId == nil) and shouldHideFriendsChatToast(arg1, var1.visibleFriendsConversationId)

            if var6 or not var4 or var7 then
                default:dismissNotification(arg1.notificationId)
            end
        end)

        return function()
            var7:Disconnect()
        end
    end, { var6, var4, var1.visibleFriendsConversationId })

    if not GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then
        return
    end

    React.useEffect(function()
        if not var1.isAppChatVisible and DismissNotificationSnoozeMenuSignal then
            DismissNotificationSnoozeMenuSignal:fire()
        end
    end, { var1.isAppChatVisible })
end
