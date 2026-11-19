-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local Foundation = require(CorePackages.Packages.Foundation)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local VoiceIndicatorFunc = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicatorFunc)
local showVoiceRestrictionEndedSnackbar = require(RobloxGui.Modules.VoiceChat.Helpers.showVoiceRestrictionEndedSnackbar)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagProactiveVoiceRestrictionsUFR = SharedFlags.FFlagProactiveVoiceRestrictionsUFR
local FFlagReactiveVoiceRestrictionsUFR = SharedFlags.FFlagReactiveVoiceRestrictionsUFR
local VoiceAnalytics = require(RobloxGui.Modules.Settings.Analytics.VoiceAnalytics)
local GetFFlagEnableVoiceMuteAnalytics = require(RobloxGui.Modules.Flags.GetFFlagEnableVoiceMuteAnalytics)
local engineFeature = game:GetEngineFeature("AudioFocusManagement")
local bool1 = game:DefineFastFlag("EnableChromeAudioFocusManagement", false)
local bool2 = engineFeature and bool1

local bool3 = game:DefineFastFlag("MicConsumerRegistry", false)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local isVoiceChatSupported = require(Chrome.Integrations.isVoiceChatSupported)
local RedVoiceDot = require(Chrome.Integrations.RedVoiceDot)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle
local useIsPlaytestMode = require(Chrome.ChromeShared.Hooks.useIsPlaytestMode)

local FFlagEnablePlaytestModeUnibar = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnablePlaytestModeUnibar
local MappedSignal = ChromeUtils.MappedSignal

local isActivated = if FFlagProactiveVoiceRestrictionsUFR then ChromeUtils.ObservableValue.new(false) else MappedSignal.new(default.muteChanged.Event, function(): boolean
    return default.localMuted == false
end)

local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local var2 = require(RobloxGui.Modules.SelfView.Analytics).new()

local voiceAnalytics = if GetFFlagEnableVoiceMuteAnalytics() then VoiceAnalytics.new(RbxAnalyticsService, "Chrome.Integrations.ToggleMic") else nil

local function handleRestrictedActivation(): boolean
    local voiceRestrictionState = default:GetVoiceRestrictionState(false)
    if voiceRestrictionState == "restricted" then
        default:ShowVoiceRestriction()
    elseif FFlagReactiveVoiceRestrictionsUFR and voiceRestrictionState == "hiddenUntilRejoin" then
        showVoiceRestrictionEndedSnackbar()
    end
    return voiceRestrictionState ~= "normal"
end

local function activated(_)
    if FFlagProactiveVoiceRestrictionsUFR then
        local voiceRestrictionState = default:GetVoiceRestrictionState(false)
        if voiceRestrictionState == "restricted" then
            default:ShowVoiceRestriction()
        elseif FFlagReactiveVoiceRestrictionsUFR and voiceRestrictionState == "hiddenUntilRejoin" then
            showVoiceRestrictionEndedSnackbar()
        end
        if voiceRestrictionState ~= "normal" then
            return
        end
    end
    if bool3 then
        local micManager = default:GetMicManager()
        if micManager and not micManager:HasConsumer("voice_chat") and micManager:GetConsumerCount() > 0 then
            micManager:SetMicActiveForAllConsumers(micManager.localMuted ~= false, "ChromeIntegrationsToggleMic")
            var2:setLastCtx("SelfView")
            return
        end
    end

    default:ToggleMic("ChromeIntegrationsToggleMic")
    var2:setLastCtx("SelfView")
    if voiceAnalytics then
        voiceAnalytics:onToggleMuteSelf(not default.localMuted)
    end
end

local function func1(_)
    if FFlagProactiveVoiceRestrictionsUFR then
        local voiceRestrictionState = default:GetVoiceRestrictionState(false)
        if voiceRestrictionState == "restricted" then
            default:ShowVoiceRestriction()
        elseif FFlagReactiveVoiceRestrictionsUFR and voiceRestrictionState == "hiddenUntilRejoin" then
            showVoiceRestrictionEndedSnackbar()
        end
        if voiceRestrictionState ~= "normal" then
            return
        end
    end

    default:RejoinPreviousChannel()
end

local function func2(_)
    if FFlagProactiveVoiceRestrictionsUFR then
        local voiceRestrictionState = default:GetVoiceRestrictionState(false)
        if voiceRestrictionState == "restricted" then
            default:ShowVoiceRestriction()
        elseif FFlagReactiveVoiceRestrictionsUFR and voiceRestrictionState == "hiddenUntilRejoin" then
            showVoiceRestrictionEndedSnackbar()
        end
        if voiceRestrictionState ~= "normal" then
            return
        end
    end

    default:ShowVoiceChatLoadingMessage()
end

local var3 = Service:register({
    id = "toggle_mic_mute",
    label = if require(Chrome.Flags.FFlagChangeToggleMicText) then "CoreScripts.TopBar.Mic" else "CoreScripts.TopBar.ToggleMic",
    sideSheetPlacement = SideSheetPlacement.Unibar,
    activated = activated,
    isActivated = isActivated,
    components = {
        Icon = function(_)
            local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants.ICON_SIZE
            local var3 = if FFlagEnablePlaytestModeUnibar then useIsPlaytestMode() else nil
            local iconStyle = if FFlagEnablePlaytestModeUnibar and var3 then "MicDark" else "MicLight"

            local var4 = nil
            if bool3 then
                local micManager = default:GetMicManager()
                local var5 = not (micManager and micManager:HasConsumer("voice_chat")) and micManager and micManager:GetConsumerCount() > 0
                local localMuted = if micManager then micManager.localMuted else nil
                local var6, var7 = React.useState(localMuted ~= false)
                local var8, var9 = React.useBinding(0)
                local _, var10 = React.useState(0)
                React.useEffect(function()
                    if not micManager then
                        return
                    end

                    local connection = micManager.muteChanged.Event:Connect(function(arg1)
                        var7(arg1 ~= false)
                    end)
                    local connection2 = micManager.levelChanged.Event:Connect(function(arg1)
                        var9(arg1)
                    end)
                    local connection3 = micManager.hasConsumersChanged.Event:Connect(function()
                        var10(function(arg1): number
                            return arg1 + 1
                        end)
                    end)
                    return function()
                        connection:Disconnect()
                        connection2:Disconnect()
                        connection3:Disconnect()
                    end
                end, { micManager })

                local str2 = if var6 then "Muted" else "Unmuted"
                local var11 = var8:map(function(arg1)
                    return default:GetIcon(str2 .. tostring(arg1), iconStyle)
                end)

                if var5 then
                    local createElement = React.createElement
                    local str3 = "ImageLabel"
                    local tbl1 = {
                        Size = UDim2.new(0, iconSize, 0, iconSize),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Image = 0
                    }

                    if var6 then
                        var11 = default:GetIcon(str2, iconStyle)
                    end

                    tbl1.Image = var11
                    var4 = createElement(str3, tbl1)
                end
            end

            local var5 = if FFlagProactiveVoiceRestrictionsUFR then SignalsReact.useSignalState(function(arg1)
                return default:GetVoiceRestrictionState(arg1)
            end) else "normal"

            if FFlagProactiveVoiceRestrictionsUFR and var5 == "restricted" then
                return React.createElement(Foundation.Image, {
                    Image = "icons/controls/microphoneMute",
                    imageStyle = { Transparency = 0.5 },
                    Size = UDim2.fromOffset(iconSize, iconSize)
                })
            end

            if FFlagReactiveVoiceRestrictionsUFR and var5 == "hiddenUntilRejoin" then
                return React.createElement("ImageLabel", {
                    Size = UDim2.new(0, iconSize, 0, iconSize),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Image = default:GetIcon("Muted", iconStyle)
                })
            end

            if var4 then
                return var4
            end

            return React.createElement("Frame", {
                Size = UDim2.new(0, iconSize, 0, iconSize),
                BackgroundTransparency = 1
            }, { React.createElement(VoiceIndicatorFunc, {
                    userId = tostring(Players.LocalPlayer.UserId),
                    hideOnError = false,
                    iconStyle = iconStyle,
                    selectable = false,
                    size = UDim2.new(0, iconSize, 0, iconSize),
                    showConnectingShimmer = true
                }), (React.createElement(RedVoiceDot, { position = UDim2.new(1, -7, 1, -7) })) })
        end
    }
})

local function updateMicActivated(voiceRestrictionState: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    isActivated:set(voiceRestrictionState == "normal" and default.localMuted == false)
end

local function applyRestrictionState(): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    if default:GetVoiceRestrictionState(false) == "normal" then
        return false
    end

    var3.activated = handleRestrictedActivation
    if FFlagReactiveVoiceRestrictionsUFR then
        var3.availability:pinned()
    else
        var3.availability:unavailable()
    end

    return true
end

local function observeMicPresentation()
    local effect = Signals.createEffect(function(arg1)
        updateMicActivated((default:GetVoiceRestrictionState(arg1)))

        if default:GetVoiceRestrictionState(false) == "normal" then
            return
        end

        var3.activated = handleRestrictedActivation
        if FFlagReactiveVoiceRestrictionsUFR then
            var3.availability:pinned()
            return
        end
        var3.availability:unavailable()
    end)

    local connection = default.muteChanged.Event:Connect(function()
        updateMicActivated((default:GetVoiceRestrictionState(false)))
    end)

    return function()
        effect()
        connection:Disconnect()
    end
end

local function applyVoiceUIVisibility() -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagProactiveVoiceRestrictionsUFR and applyRestrictionState() then
        return
    end

    if default.voiceUIVisible then
        var3.availability:pinned()
    else
        var3.availability:unavailable()
    end
end

local function updateMicAvailabilityFromConsumers()
    if FFlagProactiveVoiceRestrictionsUFR and applyRestrictionState() then
        return
    end

    local micManager = default:GetMicManager()
    if micManager and micManager:GetConsumerCount() > 0 then
        var3.availability:pinned()
    elseif not default.voiceUIVisible then
        var3.availability:unavailable()
    end
end

local function updateVoiceState(_, voiceChatState)
    if FFlagProactiveVoiceRestrictionsUFR and applyRestrictionState() then
        return
    end

    if voiceChatState ~= Enum.VoiceChatState.Ended then
        if bool2 then
            applyVoiceUIVisibility()
        else
            var3.availability:pinned()
        end
    elseif bool3 then
        updateMicAvailabilityFromConsumers()
    else
        var3.availability:unavailable()
    end

    local bool4 = voiceChatState == Enum.VoiceChatState.Failed
    local bool5 = voiceChatState == Enum.VoiceChatState.Joining or voiceChatState == Enum.VoiceChatState.JoiningRetry

    if bool4 then
        var3.activated = func1
    elseif bool5 then
        var3.activated = func2
    else
        var3.activated = activated
    end
end

if isVoiceChatSupported() then
    if FFlagProactiveVoiceRestrictionsUFR then
        script.Destroying:Once((observeMicPresentation()))
    end

    default:asyncInit():andThen(function()
        local service = default:getService()
        if not service then
            return
        end

        service.StateChanged:Connect(updateVoiceState)
        default:SetupParticipantListeners()
        if bool2 then
            default.showVoiceUI.Event:Connect(applyVoiceUIVisibility)
            default.hideVoiceUI.Event:Connect(applyVoiceUIVisibility)
            applyVoiceUIVisibility()
            return
        end

        if not (FFlagProactiveVoiceRestrictionsUFR and applyRestrictionState()) then
            var3.availability:pinned()
        end
    end):catch(function() end)
end

if bool3 then
    local micManager = default:GetMicManager()
    if micManager and micManager.hasConsumersChanged then
        micManager.hasConsumersChanged.Event:Connect(function()
            updateMicAvailabilityFromConsumers()
            micManager:SetMicIndicatorReady(micManager:GetConsumerCount() > 0)
        end)
        updateMicAvailabilityFromConsumers()
        micManager:SetMicIndicatorReady(micManager:GetConsumerCount() > 0)
    end
end

return var3
