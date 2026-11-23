-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local ToastNotification = require(AppChatParent.ToastNotification)
local UIBlox = require(AppChatParent.UIBlox)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local NotificationSnoozedSignal = ToastNotification.Signals.NotificationSnoozedSignal
local ShowNotificationSnoozeMenuSignal = ToastNotification.Signals.ShowNotificationSnoozeMenuSignal
local default = ToastNotification.ToastNotificationSnoozeManager.default
local ToastNotificationTypeModule = ToastNotification.ToastNotificationTypeModule
local NotificationGroups = ToastNotification.NotificationGroups

local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images

local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local ChatLanding = script:FindFirstAncestor("ChatLanding")
local ChatLandingTelemetryEvents = require(ChatLanding.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)

local FFlagAppChatToastChatTerminologyFixEnabled = require(AppChatParent.SharedFlags).FFlagAppChatToastChatTerminologyFixEnabled

local function SnoozeToastNotificationsButton(tbl1)
    local var1 = useLocalization({
        chat = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "CommonUI.Features.Label.Chat" else "Feature.Squads.Label.Party",
        snoozeDescription = "Feature.Chat.Description.SnoozeDescription",
        snoozeTitle = if FFlagAppChatToastChatTerminologyFixEnabled then if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Label.MuteInGameChatToastNotifications" else "Feature.Chat.Label.MuteInGamePartyToastNotifications" else "Feature.Chat.Label.MuteInGameChatToastNotifications",
        unmuteFeedback = "Feature.Notifications.Heading.RemoveSnoozeFeedback"
    })

    local isChatNotificationsMuted, var3 = React.useState(default:isSnoozedNotificationType(ToastNotificationTypeModule.NotificationTypeEnum.ChatNewMessage))

    React.useEffect(function()
        local connection = NotificationSnoozedSignal:connect(function(tbl2)
            if tbl2.notificationType == ToastNotificationTypeModule.NotificationTypeEnum.ChatNewMessage then
                var3(tbl2.actionType == ToastNotificationTypeModule.SnoozeActionEnum.Mute)
            end
        end)

        return function()
            connection:disconnect()
        end
    end, {})

    local var4 = useTelemetry(ChatLandingTelemetryLayer.Context)

    local createElement = React.createElement
    local var5 = IconButton
    local tbl2 = {
        size = tbl1.size,
        icon = if isChatNotificationsMuted then Images["icons/common/snoozeNotificationsOn"] else Images["icons/common/snoozeNotificationsOff"],
        layoutOrder = tbl1.layoutOrder,
        onActivated = 0
    }

    function tbl2.onActivated()
        if isChatNotificationsMuted then
            local modalMessage = var1.unmuteFeedback:gsub("{title}", var1.chat)
            default:unmuteNotification({
                notificationType = NotificationGroups.ChatLandingNotificationsGroup,
                modalMessage = modalMessage,
                context = "ChatLandingSnoozeToastNotificationsButton"
            })
        else
            ShowNotificationSnoozeMenuSignal:fire({
                context = "ChatLandingSnoozeToastNotificationsButton",
                notificationType = NotificationGroups.ChatLandingNotificationsGroup,
                title = var1.snoozeTitle,
                description = var1.snoozeDescription
            })
        end

        var4.emit(
            ChatLandingTelemetryEvents.ChatLandingSnoozeBtnClicked,
            { isChatNotificationsMuted = isChatNotificationsMuted }
        )
    end

    return createElement(var5, tbl2)
end

return SnoozeToastNotificationsButton
