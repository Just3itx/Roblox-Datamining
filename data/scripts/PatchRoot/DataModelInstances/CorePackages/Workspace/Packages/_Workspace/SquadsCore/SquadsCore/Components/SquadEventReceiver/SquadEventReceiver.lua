-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ExperienceService = require(SquadsCoreParent.ExperienceService).ExperienceService

local SquadAppChatEventReceiver = require(script.Parent.SquadAppChatEventReceiver)
local SquadExperienceInviteEventReceiver = require(script.Parent.SquadExperienceInviteEventReceiver)
local SquadLifecycleEventReceiver = require(script.Parent.SquadLifecycleEventReceiver)
local SquadRccEventReceiver = require(script.Parent.SquadRccEventReceiver)
local SquadParentChannelEventReceiver = require(script.Parent.SquadParentChannelEventReceiver)
local ScheduledSquadEventReceiver = require(script.Parent.ScheduledSquadEventReceiver)
local SquadStorageEventReceiver = require(script.Parent.SquadStorageEventReceiver)
local SquadNudgeEventReceiver = require(script.Parent.SquadNudgeEventReceiver)
local SquadMemberStatusEventReceiver = require(script.Parent.SquadMemberStatusEventReceiver)
local SquadNudgeEventReceiver_NudgeV1Exp = require(script.Parent.SquadNudgeEventReceiver_NudgeV1Exp)
local SquadRegroupPromptEventReceiver = require(script.Parent.SquadRegroupPromptEventReceiver)

local CurrentSquadUpdated = require(SquadsCore.RoduxSquads).Actions.CurrentSquadUpdated
local EventNames = require(SquadsCore.Analytics.EventNames)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadCoplayJoin = require(SquadsCore.Enums.SquadCoplayJoin)
local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadRootViewType = require(SquadsCore.Enums.SquadRootViewType)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)
local SquadToastType = require(SquadsCore.Enums.SquadToastType)
local joinSquad = require(SquadsCore.Thunks.joinSquad)
local leaveSquad = require(SquadsCore.Thunks.leaveSquad)
local logInExpCoplayTelemetry = require(SquadsCore.Analytics.logInExpCoplayTelemetry)
local useOnSquadEnded = require(SquadsCore.Hooks.useOnSquadEnded)
local useCrossExperienceVoiceConnector = require(SquadsCore.Hooks.useCrossExperienceVoiceConnector)
local RegroupPromptNotificationState = require(SquadsCore.Utils.RegroupPromptNotificationState)

local CrossExperienceVoice = require(SquadsCoreParent.CrossExperienceVoice)
local CrossExperienceVoiceManager = CrossExperienceVoice.CrossExperienceVoiceManager
local React = require(SquadsCoreParent.React)
local RoduxSquads = require(SquadsCoreParent.RoduxSquads)
local SharedFlags = require(SquadsCoreParent.SharedFlags)
local SoundManager = require(SquadsCoreParent.SoundManager)
local ToastNotification = require(SquadsCoreParent.ToastNotification)
local ToastNotificationsProtocol = require(SquadsCoreParent.ToastNotificationsProtocol)
local useCrossExperienceVoice = CrossExperienceVoice.Hooks.useCrossExperienceVoice
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffectOnce = require(SquadsCoreParent.RoactUtils).Hooks.useEffectOnce
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

local useCurrentSquadSelector = RoduxSquads.Hooks.useCurrentSquadSelector

local Sounds = SoundManager.Sounds
local SoundManager2 = SoundManager.SoundManager

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local FFlagPartyVoiceBlockSync = SharedFlags.FFlagPartyVoiceBlockSync
local FFlagSquadAppChatRTNFix = SharedFlags.FFlagSquadAppChatRTNFix
local FIntPartyVoiceJoinRequestPulseCheckTimeout = SharedFlags.FIntPartyVoiceJoinRequestPulseCheckTimeout

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled
local FFlagReadAppChatFetchingVariable = SharedFlags.FFlagReadAppChatFetchingVariable
local FFlagEnablePartyNudgeV1_DEV = SharedFlags.FFlagEnablePartyNudgeV1_DEV
local FFlagAppChatNavigateBackIfOSAUnacknowledged = SharedFlags.FFlagAppChatNavigateBackIfOSAUnacknowledged
local FFlagAppChatShowOSAOnPageEntry = SharedFlags.FFlagAppChatShowOSAOnPageEntry
local FFlagEnableSquadRegroupExperimentation = SharedFlags.FFlagEnableSquadRegroupExperimentation
local FFlagEnableSquadRegroupServerCapacityCheck = SharedFlags.FFlagEnableSquadRegroupServerCapacityCheck
local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum
local default2 = ToastNotification.ToastNotificationSnoozeManager.default
local SquadUnifyCoplayExperimentation = require(SquadsCoreParent.SocialExperiments).SquadUnifyCoplayExperimentation

local bool1 = game:DefineFastFlag("LeaveSquadIfChatDisabled", false)

return function()
    local var1 = useDispatch()
    local num1 = tonumber(useLocalUserId()) or 0
    local var2 = React.useContext(SquadExternalContractContext)

    local var3 = var2.useSquadRootView()
    local var4 = var2.useIsChatEnabled()

    local var5 = var2.useIsLoadingChatSettings()

    local var6 = useCurrentSquadSelector()
    local currentSquadId = if var6 then if var6.squadId then var6.squadId else "" else ""
    local var8 = if var6 then if var6.parentChannelId then var6.parentChannelId else "" else ""

    useEffectOnce(function()
        if var6 then
            logInExpCoplayTelemetry(
                currentSquadId,
                var6.members,
                var2.squadLocation,
                SquadCoplayJoin.ExperienceJoin,
                var2.fireSquadAnalytics
            )
        end
    end, {})

    local useEffect = React.useEffect

    local function func1()
        local var9 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadInvitation,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or arg1.visualItem.eventName ~= "JoinSquad"
                    or not arg1.visualItem.actionEventParams
                then
                    return
                end
                var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                    parentChannelId = var8,
                    toastAction = SquadToastActionsAndStates.SquadInviteAccept,
                    toastType = SquadToastType.SquadInvite
                })
                local var9 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)
                default:dismissNotification(arg1.notificationData.id)

                var1(
                    joinSquad(
                        var9.squadId,
                        var2.setSquadPrompt,
                        var2.fireSquadAnalytics,
                        var2.squadLocation,
                        not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var4
                    )
                )
            end
        )

        return function()
            var9()
        end
    end

    local var9 = joinSquad
    local fireSquadAnalytics = var2.fireSquadAnalytics
    local setSquadPrompt = var2.setSquadPrompt
    local squadLocation = var2.squadLocation
    local var10 = if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then var4 else nil
    useEffect(func1, { var8, var1, var9, fireSquadAnalytics, setSquadPrompt, squadLocation, var10 })

    local useEffect2 = React.useEffect

    local function func2()
        local var11 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadInvitationV2,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or not arg1.visualItem.actionEventParams
                then
                    return
                end
                local var11 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)

                if arg1.visualItem.visualItemName == "view" and var2.showGroupOSADialog then
                    default:dismissNotification(arg1.notificationData.id)
                    var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                        parentChannelId = var8,
                        toastAction = SquadToastActionsAndStates.SquadInviteViewOsa,
                        toastType = SquadToastType.SquadInviteV2
                    })

                    var2.showGroupOSADialog(var11.chatId, function()
                        var1(
                            joinSquad(
                                var11.squadId,
                                var2.setSquadPrompt,
                                var2.fireSquadAnalytics,
                                var2.squadLocation,
                                not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var4
                            )
                        )
                    end, function() end)

                    return
                end

                if arg1.visualItem.visualItemName ~= "join" then
                    return
                end

                default:dismissNotification(arg1.notificationData.id)
                var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                    parentChannelId = var8,
                    toastAction = SquadToastActionsAndStates.SquadInviteAccept,
                    toastType = SquadToastType.SquadInviteV2
                })

                var1(
                    joinSquad(
                        var11.squadId,
                        var2.setSquadPrompt,
                        var2.fireSquadAnalytics,
                        var2.squadLocation,
                        not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var4
                    )
                )
            end
        )

        return function()
            var11()
        end
    end

    local var11 = joinSquad
    local fireSquadAnalytics2 = var2.fireSquadAnalytics
    local setSquadPrompt2 = var2.setSquadPrompt
    local showGroupOsaDialog = var2.showGroupOSADialog
    local squadLocation2 = var2.squadLocation
    local var12 = if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then var4 else nil
    useEffect2(
        func2,
        {
            var8,
            var1,
            var11,
            fireSquadAnalytics2,
            setSquadPrompt2,
            showGroupOsaDialog,
            squadLocation2,
            var12
        }
    )

    React.useEffect(function()
        local var13 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.Display, NotificationTypeEnum.SquadInvitation, function(arg1)
            if var4 and not default2:isSnoozedNotificationType(arg1.notificationType) then
                SoundManager2:PlaySound(Sounds.PartyToast.Name)
            end
        end)

        return function()
            if var13 then
                var13()
            end
        end
    end, { var4 })
    React.useEffect(function()
        local var13 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.Display, NotificationTypeEnum.SquadInvitationV2, function(arg1)
            if var4 and not default2:isSnoozedNotificationType(arg1.notificationType) then
                SoundManager2:PlaySound(Sounds.PartyToast.Name)
            end
        end)

        return function()
            if var13 then
                var13()
            end
        end
    end, { var4 })

    React.useEffect(function()
        local var13 = default:listenToDisplayNotification(function(arg1)
            if not arg1 then
                return
            end

            if (arg1.notificationType == NotificationTypeEnum.SquadInvitation
                or arg1.notificationType == NotificationTypeEnum.SquadInvitationV2
                or arg1.notificationType == NotificationTypeEnum.SquadExperienceInvitation
                or arg1.notificationType == NotificationTypeEnum.SquadJoinRequestPrompt
                or arg1.notificationType == NotificationTypeEnum.SquadAcceptJoinRequest)
                and not var4
            then
                default:dismissNotification(arg1.notificationId)
                return
            end
            if num1 <= 0 then
                if arg1.notificationId
                    and (arg1.notificationType == NotificationTypeEnum.SquadInvitation
                        or arg1.notificationType == NotificationTypeEnum.SquadInvitationV2
                        or arg1.notificationType == NotificationTypeEnum.SquadExperienceInvitation)
                then
                    default:dismissNotification(arg1.notificationId)
                end

                return
            end

            if arg1.notificationType ~= NotificationTypeEnum.SquadInvitation
                and arg1.notificationType ~= NotificationTypeEnum.SquadInvitationV2
            then
                return
            end
            local var13 = HttpService:JSONDecode(arg1.lifecycleData)

            if currentSquadId == var13.squadId then
                default:dismissNotification(arg1.notificationId)
            end
        end)

        return function()
            var13:Disconnect()
        end
    end, { currentSquadId, num1, var4 })

    React.useEffect(function()
        local var13 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadJoinRequestPrompt,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or arg1.visualItem.eventName ~= "RequestToJoinParty"
                    or not arg1.visualItem.actionEventParams
                then
                    return
                end
                var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                    parentChannelId = var8,
                    toastAction = SquadToastActionsAndStates.RequestToJoinPartyAccept,
                    toastType = SquadToastType.RequestToJoinParty
                })

                default:dismissNotification(arg1.notificationData.id)
            end
        )

        return function()
            var13()
        end
    end, { var8, var2.fireSquadAnalytics })

    React.useEffect(function()
        local var13 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadAcceptJoinRequest,
            function(arg1)
                if not arg1
                    or arg1.userActionType ~= "click"
                    or not arg1.notificationData
                    or not arg1.visualItem
                    or arg1.visualItem.eventName ~= "AcceptPartyJoinRequest"
                    or not arg1.visualItem.actionEventParams
                then
                    return
                end
                var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                    parentChannelId = var8,
                    toastAction = SquadToastActionsAndStates.AcceptPartyJoinRequestAccept,
                    toastType = SquadToastType.AcceptPartyJoinRequest
                })

                default:dismissNotification(arg1.notificationData.id)
            end
        )

        return function()
            var13()
        end
    end, { var8, var2.fireSquadAnalytics })

    if GetFFlagEnableCrossExpVoice() and FFlagPartyVoiceBlockSync then
        local var13 = React.useCallback(function(arg1)
            return arg1.Squad.UserBlocking.isBlockedByMe
        end, {})

        local current = useSelector(var13)

        local var15 = React.useRef({})
        React.useEffect(function()
            if var15.current == current then
                return
            end

            for k, value in pairs(current) do
                local var16 = var15.current[k] or false
                if value and not var16 then
                    CrossExperienceVoiceManager.default:blockVoiceParticipant(k)
                elseif not value and var16 then
                    CrossExperienceVoiceManager.default:unblockVoiceParticipant(k)
                end
            end

            var15.current = current
        end, { current })
    end

    if GetFFlagEnableCrossExpVoice() then
        if FIntPartyVoiceJoinRequestPulseCheckTimeout > 0 then
            useCrossExperienceVoice({ handleRCCConnectionTimeout = true })
        else
            useCrossExperienceVoice()
        end

        local var13 = useCrossExperienceVoiceConnector()
        useOnSquadEnded(function()
            var13()
        end)
    end

    local useEffect3 = React.useEffect

    local function func3()
        if FFlagReadAppChatFetchingVariable and var5 or var4 or currentSquadId == "" then
            return
        end
        if bool1 then
            var1(
                leaveSquad(
                    nil,
                    var2.setSquadPrompt,
                    nil,
                    var2.squadLocation,
                    not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var4
                )
            )
            return
        end

        var1(CurrentSquadUpdated(nil))
    end

    local var13 = if FFlagReadAppChatFetchingVariable then var5 else nil
    local setSquadPrompt3 = if bool1 then var2.setSquadPrompt else nil
    local squadLocation3 = if bool1 then var2.squadLocation else nil
    useEffect3(func3, { var4, currentSquadId, var13, setSquadPrompt3, squadLocation3 })

    if FFlagAppChatNavigateBackIfOSAUnacknowledged and not FFlagAppChatShowOSAOnPageEntry then
        local var14 = var2.useGetConversationFromId(var8)
        local var15 = var2.shouldShowOSAForConversation(var14)

        React.useEffect(function()
            if var15 and currentSquadId ~= "" then
                var1(leaveSquad(nil, var2.setSquadPrompt, nil, var2.squadLocation, true))
            end
        end, {
            var15,
            currentSquadId,
            var2.setSquadPrompt,
            var2.squadLocation
        })
    end

    local bool2 = not FFlagEnableSquadRegroupServerCapacityCheck or Players.MaxPlayers > 1

    local var14 = FFlagEnableSquadRegroupExperimentation

    if var14 then
        if var2.squadLocation == SquadLocationEnum.InExperience then
            var14 = bool2 and var6 and var6.selfPermissions and var6.selfPermissions.canSeeRegroupPromptToast and #var6.members > 1
        else
            var14 = false
        end
    end

    React.useEffect(function()
        if not FFlagEnableSquadRegroupExperimentation then
            return function() end
        end

        local var15 = ExperienceService:RegisterForExperienceLeave(function()
            local activeNotifId = RegroupPromptNotificationState.getActiveNotifId()
            RegroupPromptNotificationState.dismissNotification(activeNotifId)
        end)

        return function()
            if var15 and var15.Disconnect then
                var15:Disconnect()
            end
        end
    end, {})

    React.useEffect(function()
        if not FFlagEnableSquadRegroupExperimentation then
            return
        end

        local activeNotifId = RegroupPromptNotificationState.getActiveNotifId()
        local activeSquadId = RegroupPromptNotificationState.getActiveSquadId()
        if activeNotifId ~= nil and currentSquadId ~= activeSquadId then
            RegroupPromptNotificationState.dismissNotification(activeNotifId)
        end
    end, { currentSquadId })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var15 = nil
    local tbl1 = {
        SquadLifecycleEventReceiver = React.createElement(SquadLifecycleEventReceiver, { currentSquadId = currentSquadId }),
        SquadParentChannelEventReceiver = if var6 then React.createElement(SquadParentChannelEventReceiver, { currentParentChannelId = var6.parentChannelId }) else nil,
        SquadMemberStatusEventReceiver = if (SquadUnifyCoplayExperimentation.getOneOnOnePartyCreationEnabled()
            or SquadUnifyCoplayExperimentation.getMultiInvitePartyCreationEnabled())
            and var2.squadLocation == SquadLocationEnum.InExperience then React.createElement(SquadMemberStatusEventReceiver) else nil,
        SquadAppChatEventReceiver = if FFlagSquadAppChatRTNFix or var3 == SquadRootViewType.None then nil else React.createElement(SquadAppChatEventReceiver, { conversationId = if var6 then var6.parentChannelId else nil }),
        SquadExperienceInviteEventReceiver = React.createElement(SquadExperienceInviteEventReceiver, { currentSquadId = currentSquadId }),
        SquadRccEventReceiver = if var2.squadLocation == SquadLocationEnum.InExperience then React.createElement(SquadRccEventReceiver, { currentSquadId = currentSquadId }) else nil,
        SquadStorageEventReceiver = React.createElement(SquadStorageEventReceiver),
        SquadNudgeEventReceiver = React.createElement(
            if FFlagEnablePartyNudgeV1_DEV then SquadNudgeEventReceiver_NudgeV1Exp else SquadNudgeEventReceiver,
            { currentSquadId = currentSquadId, currentParentChannelId = var8 }
        ),
        ScheduledSquadEventReceiver = React.createElement(ScheduledSquadEventReceiver),
        SquadRegroupPromptEventReceiver = if var14 then React.createElement(
            SquadRegroupPromptEventReceiver,
            {
                currentSquadMembers = not var6 and {} or var6.members or {},
                currentSquadId = currentSquadId
            }
        ) else nil
    }
    return createElement(fragment, var15, tbl1)
end
