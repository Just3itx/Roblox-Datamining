-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local HttpService = game:GetService("HttpService")

local Constants = require(SquadsCore.Common.Constants)
local EventNames = require(SquadsCore.Analytics.EventNames)
local SquadGameJoinOrigin = require(SquadsCore.Enums.SquadGameJoinOrigin)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local actOnPartyNudge = require(SquadsCore.Thunks.actOnPartyNudge)

local ExperienceService = require(SquadsCoreParent.ExperienceService)
local React = require(SquadsCoreParent.React)
local ToastNotification = require(SquadsCoreParent.ToastNotification)
local ToastNotificationsProtocol = require(SquadsCoreParent.ToastNotificationsProtocol)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch

local ExperienceService2 = ExperienceService.ExperienceService
local GameParams = ExperienceService.GameParams

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum

local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

return function(tbl1)
    local var1 = useDispatch()
    local var2 = React.useContext(SquadExternalContractContext)

    local var3 = var2.useIsChatEnabled()
    local var4 = var2.useIsLoadingChatSettings()

    local var5 = React.useRef({})

    local var6 = React.useCallback(function(str1: string): boolean
        if var4 or var3 then
            return false
        end

        default:dismissNotification(str1)
        return true
    end, { var4, var3 })

    local var7 = React.useCallback(function(str1: string, arg1, arg2)
        var5.current[str1] = {
            toastType = arg1.notificationType,
            partyAttemptId = HttpService:GenerateGUID(false),
            shouldActWhenDismiss = true,
            nudgeId = arg2.nudgeId,
            nudgeType = arg2.nudgeType
        }
    end, {})

    local var8 = React.useCallback(function(str1: string, toastAction: string)
        var2.fireSquadAnalytics(EventNames.SquadToastActions, {
            toastAction = toastAction,
            toastType = if var5.current[str1] then var5.current[str1].toastType else nil,
            nudgeId = if var5.current[str1] then var5.current[str1].nudgeId else nil,
            nudgeType = if var5.current[str1] then var5.current[str1].nudgeType else nil,
            partyAttemptId = if var5.current[str1] then var5.current[str1].partyAttemptId else nil,
            squadLocation = var2.squadLocation
        })
    end, { var2.fireSquadAnalytics, var2.squadLocation })

    React.useEffect(function()
        local var9 = default:listenToDismissNotification(function(arg1)
            if arg1.notificationId and var5.current[arg1.notificationId] then
                var8(arg1.notificationId, SquadToastActionsAndStates.PartyNudgeGeneralDismiss)

                if var5.current[arg1.notificationId].shouldActWhenDismiss then
                    local var9 = var5.current[arg1.notificationId]
                    local nudgeType = var9.nudgeType
                    local toastType = var9.toastType

                    if (nudgeType == Constants.PARTY_TO_ONE_NUDGE_TYPE or nudgeType == Constants.PARTY_TO_PARTY_NUDGE_TYPE)
                        and toastType == NotificationTypeEnum.SquadNudgeInvite
                    then
                        local rejectPartyInviteAction = Constants.REJECT_PARTY_INVITE_ACTION
                        var1(
                            actOnPartyNudge(
                                rejectPartyInviteAction,
                                var9.nudgeId,
                                false,
                                var2.setSquadPrompt,
                                var2.fireSquadAnalytics,
                                var2.squadLocation,
                                var3
                            )
                        )
                    end
                end
            end

            var5.current[arg1.notificationId] = nil
        end)

        return function()
            if var9 then
                var9:Disconnect()
            end
        end
    end, {
        var8,
        var3,
        var2.setSquadPrompt,
        var2.fireSquadAnalytics,
        var2.squadLocation
    })

    React.useEffect(function()
        local var9 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadNudgeInvite,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                    or not arg1.visualItem.visualItemName
                then
                    return
                end
                local id = arg1.notificationData.id
                if var5.current[id] then
                    var5.current[id].shouldActWhenDismiss = false
                end

                if var6(id) then
                    return
                end

                local var9 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)

                if var9.nudgeType ~= Constants.PARTY_TO_ONE_NUDGE_TYPE and var9.nudgeType == Constants.PARTY_TO_PARTY_NUDGE_TYPE then
                end
            end
        )

        local var10 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.NudgeForInviterSquad,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                    or not arg1.visualItem.visualItemName
                then
                    return
                end
                local id = arg1.notificationData.id
                if var5.current[id] then
                    var5.current[id].shouldActWhenDismiss = false
                end

                if var6(id) then
                    return
                end

                local var10 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)

                if var10.nudgeType ~= Constants.PARTY_TO_ONE_NUDGE_TYPE and var10.nudgeType ~= Constants.PARTY_TO_PARTY_NUDGE_TYPE then
                    return
                end

                if arg1.visualItem.visualItemName == Constants.JOIN_EXPERIENCE_FROM_NUDGE_BUTTON_TYPE then
                    default:dismissNotification(id)
                    var8(id, SquadToastActionsAndStates.PartyNudgeAccept)

                    local placeId = GameParams.fromPlaceId(var10.placeId)
                    ExperienceService2:LaunchExperience(placeId, SquadGameJoinOrigin.NudgeForInviterSquad, nil)
                    return
                end

                if arg1.visualItem.visualItemName == Constants.DISMISS_INVITER_SQUAD_NUDGE_BUTTON_TYPE then
                    var8(id, SquadToastActionsAndStates.PartyNudgeButtonDismiss)
                end
            end
        )

        return function()
            if var9 then
                var9()
            end

            if var10 then
                var10()
            end
        end
    end, {
        var6,
        var8,
        var2,
        var2.setSquadPrompt,
        var2.fireSquadAnalytics,
        var2.squadLocation,
        tbl1.currentSquadId
    })

    React.useEffect(function()
        local var9 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.Display, NotificationTypeEnum.SquadNudgeInvite, function(arg1)
            local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
            local id = arg1.id

            if var6(id) then
                return
            end

            local var9 = HttpService:JSONDecode(actionEventParams)

            if (var9.nudgeType == Constants.PARTY_TO_ONE_NUDGE_TYPE or var9.nudgeType == Constants.PARTY_TO_PARTY_NUDGE_TYPE)
                and tbl1.currentSquadId ~= ""
                and tbl1.currentSquadId == var9.squadId
            then
                default:dismissNotification(id)
                return
            end

            var7(id, arg1, var9)
            var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
        end)

        local var10 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.NudgeForInviterSquad,
            function(arg1)
                local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
                local id = arg1.id

                if var6(id) then
                    return
                end

                local var10 = HttpService:JSONDecode(actionEventParams)

                if var10.nudgeType == Constants.PARTY_TO_ONE_NUDGE_TYPE or var10.nudgeType == Constants.PARTY_TO_PARTY_NUDGE_TYPE then
                    if var10.gameInstanceId == game.JobId then
                        default:dismissNotification(id)
                        return
                    end
                    if tbl1.currentSquadId == "" or tbl1.currentSquadId ~= var10.squadId then
                        default:dismissNotification(id)
                        return
                    end
                end

                var7(id, arg1, var10)
                var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
            end
        )

        local var11 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.SquadJoinRequestPrompt,
            function(arg1)
                local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
                local id = arg1.id

                if var6(id) then
                    return
                end

                local var11 = HttpService:JSONDecode(actionEventParams)
                var7(id, arg1, var11)
                var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
            end
        )

        local var12 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.SquadAcceptJoinRequest,
            function(arg1)
                local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
                local id = arg1.id

                if var6(id) then
                    return
                end

                local var12 = HttpService:JSONDecode(actionEventParams)
                var7(id, arg1, var12)
                var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
            end
        )

        return function()
            if var9 then
                var9()
            end

            if var10 then
                var10()
            end

            if var11 then
                var11()
            end

            if var12 then
                var12()
            end
        end
    end, {
        var6,
        var7,
        var8,
        tbl1.currentSquadId
    })
    return nil
end
