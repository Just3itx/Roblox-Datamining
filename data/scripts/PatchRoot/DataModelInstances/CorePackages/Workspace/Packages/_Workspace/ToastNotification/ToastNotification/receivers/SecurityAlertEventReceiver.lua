-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local GetFFlagGenerateLinkWithChannel = require(scriptParentParentParent.SharedFlags).GetFFlagGenerateLinkWithChannel
local WebViewServiceWrapper = require(scriptParentParent.utils.WebViewServiceWrapper)

local React = require(scriptParentParentParent.React)

local UrlBuilder = require(scriptParentParentParent.UrlBuilder).UrlBuilder
local LifecycleEvents = require(scriptParentParent.utils.LifecycleEvents)
local NotificationTypeEnum = require(scriptParentParent.type).NotificationTypeEnum
local default = require(scriptParentParentParent.ToastNotificationsProtocol).ToastNotificationProtocol.default
local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization

local function SecurityEventReceiver()
    React.useEffect(function()
        local var1 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.UserAction, NotificationTypeEnum.SecurityAlert, function(arg1)
            if not (arg1
                and arg1.notificationData
                and arg1.notificationData.notificationType
                and arg1.notificationData.clientEventsPayload
                and arg1.notificationData.clientEventsPayload.payload
                and arg1.notificationData.clientEventsPayload.username) then
                return
            end

            local payload = arg1.notificationData.clientEventsPayload.payload
            local username = arg1.notificationData.clientEventsPayload.username
            local url = if GetFFlagGenerateLinkWithChannel() then UrlBuilder.static.securityAlertWithChannel({ payload = payload, username = username, channel = "toast" }) else UrlBuilder.static.securityAlert({ payload = payload, username = username })
            local title = Localization.new(LocalizationService.RobloxLocaleId):Format("Feature.SecurityFeedback.Header.NewLogin")

            WebViewServiceWrapper.new({ title = title, url = url }):open()

            default:dismissNotification(arg1.notificationData.id)
        end)

        return function()
            var1()
        end
    end, {})
end

return SecurityEventReceiver
