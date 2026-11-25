-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local CoreScriptsCommon = require(PeopleReactViewParent.CoreScriptsCommon)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local Signals = require(PeopleReactViewParent.Signals)
local useLocalization = require(PeopleReactViewParent.Localization).Hooks.useLocalization
local SharedFlags = require(PeopleReactViewParent.SharedFlags)
local SwitchServer = require(PeopleReactViewParent.SwitchServer)

local service = PeopleService.getService("Flags")
local GetFFlagNewPeoplePageIcons = service.GetFFlagNewPeoplePageIcons
local FFlagEnablePeoplePageButtonOnMount = service.FFlagEnablePeoplePageButtonOnMount
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local FFlagHidePeoplePageInviteFriends = SharedFlags.FFlagHidePeoplePageInviteFriends
local FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration
local FFlagPeopleTabUseSwitchServerModule = require(PeopleReactView.Flags.FFlagPeopleTabUseSwitchServerModule)
local FFlagGameInviteInExpJoinOrInviteLabel = require(PeopleReactViewParent.GameInvite.FFlagGameInviteInExpJoinOrInviteLabel)
local isSideSheetEnabled = require(PeopleReactViewParent.InExperienceSideSheetUtils.isSideSheetEnabled)
local isPlatformInviteUIEnabled = require(PeopleReactViewParent.GameInvite.isPlatformInviteUIEnabled)

local Constants = require(PeopleReactView.Constants)
local STANDARD_SERVER = CoreScriptsCommon.Constants.STANDARD_SERVER
local Constants2 = SwitchServer.Constants

local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState

local GetSwitchServerStore = SwitchServer.GetSwitchServerStore
local SwitchServerTelemetry = SwitchServer.SwitchServerTelemetry

local bool1 = false
local function sendSwitchServerButtonImpressionOnce() -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        bool1 = true
        SwitchServerTelemetry.sendSwitchServerButtonActions({ event_type = "impression" })
    end
end

local function useCoreButtonConfigs(bool2: boolean, tbl1)
    local var1 = if FFlagShowSwitchServerButton and not FFlagPeopleTabUseSwitchServerModule then React.useMemo(function()
        local var1, var2 = Signals.createSignal(nil)

        if not RunService:IsStudio() then
            local getServerType = RobloxReplicatedStorage:WaitForChild("GetServerType", 2)
            if getServerType then
                local success, result = pcall(function()
                    return getServerType:InvokeServer()
                end)
                if success then
                    var2(result)
                end
            end
        end

        return var1
    end, {}) else nil

    local var2 = if FFlagShowSwitchServerButton and not FFlagPeopleTabUseSwitchServerModule then useSignalState(var1) else nil
    local var3 = if FFlagShowSwitchServerButton and FFlagPeopleTabUseSwitchServerModule then useSignalState(GetSwitchServerStore(false).shouldEnableSwitchServer) else false
    local var4 = useLocalization({
        inviteFriends = Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.INVITE_FRIENDS,
        joinOrInvite = if FFlagGameInviteInExpJoinOrInviteLabel then Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.JOIN_OR_INVITE else nil,
        muteAll = Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.MUTE_ALL,
        unmuteAll = Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.UNMUTE_ALL,
        switchServer = Constants2.BUTTON.LABEL,
        muteSelf = Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.MUTE_SELF,
        unmuteSelf = Constants.PEOPLEPAGE.CORE_BUTTONS.LOCALIZED_STRINGS.UNMUTE_SELF
    })

    local service2 = PeopleService.getService("PeopleVoiceChatStore")
    local service3 = PeopleService.getService("PeopleAnalyticsManager")
    local service4 = PeopleService.getService("SettingsHubService")

    local voiceChatServiceConnected = service2.voiceChatServiceConnected
    local shouldShow = useSignalState(service2.voiceUIVisible)
    local allPlayersMuted = service2.allPlayersMuted
    local var6 = useSignalBinding(allPlayersMuted)
    local localMuted = service2.localMuted
    local var7 = useSignalBinding(localMuted)

    local text = var6:map(function(arg1)
        return arg1 and var4.unmuteAll or var4.muteAll
    end)

    local var5 = var7:map(function(arg1)
        local var9

        if arg1 ~= nil then
            var9 = arg1 and var4.unmuteSelf

            if not var9 then
                return var4.muteSelf
            end
        else
            var9 = var4.muteSelf
        end

        return var9
    end)

    return (React.useMemo(function()
        local result = {}

        if not (FFlagHidePeoplePageInviteFriends and FFlagAddInviteFriendsIntegration and isSideSheetEnabled) then
            local tbl2 = {
                id = "inviteFriends",
                text = if FFlagGameInviteInExpJoinOrInviteLabel and not isPlatformInviteUIEnabled() then var4.joinOrInvite else var4.inviteFriends,
                onIcon = if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.INVITE_FRIENDS_NEW else Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.INVITE_FRIENDS_LEGACY,
                isNewIcon = GetFFlagNewPeoplePageIcons(),
                shouldShow = 0,
                onActivated = 0,
                layoutOrder = 1
            }

            function tbl2.shouldShow(): boolean
                local bool3 = not RunService:IsStudio()
                return bool3 and Players.LocalPlayer ~= nil and Players.LocalPlayer.UserId > 0
            end
            function tbl2.onActivated()
                local var10 = service4.hubRef()
                if var10 then
                    service3:trackGameInviteEntryPoint()

                    var10:InviteToGame()
                end
            end

            table.insert(result, tbl2)
        end

        local tbl2 = {
            id = "muteAll",
            text = text,
            onIcon = if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.HEADPHONE_NEW else Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.HEADPHONE_LEGACY,
            offIcon = if GetFFlagNewPeoplePageIcons() then Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.HEADPHONE_MUTED_NEW else Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.HEADPHONE_MUTED_LEGACY,
            buttonState = allPlayersMuted,
            isNewIcon = GetFFlagNewPeoplePageIcons(),
            shouldShow = 0,
            onActivated = 0,
            layoutOrder = 2
        }

        function tbl2.shouldShow()
            return shouldShow
        end
        function tbl2.onActivated()
            local value = var6:getValue()
            service3:trackToggleMuteAll(value)

            service2.toggleMuteAll()
        end

        table.insert(result, tbl2)

        if FFlagShowSwitchServerButton and not isSideSheetEnabled then
            table.insert(result, {
                id = "switchServer",
                text = var4.switchServer,
                onIcon = Constants2.BUTTON.ICON,
                isNewIcon = true,
                shouldShow = function()
                    if FFlagPeopleTabUseSwitchServerModule then
                        return var3
                    end
                    local engineFeature = game:GetEngineFeature("GameIdToExcludeAvailable")
                    return engineFeature and var2 == STANDARD_SERVER and Players.MaxPlayers > 1
                end,
                onActivated = tbl1[Constants.PEOPLEPAGE.BUTTON_ACTIVATED_TABLE_KEYS.SWITCH_SERVER],
                layoutOrder = 3,
                onMount = FFlagEnablePeoplePageButtonOnMount and function()
                    sendSwitchServerButtonImpressionOnce()
                end or nil
            })
        end

        table.insert(result, {
            id = "muteSelf",
            text = var5,
            onIcon = Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.MICROPHONE,
            offIcon = Constants.PEOPLEPAGE.CORE_BUTTONS.ICON.MICROPHONE_MUTED,
            animatedIcon = service2.getMuteSelfIcon(),
            buttonState = localMuted,
            isNewIcon = false,
            shouldShow = function()
                return shouldShow and not bool2
            end,
            onActivated = function()
                local value = var7:getValue() or false
                service3:trackToggleMuteSelf(value)

                service2.toggleMuteSelf()
            end,
            layoutOrder = if FFlagShowSwitchServerButton then 4 else 3
        })

        return result
    end, { shouldShow, voiceChatServiceConnected, var1 }))
end

return useCoreButtonConfigs
