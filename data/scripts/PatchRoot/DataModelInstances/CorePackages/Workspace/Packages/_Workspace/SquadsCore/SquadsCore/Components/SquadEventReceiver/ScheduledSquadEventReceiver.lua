-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local HttpService = game:GetService("HttpService")

local Constants = require(SquadsCore.Common.Constants)
local createOrJoinSquad = require(SquadsCore.Thunks.createOrJoinSquad)
local GetScheduledSquadsStore = require(SquadsCore.Stores.GetScheduledSquadsStore)
local EventNames = require(SquadsCore.Analytics.EventNames)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)
local SquadToastType = require(SquadsCore.Enums.SquadToastType)

local React = require(SquadsCoreParent.React)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local ToastNotification = require(SquadsCoreParent.ToastNotification)
local ToastNotificationsProtocol = require(SquadsCoreParent.ToastNotificationsProtocol)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum

local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

local function SquadScheduledSquadEventReceiver()
    local var1 = useDispatch()
    local var2 = React.useContext(SquadExternalContractContext)
    local var3 = var2.useIsChatEnabled()

    React.useEffect(function()
        local var4 = default:listenToDisplayNotification(function(arg1)
            if (arg1.notificationType == NotificationTypeEnum.ScheduledSquadHappeningNow
                or arg1.notificationType == NotificationTypeEnum.ScheduledSquadReminder)
                and not var3
            then
                default:dismissNotification(arg1.notificationId)
            end
        end)

        return function()
            var4:Disconnect()
        end
    end, { var3 })

    React.useEffect(function()
        local var4 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.ScheduledSquadHappeningNow,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                    or arg1.visualItem.visualItemName ~= Constants.JOIN_SQUAD
                then
                    return
                end
                local var4 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)

                var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                    parentChannelId = var4.parentChannelId,
                    toastAction = SquadToastActionsAndStates.ScheduledSquadHappeningNowJoinParty,
                    toastType = SquadToastType.ScheduledSquadHappeningNow
                })
                local var5 = var1
                local var6 = createOrJoinSquad
                local parentChannelId = var4.parentChannelId
                local setSquadPrompt = var2.setSquadPrompt
                local fireSquadAnalytics = var2.fireSquadAnalytics
                local squadLocation = var2.squadLocation
                local str1 = HttpService:GenerateGUID(false)
                var5(var6(parentChannelId, setSquadPrompt, fireSquadAnalytics, squadLocation, str1, function() end, tostring(var4.scheduledGroupUpId)))
            end
        )

        return function()
            var4()
        end
    end, {
        var1,
        var2.setSquadPrompt,
        var2.fireSquadAnalytics,
        var2.squadLocation
    })

    RealtimeDelivery.useRealtimeNamespace(Constants.COMMUNICATION_CHANNEL_RTN_NAMESPACE, function(arg1)
        if arg1.Type ~= Constants.SCHEDULED_GROUP_UP_CHANGED_RTN_TYPE then
            return
        end

        local scheduledSquadsStore = GetScheduledSquadsStore(false)
        for _, scheduledGroupUpId in ipairs(arg1.ScheduledGroupUpIds) do
            scheduledSquadsStore.fetchAndCacheScheduledSquadStatus(scheduledGroupUpId)
        end
    end, {})
end

return SquadScheduledSquadEventReceiver
