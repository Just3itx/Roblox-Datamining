-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local _RoduxSquads = require(SquadsCoreParent.RoduxSquads)
local React = require(SquadsCoreParent.React)
local Dash = require(SquadsCoreParent.Dash)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(SquadsCoreParent.Localization).Hooks.useLocalization
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId
local getRbxthumbWithTypeSizeAndOptions = require(SquadsCoreParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = require(SquadsCoreParent.UserLib).Utils.Constants
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local NetworkingPresence = require(SquadsCore.Http.NetworkingPresence)
local Constants2 = require(SquadsCore.Common.Constants)
local Cryo = require(SquadsCoreParent.Cryo)

local SquadRegroupExperimentation = require(SquadsCoreParent.SocialExperiments).SquadRegroupExperimentation
local RoduxPresence = require(SquadsCore.Http.RoduxPresence)
local SquadExperienceInviteSource = require(SquadsCore.Enums.SquadExperienceInviteSource)
local SquadToastActionsAndStates = require(SquadsCore.Enums.SquadToastActionsAndStates)
local EventNames = require(SquadsCore.Analytics.EventNames)
local PresenceType = RoduxPresence.Enums.PresenceType
local SquadRegroupEntryPoint = require(SquadsCore.Enums.SquadRegroupEntryPoint)

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local RegroupPromptNotificationState = require(SquadsCore.Utils.RegroupPromptNotificationState)

local Logger = require(SquadsCore.Logger)
local serializeTable = require(SquadsCore.Utils.serializeTable)

local setRegroupPromptShown = require(SquadsCore.Thunks.setRegroupPromptShown)
local GetSquadExperienceInviteStore = require(SquadsCore.Stores.GetSquadExperienceInviteStore)
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local num1 = game:DefineFastInt("SquadRegroupPromptDebounceTimeMs", 20000)

local FFlagSquadsPresenceStoreMigration = require(SquadsCore.Flags.FFlagSquadsPresenceStoreMigration)
local FFlagUseSignalsForSquadExperienceInvite = require(SquadsCoreParent.SharedFlags).FFlagUseSignalsForSquadExperienceInvite
local DataHydration = if FFlagSquadsPresenceStoreMigration then require(SquadsCoreParent.DataHydration) else nil
local Signals = if FFlagSquadsPresenceStoreMigration then require(SquadsCoreParent.Signals) else nil
local SignalsReact = if FFlagSquadsPresenceStoreMigration then require(SquadsCoreParent.SignalsReact) else nil
local var1 = if FFlagSquadsPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local normalizePresenceRawData = if FFlagSquadsPresenceStoreMigration then DataHydration.Presence.normalizePresenceRawData else nil
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local useSignalState = if FFlagSquadsPresenceStoreMigration then SignalsReact.useSignalState else nil

return function(tbl1)
    local var2 = React.useContext(SquadExternalContractContext)
    local var3 = useLocalization({
        RegroupPromptTitle = "Notifications.SquadRegroupPrompt.ToastLabel.ContinuePlayingTogether",
        RegroupPromptBody = "Notifications.SquadRegroupPrompt.ToastLabel.JoinANewServer",
        Dismiss = "Notifications.SquadRegroupPrompt.ToastAction.Dismiss",
        Join = "Notifications.SquadRegroupPrompt.ToastAction.Join"
    })

    local var4 = useDispatch()
    local num2 = tonumber(useLocalUserId()) or 0

    local var5 = React.useRef(false)

    local var6 = React.useMemo(function()
        return Cryo.List.map(tbl1.currentSquadMembers, function(arg1)
            return arg1.userId
        end)
    end, { tbl1.currentSquadMembers })

    local var7 = React.useMemo(function()
        local result = {}
        for _, currentSquadMember in ipairs(tbl1.currentSquadMembers) do
            local userId = currentSquadMember.userId
            result[tostring(userId)] = true
        end
        return result
    end, { tbl1.currentSquadMembers })

    local var8 = if FFlagSquadsPresenceStoreMigration then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local result = ({})
            for _, value in ipairs(var6) do
                local str1 = tostring(value)
                result[str1] = var1.GetPresenceByUserId(str1).data(arg1)
            end
            return result
        end)
    end, { var6 }) else nil

    local var9 = nil
    local var10

    if FFlagSquadsPresenceStoreMigration then
        var10 = useSignalState(var8)
    else
        var10, var9 = React.useState({})
    end

    local var11 = React.useCallback(function()
        if FFlagSquadsPresenceStoreMigration then
            for _, value in ipairs(var6) do
                var1.RefreshPresenceByUserId(tostring(value))
            end

            return
        end

        var4(NetworkingPresence.GetPresencesFromUserIds.API(var6)):andThen(function(arg1)
            local userPresences = arg1 and arg1.responseBody and arg1.responseBody.userPresences or {}
            local tbl2 = ({})
            for _, value in pairs(userPresences) do
                if not (value.userId and value.userPresenceType) then
                    continue
                end

                local str1 = tostring(value.userId)
                local join = Cryo.Dictionary.join
                local tbl3 = {
                    userPresenceType = PresenceType.fromRawValue(value.userPresenceType)
                }
                tbl2[str1] = join(value, tbl3)
            end

            var9(function(arg2)
                return Cryo.Dictionary.join(arg2 or {}, tbl2)
            end)
        end):catch(function(arg1)
            Logger:warning("SquadRegroupPromptEventReceiver: initial presence fetch failed. err={}", serializeTable(arg1))
        end)
    end, { var4, var6, num2 })

    local var12 = React.useRef(true)
    React.useEffect(function()
        var12.current = true

        var11()
        return function()
            var12.current = false
        end
    end, {})

    local var13 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad then
            return arg1.Squad.Squad.currentExperienceInvite
        end

        return nil
    end, {})

    local current = if FFlagUseSignalsForSquadExperienceInvite then nil else useSelector(var13)
    local var15 = React.useRef(nil)
    var15.current = current

    local num3 = num1 / 1000
    local var16 = React.useRef(nil)

    if var16.current == nil then
        var16.current = Dash.debounce(function(tbl2, initiatorId, squadId, icon: string)
            if not var12.current
                or var5.current
                or (if FFlagUseSignalsForSquadExperienceInvite then GetSquadExperienceInviteStore(false).getHasCurrentExperienceInvite(false) else var15.current ~= nil)
            then
                return
            end

            local var17 = tbl2[tostring(initiatorId)]
            if var17 == nil then
                return
            end

            for _, value in pairs(tbl2) do
                local bool1

                if value then
                    bool1 = true
                    local userPresenceType = value.userPresenceType
                    local online = if FFlagSquadsPresenceStoreMigration then PresenceType2.Online else PresenceType.Online

                    if userPresenceType ~= online then
                        bool1 = false
                        local userPresenceType2 = value.userPresenceType
                        local inGame = if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame

                        if userPresenceType2 == inGame then
                            if var17.gameId == (if FFlagSquadsPresenceStoreMigration then "" else nil)
                                or value.gameId == (if FFlagSquadsPresenceStoreMigration then "" else nil)
                            then
                                bool1 = false
                            else
                                bool1 = var17.gameId ~= value.gameId
                            end
                        end
                    end
                else
                    bool1 = value
                end

                if not bool1 then
                    continue
                end

                SquadRegroupExperimentation.logExposure()
                if not SquadRegroupExperimentation.getSquadRegroupEnabled() then
                    return
                end
                local var18 = nil
                var18 = GuiService:SendNotification({
                    Title = var3.RegroupPromptTitle,
                    Text = var3.RegroupPromptBody,
                    Icon = icon,
                    Buttons = {
                        {
                            Text = var3.Dismiss,
                            ButtonType = Enum.NotificationButtonType.Secondary,
                            OnActivated = function()
                                var2.fireSquadAnalytics(EventNames.SquadRegroupPromptClicked, {
                                    clientTimestamp = os.time(),
                                    squadId = squadId,
                                    initiatorId = initiatorId,
                                    gameInstanceId = var17.gameId,
                                    rootPlaceId = var17.rootPlaceId,
                                    placeId = var17.placeId,
                                    universeId = var17.universeId,
                                    playSessionId = RbxAnalyticsService:GetPlaySessionId(),
                                    button = SquadToastActionsAndStates.RegroupDismiss,
                                    entryPoint = SquadRegroupEntryPoint.ToastPrompt
                                })
                                RegroupPromptNotificationState.dismissNotification(var18)
                                var5.current = false
                            end
                        },
                        {
                            Text = var3.Join,
                            ButtonType = Enum.NotificationButtonType.Primary,
                            OnActivated = function()
                                local rootPlaceId = var17.rootPlaceId
                                if var2.createExperienceInvite == nil then
                                    Logger:warning(
                                        "SquadRegroupEventReceiver: Join clicked but createExperienceInvite was not supplied in the external contract"
                                    )
                                elseif rootPlaceId == nil or FFlagSquadsPresenceStoreMigration and rootPlaceId == "" then
                                    Logger:warning(
                                        "SquadRegroupEventReceiver: Join clicked but rootPlaceId is missing from local presence. localPresence={}",
                                        serializeTable(var17)
                                    )
                                else
                                    var4(var2.createExperienceInvite(tostring(rootPlaceId), SquadExperienceInviteSource.Regroup)):andThen(function(experienceInviteId)
                                        var2.fireSquadAnalytics(EventNames.SquadRegroupPromptClicked, {
                                            clientTimestamp = os.time(),
                                            squadId = squadId,
                                            initiatorId = initiatorId,
                                            gameInstanceId = var17.gameId,
                                            rootPlaceId = var17.rootPlaceId,
                                            placeId = var17.placeId,
                                            universeId = var17.universeId,
                                            playSessionId = RbxAnalyticsService:GetPlaySessionId(),
                                            experienceInviteId = experienceInviteId,
                                            button = SquadToastActionsAndStates.RegroupJoin,
                                            entryPoint = SquadRegroupEntryPoint.ToastPrompt
                                        })
                                    end):catch(function(arg1)
                                        Logger:warning("SquadRegroupEventReceiver: createExperienceInvite failed. err={}", serializeTable(arg1))
                                    end)
                                end

                                RegroupPromptNotificationState.dismissNotification(var18)
                                var5.current = false
                            end
                        }
                    }
                })
                var5.current = true
                RegroupPromptNotificationState.setActive(var18, squadId)
                var2.fireSquadAnalytics(EventNames.SquadRegroupPromptShown, {
                    clientTimestamp = os.time(),
                    squadId = squadId,
                    initiatorId = initiatorId,
                    gameInstanceId = var17.gameId,
                    rootPlaceId = var17.rootPlaceId,
                    placeId = var17.placeId,
                    universeId = var17.universeId,
                    playSessionId = RbxAnalyticsService:GetPlaySessionId(),
                    entryPoint = SquadRegroupEntryPoint.ToastPrompt
                })

                if squadId then
                    var4(setRegroupPromptShown(squadId))
                end
                return
            end
        end, num3, { leading = false, trailing = true })
    end

    RealtimeDelivery.useRealtimeNamespace(Constants2.PRESENCE_BULK_RTN_NAMESPACE, function(arg1)
        if type(arg1) ~= "table" then
            return
        end

        local var17 = nil
        for _, value in ipairs(arg1) do
            local userId = value and value.UserId
            if userId == nil then
                continue
            end

            local str1 = tostring(userId)

            if not var7[str1] then
                continue
            end

            local presenceReport = value and value.PresenceReport
            if presenceReport == nil then
                continue
            end

            if FFlagSquadsPresenceStoreMigration then
                var1.UpdateUserPresence(str1, normalizePresenceRawData(presenceReport), { isUpdatedRealtime = true })
            else
                presenceReport.userPresenceType = PresenceType.fromRawValue(presenceReport.userPresenceType)
                var17 = var17 or {}
                var17[str1] = presenceReport
            end
        end

        if FFlagSquadsPresenceStoreMigration or var17 == nil then
            return
        end

        var9(function(arg2)
            local var18 = table.clone(arg2 or {})
            for k, value in pairs(var17) do
                var18[k] = value
            end
            return var18
        end)
    end, { var4, tbl1.currentSquadId, var7 })

    RealtimeDelivery.useRealtimeConnectionStateChanged(Constants2.PRESENCE_BULK_RTN_NAMESPACE, function(connectionState, arg1)
        if connectionState == Enum.ConnectionState.Connected and arg1 then
            Logger:info("Connection re-established, fetching squad presences.")
            var11()
        end
    end, { var11 })

    React.useEffect(function()
        if var5.current then
            return
        end

        local var17 = var10[tostring(num2)]
        local var18

        if FFlagSquadsPresenceStoreMigration then
            var18 = var17 and var17.universeId ~= "" and var17.universeId

            if not var18 then
                if var17 then
                    var18 = var17.gameId ~= "" and var17.gameId or nil
                else
                    var18 = nil
                end
            end
        elseif var17 then
            var18 = var17.universeId or var17.gameId or nil
        else
            var18 = nil
        end

        local rbxthumbWithTypeSizeAndOptions = if var18 == nil then nil else getRbxthumbWithTypeSizeAndOptions(tostring(var18), Constants.RbxthumbTypes.GameIcon, 128, false)
        var16.current(var10, num2, tbl1.currentSquadId, rbxthumbWithTypeSizeAndOptions)
    end, { var10, num2, tbl1.currentSquadId })

    return nil
end
