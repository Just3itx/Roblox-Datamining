-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local MessageBusService = game:GetService("MessageBusService")
local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)
local SquadToastType = require(SquadsCore.Enums.SquadToastType)
local Logger = require(SquadsCore.Logger)
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)
local RoduxSquads = require(SquadsCore.RoduxSquads)
local serializeTable = require(SquadsCore.Utils.serializeTable)
local useCurrentSquadParentChannelId = require(SquadsCore.Hooks.useCurrentSquadParentChannelId)
local GetSquadExperienceInviteStore = require(SquadsCore.Stores.GetSquadExperienceInviteStore)

local Cryo = require(SquadsCoreParent.Cryo)
local ExperienceService = require(SquadsCoreParent.ExperienceService)
local LocalStorageKey = require(SquadsCoreParent.LocalStorage).Enums.LocalStorageKey
local React = require(SquadsCoreParent.React)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local SharedFlags = require(SquadsCoreParent.SharedFlags)
local SoundManager = require(SquadsCoreParent.SoundManager)

local SquadCoordinationExperienceJoinExperimentation = require(SquadsCoreParent.SocialExperiments).SquadCoordinationExperienceJoinExperimentation
local ToastNotification = require(SquadsCoreParent.ToastNotification)
local ToastNotificationsProtocol = require(SquadsCoreParent.ToastNotificationsProtocol)
local LuauPolyfill = require(SquadsCoreParent.LuauPolyfill)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(SquadsCoreParent.SignalsReact).useSignalState

local GameParams = ExperienceService.GameParams
local ExperienceService2 = ExperienceService.ExperienceService

local clearInterval = LuauPolyfill.clearInterval
local setInterval = LuauPolyfill.setInterval

local ExperienceInviteState = RoduxSquads.Enums.ExperienceInviteState
local ExperienceInviteVoteType = RoduxSquads.Enums.ExperienceInviteVoteType
local ExperienceInviteType = RoduxSquads.Enums.ExperienceInviteType

local Sounds = SoundManager.Sounds
local SoundManager2 = SoundManager.SoundManager

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local EventNames = require(SquadsCore.Analytics.EventNames)

local LifecycleEvents = ToastNotification.LifecycleEvents
local NotificationTypeEnum = ToastNotification.ToastNotificationTypeModule.NotificationTypeEnum

local num1 = game:DefineFastInt("SquadExperienceInvitePollingIntervalSeconds", 4)
local num2 = game:DefineFastInt("SquadExperienceInviteTimeoutSeconds", 30)

local FFlagDebugSquadLogsEnabled = SharedFlags.FFlagDebugSquadLogsEnabled
local FFlagSquadLaunchExperienceMobileFix = SharedFlags.FFlagSquadLaunchExperienceMobileFix
local FFlagEnablePrivatePartyAcceptInvite = SharedFlags.FFlagEnablePrivatePartyAcceptInvite
local FFlagUseSignalsForSquadExperienceInvite = SharedFlags.FFlagUseSignalsForSquadExperienceInvite

local messageId = MessageBusService:GetMessageId("ToastNotifications", "userActionOnToastNotification")

local function func1(input) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagDebugSquadLogsEnabled then
        return HttpService:JSONEncode(input)
    end
    return if input.StatusCode then input.StatusCode else -1
end

return function(tbl1)
    local var1 = useDispatch()
    local num3 = tonumber(useLocalUserId()) or 0

    local var2 = React.useContext(SquadExternalContractContext)

    local voteIdentifier, var4 = React.useState("")
    React.useEffect(function()
        local success, result = pcall(function(): string
            return AppStorageService:GetItem(LocalStorageKey.BrowserTrackerId)
        end)
        if success then
            var4(result)
        end

        local connection = AppStorageService.ItemWasSet:Connect(function(key: string, value: string)
            if key == LocalStorageKey.BrowserTrackerId then
                var4(value)
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { var4 })

    local default = ToastNotificationsProtocol.ToastNotificationProtocol.default
    local var5 = React.useRef(false)
    local var6 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad then
            return arg1.Squad.Squad.currentExperienceInvite
        end

        return nil
    end, {})

    local var7 = if FFlagUseSignalsForSquadExperienceInvite then useSignalState(GetSquadExperienceInviteStore(false).getCurrentExperienceInvite) else useSelector(var6)
    local parentChannelId = useCurrentSquadParentChannelId()

    local model = var7 and var7.model
    local experienceInviteId = model and model.experienceInviteId or ""

    local state = model and model.state or ""
    local gameInstanceId = model and model.experienceDetail.gameInstanceId or ""

    local placeId = model and model.experienceDetail.placeId or 0

    local inviterId = model and model.inviterId or 0

    local var9, var10 = React.useMemo(function()
        if not (var7 and var7.model) then
            if var7 and var7.notification.isInviter then
                return ExperienceInviteVoteType.Accept, false
            end
            return ExperienceInviteVoteType.Invalid, false
        end

        for _, value in ipairs(var7.model.votes) do
            if value.userId == num3 then
                local bool1 = if value.voteIdentifier and value.voteIdentifier ~= "" then value.voteIdentifier ~= voteIdentifier else false
                return value.voteType, bool1
            end
        end

        return ExperienceInviteVoteType.NoVote, false
    end, { var7, num3, voteIdentifier })

    local var11 = React.useCallback(function(str1: string, bool1: boolean)
        if bool1 then
            default:dismissNotification(str1)
        end
        if FFlagUseSignalsForSquadExperienceInvite then
            GetSquadExperienceInviteStore(false).currentExperienceInviteDismissed(str1)
        else
            var1(RoduxSquads.Actions.CurrentExperienceInviteDismissed(str1))
        end
        var5.current = false
    end, { var1 })

    local var12 = React.useCallback(function(experienceInviteId2, membershipEntityId)
        return var1(
            NetworkingSquads.GetExperienceInvite.API(
                {
                    experienceInviteId = experienceInviteId2,
                    membershipEntityId = membershipEntityId
                }
            )
        ):catch(
            function(arg1)
                local var12 = Logger
                local var13 = func1(arg1)
                local str1 = "Error getting experience invite. Error: {}, ExperienceInviteId: {}, MembershipEntityId: {}"
                var12:warning(str1, var13, experienceInviteId2, membershipEntityId)
            end
        )
    end, { var1 })
    local var13 = React.useCallback(function(experienceInviteId2, voteType, membershipEntityId)
        local tbl2 = {
            parentChannelId = parentChannelId,
            experienceInviteId = experienceInviteId2,
            voteType = voteType
        }

        return var1(
            NetworkingSquads.VoteForExperienceInvite.API({
                experienceInviteId = experienceInviteId2,
                membershipEntityId = membershipEntityId,
                voteIdentifier = voteIdentifier,
                voteType = voteType
            })
        ):andThen(
            function()
                var2.fireSquadAnalytics(EventNames.SquadVoteApiCall, Cryo.Dictionary.union(tbl2, { isSuccess = true }))
            end
        ):catch(
            function(arg1)
                local body = arg1.Body
                local success, result = pcall(function()
                    return HttpService:JSONDecode(body)
                end)

                local errorType = if success then result.errorType else nil
                local fireSquadAnalytics = var2.fireSquadAnalytics
                local squadVoteApiCall = EventNames.SquadVoteApiCall
                local union = Cryo.Dictionary.union
                local tbl3 = tbl2
                local tbl4 = {
                    isSuccess = false,
                    errorMessage = errorType,
                    errorType = if arg1.StatusCode then tostring(arg1.StatusCode) else nil
                }
                fireSquadAnalytics(squadVoteApiCall, union(tbl3, tbl4))

                local var14 = Logger
                local var15 = func1(arg1)
                local str1 = "Error voting for experience invite. Error: {}, ExperienceInviteId: {}, MembershipEntityId: {}, VoteType: {}"
                var14:warning(str1, var15, experienceInviteId2, membershipEntityId, voteType)
            end
        )
    end, { var1, voteIdentifier })

    local useCallback = React.useCallback

    local function func2(joinAttemptId)
        var2.fireSquadAnalytics(EventNames.SquadExperienceInviteStateChange, {
            experienceInviteId = experienceInviteId,
            invitationGameInstanceId = gameInstanceId,
            invitationPlaceId = placeId,
            inviterId = inviterId,
            inviteState = state,
            parentChannelId = parentChannelId,
            joinAttemptId = joinAttemptId
        })
    end

    local fireSquadAnalytics = if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then var2.fireSquadAnalytics else nil
    local var14 = useCallback(
        func2,
        {
            gameInstanceId,
            experienceInviteId,
            inviterId,
            placeId,
            state,
            parentChannelId,
            fireSquadAnalytics
        }
    )

    React.useEffect(function()
        local var15 = if var7 then task.delay(num2, function()
            var11(var7.notification.notificationId, true)
        end) else nil

        return function()
            if var15 then
                task.cancel(var15)
            end
        end
    end, { var11, var7 })

    local useEffect = React.useEffect

    local function func3()
        if not var7 or var9 ~= ExperienceInviteVoteType.Accept or var5.current then
            return
        end

        local model2 = var7.model
        local notification = var7.notification
        if not model2 or model2.state ~= ExperienceInviteState.ReservationSuccessful then
            return
        end

        local gameInstanceId2 = model2.experienceDetail.gameInstanceId
        local placeId2 = model2.experienceDetail.placeId

        if not FFlagEnablePrivatePartyAcceptInvite
            or var7.model.inviteType ~= ExperienceInviteType.PlayWithPartyInPrivatePartyServer
        then
            assert(gameInstanceId2, "Game instance id should exist.")
        end
        var5.current = true
        Logger:debug("Launching experience. GameInstanceId: {}, PlaceId: {}", gameInstanceId2, placeId2)

        local var15 = task.delay(1, function()
            var11(notification.notificationId, true)

            if var2.squadLocation == SquadLocationEnum.InExperience and FFlagSquadLaunchExperienceMobileFix then
                game:Shutdown()
            end

            local str1 = "SquadExperienceInvite"
            if var2.squadLocation == SquadLocationEnum.UniversalApp then
                str1 = "SquadExperienceInviteFromUA"
            elseif var2.squadLocation == SquadLocationEnum.InExperience then
                str1 = "SquadExperienceInviteFromInExp"
            end

            local var15

            if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then
                var15 = HttpService:GenerateGUID(false)
                var14(var15)
            else
                var15 = nil
            end

            local placeInstance = GameParams.fromPlaceInstance(placeId2, gameInstanceId2)
            if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then
                placeInstance.joinAttemptId = var15
            end

            if FFlagEnablePrivatePartyAcceptInvite and var7.model.inviteType == ExperienceInviteType.PlayWithPartyInPrivatePartyServer then
                placeInstance.isPrivateParty = true
            end
            ExperienceService2:LaunchExperience(placeInstance, str1, nil)
        end)
        return function()
            task.cancel(var15)
        end
    end

    local squadLocation = var2.squadLocation
    local var15 = if SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled() then var14 else nil
    useEffect(func3, { squadLocation, var7, var11, var9, var15 })

    React.useEffect(function()
        local num4 = num1
        local var16 = if var7
            and (not var7.model
                or var7.model.state == ExperienceInviteState.Active
                or var7.model.state == ExperienceInviteState.Reserving) then setInterval(function()
            var12(var7.notification.experienceInviteId, var7.notification.membershipEntityId)
        end, num4 * 1000) else nil

        return function()
            if var16 then
                clearInterval(var16)
            end
        end
    end, { var7, var12 })

    React.useEffect(function()
        if var7 and (tbl1.currentSquadId ~= var7.notification.membershipEntityId or var10) then
            var11(var7.notification.notificationId, true)
        end
    end, {
        var7,
        var11,
        tbl1.currentSquadId,
        var10
    })

    React.useEffect(function()
        if ExperienceInviteState[state]
            and (not SquadCoordinationExperienceJoinExperimentation.getIsSquadLobbySessionEnabled()
                or ExperienceInviteState[state] ~= ExperienceInviteState.ReservationSuccessful)
        then
            var14()
        end
    end, { state, var14 })

    React.useEffect(function()
        if not (var7 and var7.model) then
            return
        end

        Logger:debug("Current experience invite updated: {}", serializeTable(var7.model))

        local notificationId = var7.notification.notificationId
        local state2 = var7.model.state
        if var7.model.inviterId == num3 then
            if state2 == ExperienceInviteState.Active then
                if var7.model.spotsTaken > 1 then
                    default:updateNotification(notificationId, var7.model.spotsTaken .. "SpotsFilled")
                end
            else
                if state2 == ExperienceInviteState.Reserving or state2 == ExperienceInviteState.ReservationSuccessful then
                    default:updateNotification(notificationId, "launching")
                    return
                end
                var11(notificationId, true)

                if state2 ~= ExperienceInviteState.Cancelled and state2 ~= ExperienceInviteState.ReservationFailed then
                    Logger:warning("Invitee unexpected squad experience invite state: {}", state2)
                end
            end

            return
        end

        if state2 == ExperienceInviteState.Active then
            if var9 == ExperienceInviteVoteType.Invalid or var9 == ExperienceInviteVoteType.NoVote then
                if var7.model.spotsTaken >= var7.model.totalSpots then
                    var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                        parentChannelId = parentChannelId,
                        experienceInviteId = var7.model.experienceInviteId,
                        toastAction = SquadToastActionsAndStates.ExpInvSlotsFull,
                        toastType = SquadToastType.ExperienceInvite
                    })
                    default:updateNotification(notificationId, "slotsFull")
                end
            else
                if var9 == ExperienceInviteVoteType.Accept then
                    default:updateNotification(notificationId, "waiting")
                    return
                end

                if var9 == ExperienceInviteVoteType.Decline or var9 == ExperienceInviteVoteType.Dismiss then
                    var11(notificationId, true)
                end
            end

            return
        end
        if state2 ~= ExperienceInviteState.Reserving and state2 ~= ExperienceInviteState.ReservationSuccessful then
            if state2 == ExperienceInviteState.Cancelled then
                default:updateNotification(notificationId, "cancelled")
                return
            end
            var11(notificationId, true)

            if state2 ~= ExperienceInviteState.ReservationFailed then
                Logger:warning("Inviter unexpected squad experience invite state: {}", state2)
            end

            return
        end

        if var9 == ExperienceInviteVoteType.Invalid or var9 == ExperienceInviteVoteType.NoVote then
            var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                parentChannelId = parentChannelId,
                experienceInviteId = var7.model.experienceInviteId,
                toastAction = SquadToastActionsAndStates.ExpInvExpired,
                toastType = SquadToastType.ExperienceInvite
            })
            default:updateNotification(notificationId, "expired")
            return
        end

        if var9 == ExperienceInviteVoteType.Accept then
            default:updateNotification(notificationId, "waiting")
            return
        end

        if var9 == ExperienceInviteVoteType.Decline or var9 == ExperienceInviteVoteType.Dismiss then
            var11(notificationId, true)
        end
    end, {
        var7,
        parentChannelId,
        var11,
        num3,
        var2.fireSquadAnalytics,
        var9
    })

    RealtimeDelivery.useRealtimeNamespace("ExperienceInviteUpdate", function(arg1)
        Logger:debug("Experience invite RTN received. Detail: {}", serializeTable(arg1))
        if FFlagUseSignalsForSquadExperienceInvite then
            GetSquadExperienceInviteStore(false).currentExperienceInviteUpdated(arg1)
            return
        end
        var1(RoduxSquads.Actions.CurrentExperienceInviteUpdated(arg1))
    end, { var1 })

    React.useEffect(function()
        local var16 = default:listenToDismissNotification(function(arg1)
            if not var7 or var7.notification.notificationId ~= arg1.notificationId then
                return
            end
            if var9 ~= ExperienceInviteVoteType.Accept then
                var11(arg1.notificationId, false)
            end

            if var7.model and var7.model.state ~= ExperienceInviteState.Active
                or var9 ~= ExperienceInviteVoteType.Invalid and var9 ~= ExperienceInviteVoteType.NoVote
            then
                return
            end

            var2.fireSquadAnalytics(EventNames.SquadToastActions, {
                parentChannelId = parentChannelId,
                experienceInviteId = var7.notification.experienceInviteId,
                toastAction = SquadToastActionsAndStates.ExpInvDismiss,
                toastType = SquadToastType.ExperienceInvite
            })
            var13(var7.notification.experienceInviteId, ExperienceInviteVoteType.Dismiss, var7.notification.membershipEntityId)
        end)

        return function()
            if var16 then
                var16:Disconnect()
            end
        end
    end, {
        var7,
        parentChannelId,
        var11,
        var1,
        var2.fireSquadAnalytics,
        var9,
        var13
    })

    React.useEffect(function()
        local var16 = default:listenToDisplayNotification(function(arg1)
            if not arg1 or num3 <= 0 or arg1.notificationType ~= NotificationTypeEnum.SquadExperienceInvitation then
                return
            end

            local var16 = HttpService:JSONDecode(arg1.lifecycleData)
            if FFlagUseSignalsForSquadExperienceInvite then
                GetSquadExperienceInviteStore(false).currentExperienceInviteReceived(
                    var16.experienceInviteId,
                    var16.membershipEntityId,
                    arg1.notificationId,
                    var16.isInviter
                )
                return
            end

            var1(
                RoduxSquads.Actions.CurrentExperienceInviteReceived(
                    var16.experienceInviteId,
                    var16.membershipEntityId,
                    arg1.notificationId,
                    var16.isInviter
                )
            )
        end)

        return function()
            if var16 then
                var16:Disconnect()
            end
        end
    end, { num3 })

    React.useEffect(function()
        local var16 = MessageBusService:Subscribe(messageId, function(arg1)
            if arg1.notificationType ~= NotificationTypeEnum.SquadExperienceInvitation or arg1.userActionType ~= "timerElapsed" then
                return
            end
            if var7 then
                assert(var7, "Experience invite must exist to perform actions.")

                if (not var7.model or var7.model.state == ExperienceInviteState.Active)
                    and (var9 == ExperienceInviteVoteType.Invalid or var9 == ExperienceInviteVoteType.NoVote)
                then
                    default:updateNotification(arg1.notificationId, "expired")
                end

                return
            end

            local var16 = HttpService:JSONDecode(arg1.parameters)
            if FFlagUseSignalsForSquadExperienceInvite then
                GetSquadExperienceInviteStore(false).currentExperienceInviteReceived(
                    var16.experienceInviteId,
                    var16.membershipEntityId,
                    arg1.notificationId,
                    var16.isInviter
                )
            else
                var1(
                    RoduxSquads.Actions.CurrentExperienceInviteReceived(
                        var16.experienceInviteId,
                        var16.membershipEntityId,
                        arg1.notificationId,
                        var16.isInviter
                    )
                )
            end
            var1(function()
                default:updateNotification(arg1.notificationId, "expired")
            end)
        end, false, true)

        return function()
            if var16 then
                var16:Disconnect()
            end
        end
    end, { var7, var9, var13 })

    React.useEffect(function()
        local var16 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.UserAction,
            NotificationTypeEnum.SquadExperienceInvitation,
            function(arg1)
                if not arg1 or arg1.userActionType ~= "click" or not arg1.visualItem or not arg1.visualItem.actionEventParams then
                    return
                end
                local var16 = HttpService:JSONDecode(arg1.visualItem.actionEventParams)
                local tbl2 = {
                    parentChannelId = parentChannelId,
                    experienceInviteId = var16.experienceInviteId,
                    toastType = SquadToastType.ExperienceInvite
                }

                if not var7 then
                    if FFlagUseSignalsForSquadExperienceInvite then
                        GetSquadExperienceInviteStore(false).currentExperienceInviteReceived(
                            var16.experienceInviteId,
                            var16.membershipEntityId,
                            arg1.notificationData.id,
                            var16.isInviter
                        )
                    else
                        var1(
                            RoduxSquads.Actions.CurrentExperienceInviteReceived(
                                var16.experienceInviteId,
                                var16.membershipEntityId,
                                arg1.notificationData.id,
                                var16.isInviter
                            )
                        )
                    end
                end

                if arg1.visualItem.eventName == "GroupUpSquadExperience" then
                    var2.fireSquadAnalytics(
                        EventNames.SquadToastActions,
                        Cryo.Dictionary.union(tbl2, { toastAction = SquadToastActionsAndStates.ExpInvAccept })
                    )

                    var13(var16.experienceInviteId, ExperienceInviteVoteType.Accept, var16.membershipEntityId)
                elseif arg1.visualItem.eventName == "DismissSquadExperienceInvited" then
                    var2.fireSquadAnalytics(
                        EventNames.SquadToastActions,
                        Cryo.Dictionary.union(tbl2, { toastAction = SquadToastActionsAndStates.ExpInvDecline })
                    )

                    var13(var16.experienceInviteId, ExperienceInviteVoteType.Decline, var16.membershipEntityId)
                elseif arg1.visualItem.eventName == "CancelSquadExperienceSpotsFilled" then
                    var2.fireSquadAnalytics(
                        EventNames.SquadToastActions,
                        Cryo.Dictionary.union(tbl2, { toastAction = SquadToastActionsAndStates.ExpInvCancel })
                    )

                    var13(var16.experienceInviteId, ExperienceInviteVoteType.Cancel, var16.membershipEntityId)
                end
            end
        )

        return function()
            var16()
        end
    end, {
        var7,
        parentChannelId,
        var1,
        var2.fireSquadAnalytics,
        var13
    })

    React.useEffect(function()
        local var16 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.SquadExperienceInvitation,
            function(arg1)
                local actionEventParams = arg1
                    and arg1.state
                    and arg1.state.visualItems
                    and arg1.state.visualItems.button
                    and arg1.state.visualItems.button[1]
                    and arg1.state.visualItems.button[1].actionEventParams

                if not actionEventParams then
                    return
                end

                local experienceInviteId2 = HttpService:JSONDecode(actionEventParams).experienceInviteId

                var2.fireSquadAnalytics(
                    EventNames.SquadExperienceInviteImpression,
                    {
                        experienceInviteId = experienceInviteId2,
                        notificationId = arg1.id,
                        clientTimestamp = os.time()
                    }
                )
            end
        )
        return function()
            var16()
        end
    end, { var2.fireSquadAnalytics })

    React.useEffect(function()
        local function func4(arg1)
            if arg1.currentState == "invited" then
                SoundManager2:PlaySound(Sounds.PartyToast.Name)
            end
        end

        local var16 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Display,
            NotificationTypeEnum.SquadExperienceInvitation,
            func4
        )

        local var17 = LifecycleEvents:RegisterCallback(
            LifecycleEvents.ToastEvents.Update,
            NotificationTypeEnum.SquadExperienceInvitation,
            func4
        )

        return function()
            var16()
            var17()
        end
    end, {})

    return nil
end
