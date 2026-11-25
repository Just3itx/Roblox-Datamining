-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")

local Constants = require(SquadsCore.Common.Constants)
local EventNames = require(SquadsCore.Analytics.EventNames)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local actOnPartyNudge = require(SquadsCore.Thunks.actOnPartyNudge)
local createConversation = require(SquadsCore.Thunks.createConversation)

local React = require(SquadsCoreParent.React)
local ToastNotification = require(SquadsCoreParent.ToastNotification)
local ToastNotificationsProtocol = require(SquadsCoreParent.ToastNotificationsProtocol)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local useLocalization = require(SquadsCoreParent.Localization).Hooks.useLocalization
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId
local UserProfiles = require(SquadsCoreParent.UserProfiles)
local getStandardSizeAvatarHeadShotRbxthumb = require(SquadsCoreParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum
local ShowNotificationSnoozeMenuSignal = ToastNotification.Signals.ShowNotificationSnoozeMenuSignal
local NotificationGroups = ToastNotification.NotificationGroups

local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

local UserProfileStore = UserProfiles.Stores.UserProfileStore

return function(tbl1)
    local var1 = useDispatch()
    local squadContext = React.useContext(SquadExternalContractContext)
    local num1 = tonumber(useLocalUserId()) or 0

    local var3 = squadContext.useIsChatEnabled()
    local var4 = squadContext.useIsLoadingChatSettings()

    local var5 = useLocalization({
        YouJoinedFriendParty = "Feature.Squads.Label.YouJoinedFriendParty",
        FriendJoinedYourParty = "Feature.Squads.Label.FriendJoinedYourParty",
        snoozeTitle = "Feature.Chat.Label.SnoozePartyNotifications",
        snoozeDescription = "Feature.Chat.Description.SnoozeDescription"
    })

    local var6 = React.useRef({})

    local var7 = React.useCallback(function(arg1, arg2)
        if arg1 == 0 or arg2 == 0 then
            return
        end

        local var7 = nil
        if arg1 == num1 then
            var7 = arg2
        elseif arg2 == num1 then
            var7 = arg1
        end

        if not var7 then
            return
        end

        local icon = getStandardSizeAvatarHeadShotRbxthumb(tostring(var7))
        UserProfileStore.get().fetchNamesByUserIds({ tostring(var7) }, function(arg3)
            if not (#arg3.data > 0) or not arg3.data[1] or not arg3.data[1].names then
                return
            end

            local combinedName = arg3.data[1].names.getCombinedName(false)
            if arg1 == num1 then
                GuiService:SendNotification(
                    {
                        Title = var5.FriendJoinedYourParty:gsub("{(.-)}", { combinedName = combinedName }),
                        Icon = icon
                    }
                )
                return
            end

            GuiService:SendNotification(
                {
                    Title = var5.YouJoinedFriendParty:gsub("{(.-)}", { combinedName = combinedName }),
                    Icon = icon
                }
            )
        end)
    end, { num1, var5.FriendJoinedYourParty, var5.YouJoinedFriendParty })

    RealtimeDelivery.useRealtimeNamespace(Constants.PARTY_NUDGE_RTN_NAMESPACE, function(arg1)
        if arg1.nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE
            and arg1.status == Constants.PARTY_INVITE_ACCEPTED_STATUS
            and arg1.inviterId == num1
            and tbl1.currentSquadId ~= ""
            and arg1.groupUpId == tbl1.currentSquadId
        then
            var7(arg1.inviterId, arg1.inviteeId)
        end
    end, { num1, tbl1.currentSquadId, var7 })

    local var8 = React.useCallback(function(str1: string, toastAction: string)
        squadContext.fireSquadAnalytics(EventNames.SquadToastActions, {
            toastAction = toastAction,
            toastType = if var6.current[str1] then var6.current[str1].toastType else nil,
            nudgeId = if var6.current[str1] then var6.current[str1].nudgeId else nil,
            nudgeType = if var6.current[str1] then var6.current[str1].nudgeType else nil,
            partyAttemptId = if var6.current[str1] then var6.current[str1].partyAttemptId else nil,
            squadLocation = squadContext.squadLocation
        })
    end, { squadContext.fireSquadAnalytics, squadContext.squadLocation })

    React.useEffect(function()
        local var9 = default:listenToDismissNotification(function(arg1)
            if arg1.notificationId and var6.current[arg1.notificationId] then
                var8(arg1.notificationId, SquadToastActionsAndStates.PartyNudgeGeneralDismiss)

                if var6.current[arg1.notificationId].shouldActWhenDismiss then
                    local var9 = var6.current[arg1.notificationId]
                    local nudgeType = var9.nudgeType
                    local toastType = var9.toastType
                    if nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE then
                        local var10 = nil
                        if toastType == NotificationTypeEnum.SquadNudgeInvite then
                            var10 = Constants.REJECT_PARTY_INVITE_ACTION
                        elseif toastType == NotificationTypeEnum.SquadStartPartyPrompt then
                            var10 = Constants.REJECT_START_PARTY_REQUEST_ACTION
                        end

                        if var10 then
                            var1(
                                actOnPartyNudge(
                                    var10,
                                    var9.nudgeId,
                                    false,
                                    squadContext.setSquadPrompt,
                                    squadContext.fireSquadAnalytics,
                                    squadContext.squadLocation,
                                    var3
                                )
                            )
                        end
                    end
                end
            end

            var6.current[arg1.notificationId] = nil
        end)

        return function()
            if var9 then
                var9:Disconnect()
            end
        end
    end, {
        var8,
        var3,
        squadContext.setSquadPrompt,
        squadContext.fireSquadAnalytics,
        squadContext.squadLocation
    })

    React.useEffect(function()
        local var9 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadStartPartyPrompt,
            function(arg1)
                if arg1
                    and arg1.userActionType == "click"
                    and arg1.notificationData
                    and arg1.visualItem
                    and arg1.visualItem.visualItemName == "SnoozeSingleMetaAction"
                then
                    ShowNotificationSnoozeMenuSignal:fire({
                        context = "Toast",
                        description = var5.snoozeDescription,
                        notificationType = NotificationGroups.SquadStartPartyPromptGroup,
                        title = var5.snoozeTitle
                    })
                end

                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                    or not arg1.visualItem.visualItemName
                    or arg1.visualItem.visualItemName ~= Constants.START_PARTY_FROM_PROMPT_BUTTON_TYPE
                        and arg1.visualItem.visualItemName ~= Constants.DISMISS_START_PARTY_PROMPT_BUTTON_TYPE
                then
                    return
                end

                local id = arg1.notificationData.id
                if var6.current[id] then
                    var6.current[id].shouldActWhenDismiss = false
                end

                if not (var4 or var3) then
                    default:dismissNotification(id)
                    return
                end

                local var9 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)
                if var9.nudgeType ~= Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE
                    or game.JobId == ""
                    or var9.gameInstanceId ~= game.JobId
                then
                    return
                end

                if arg1.visualItem.visualItemName ~= Constants.START_PARTY_FROM_PROMPT_BUTTON_TYPE then
                    if arg1.visualItem.visualItemName == Constants.DISMISS_START_PARTY_PROMPT_BUTTON_TYPE then
                        var8(id, SquadToastActionsAndStates.PartyNudgeButtonDismiss)
                        var1(
                            actOnPartyNudge(
                                Constants.REJECT_START_PARTY_REQUEST_ACTION,
                                var9.nudgeId,
                                false,
                                squadContext.setSquadPrompt,
                                squadContext.fireSquadAnalytics,
                                squadContext.squadLocation,
                                var3
                            )
                        )
                    end

                    return
                end

                default:dismissNotification(id)
                var8(id, SquadToastActionsAndStates.PartyNudgeAccept)
                local var10 = var1
                local var11 = createConversation
                local tbl2 = {
                    conversationType = "one_to_one",
                    userIds = { tostring(var9.inviteeUserId) },
                    source = Constants.START_PARTY_FROM_PROMPT_BUTTON_TYPE,
                    squadContext = squadContext,
                    onSuccessCallback = 0,
                    onErrorCallback = 0
                }

                function tbl2.onSuccessCallback(currentParentChannelId)
                    var1(
                        actOnPartyNudge(
                            Constants.ACCEPT_START_PARTY_REQUEST_ACTION,
                            var9.nudgeId,
                            not (tbl1.currentParentChannelId == "") and tbl1.currentParentChannelId ~= currentParentChannelId,
                            squadContext.setSquadPrompt,
                            squadContext.fireSquadAnalytics,
                            squadContext.squadLocation,
                            var3,
                            if var6.current[id] then var6.current[id].partyAttemptId else nil,
                            currentParentChannelId
                        )
                    )
                end

                function tbl2.onErrorCallback()
                    var1(
                        actOnPartyNudge(
                            Constants.REJECT_START_PARTY_REQUEST_ACTION,
                            var9.nudgeId,
                            false,
                            squadContext.setSquadPrompt,
                            squadContext.fireSquadAnalytics,
                            squadContext.squadLocation,
                            var3
                        )
                    )
                end

                var10(var11(tbl2))
            end
        )

        local var10 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadNudgeInvite,
            function(arg1)
                if arg1
                    and arg1.userActionType == "click"
                    and arg1.notificationData
                    and arg1.visualItem
                    and arg1.visualItem.visualItemName == "SnoozeSingleMetaAction"
                then
                    ShowNotificationSnoozeMenuSignal:fire({
                        context = "Toast",
                        description = var5.snoozeDescription,
                        notificationType = NotificationGroups.SquadNudgeInviteGroup,
                        title = var5.snoozeTitle
                    })
                end

                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                    or not arg1.visualItem.visualItemName
                    or arg1.visualItem.visualItemName ~= Constants.JOIN_SQUAD_FROM_NUDGE_BUTTON_TYPE
                        and arg1.visualItem.visualItemName ~= Constants.DISMISS_SQUAD_NUDGE_BUTTON_TYPE
                then
                    return
                end

                local id = arg1.notificationData.id
                if var6.current[id] then
                    var6.current[id].shouldActWhenDismiss = false
                end

                if not (var4 or var3) then
                    default:dismissNotification(id)
                    return
                end

                local var10 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)
                if var10.nudgeType ~= Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE then
                    return
                end

                local var11 = nil
                local bool1 = false
                if arg1.visualItem.visualItemName == Constants.JOIN_SQUAD_FROM_NUDGE_BUTTON_TYPE then
                    var11 = Constants.ACCEPT_PARTY_INVITE_ACTION
                    default:dismissNotification(id)
                    var8(id, SquadToastActionsAndStates.PartyNudgeAccept)
                    if tbl1.currentSquadId == "" then
                        bool1 = false
                    else
                        bool1 = var10.squadId ~= tbl1.currentSquadId
                    end
                elseif arg1.visualItem.visualItemName == Constants.DISMISS_SQUAD_NUDGE_BUTTON_TYPE then
                    var11 = Constants.REJECT_PARTY_INVITE_ACTION
                    var8(id, SquadToastActionsAndStates.PartyNudgeButtonDismiss)
                end

                if not var11 then
                    return
                end

                local var12 = var1
                local var13 = actOnPartyNudge
                local var14 = var11
                local nudgeId = var10.nudgeId

                local setSquadPrompt = squadContext.setSquadPrompt
                local fireSquadAnalytics = squadContext.fireSquadAnalytics
                local squadLocation = squadContext.squadLocation
                local var15 = var3
                local partyAttemptId = if var6.current[id] then var6.current[id].partyAttemptId else nil

                var12(var13(var14, nudgeId, bool1, setSquadPrompt, fireSquadAnalytics, squadLocation, var15, partyAttemptId)):andThen(
                    function()
                        if var11 == Constants.ACCEPT_PARTY_INVITE_ACTION then
                            var7(tonumber(var10.inviterUserId) or 0, tonumber(var10.inviteeUserId) or 0)
                        end
                    end
                )
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
        var8,
        var3,
        squadContext,
        var4,
        squadContext.setSquadPrompt,
        squadContext.fireSquadAnalytics,
        squadContext.squadLocation,
        tbl1.currentSquadId,
        tbl1.currentParentChannelId,
        var7,
        var5.snoozeTitle,
        var5.snoozeDescription
    })

    React.useEffect(function()
        local var9 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.SquadStartPartyPrompt,
            function(arg1)
                local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
                local id = arg1.id
                if not (var4 or var3) then
                    default:dismissNotification(id)
                    return
                end

                local bool1 = false
                local bool2 = true
                local bool3 = true
                local var9 = HttpService:JSONDecode(actionEventParams)
                if var9.nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE then
                    if tbl1.currentSquadId ~= "" then
                        bool1 = true
                    elseif game.JobId == "" or var9.gameInstanceId ~= game.JobId then
                        bool2 = false
                        bool3 = false
                        bool1 = true
                    end
                end

                if bool2 then
                    var6.current[id] = {
                        toastType = arg1.notificationType,
                        partyAttemptId = HttpService:GenerateGUID(false),
                        shouldActWhenDismiss = bool3,
                        nudgeId = var9.nudgeId,
                        nudgeType = var9.nudgeType
                    }

                    var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
                end

                if bool1 then
                    default:dismissNotification(id)
                end
            end
        )

        local var10 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.Display, NotificationTypeEnum.SquadNudgeInvite, function(arg1)
            local actionEventParams = arg1.state.visualItems.button[1].actionEventParams
            local id = arg1.id
            if not (var4 or var3) then
                default:dismissNotification(id)
                return
            end

            local var10 = HttpService:JSONDecode(actionEventParams)
            if var10.nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE
                and tbl1.currentSquadId ~= ""
                and tbl1.currentSquadId == var10.squadId
            then
                default:dismissNotification(id)
                return
            end

            var6.current[id] = {
                toastType = arg1.notificationType,
                partyAttemptId = HttpService:GenerateGUID(false),
                shouldActWhenDismiss = true,
                nudgeId = var10.nudgeId,
                nudgeType = var10.nudgeType
            }

            var8(id, SquadToastActionsAndStates.PartyNudgeDisplay)
        end)

        return function()
            if var9 then
                var9()
            end

            if var10 then
                var10()
            end
        end
    end, {
        var3,
        var8,
        var4,
        tbl1.currentSquadId
    })
    React.useEffect(function()
        if tbl1.currentSquadId == "" then
            return
        end

        for value, value2 in var6.current do
            if value2
                and value2.nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE
                and value2.toastType == NotificationTypeEnum.SquadStartPartyPrompt
            then
                default:dismissNotification(value)
            end
        end
    end, { tbl1.currentSquadId })

    return nil
end
