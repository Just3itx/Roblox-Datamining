-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local CrossExperience = require(CorePackages.Workspace.Packages.CrossExperience)
local Service = if require(CorePackages.Workspace.Packages.Chrome).Enabled() then require(Chrome.ChromeShared.Service) else nil
local isVoiceFocused = CrossExperience.Utils.isVoiceFocused
local useIsVoiceFocused = CrossExperienceVoice.Hooks.useIsVoiceFocused
local useIsVoiceConnecting = CrossExperienceVoice.Hooks.useIsVoiceConnecting

local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local VOICE_JOIN_PROGRESS = Constants.VOICE_JOIN_PROGRESS
local PromptType = require(RobloxGui.Modules.VoiceChatPrompt.PromptType)

local GetFFlagIntegratePhoneUpsellJoinVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIntegratePhoneUpsellJoinVoice
local FFlagVoiceRewarmTelemetry = require(CorePackages.Workspace.Packages.SharedFlags).FFlagVoiceRewarmTelemetry

local FFlagProactiveVoiceRestrictionsUFR = require(CorePackages.Workspace.Packages.SharedFlags).FFlagProactiveVoiceRestrictionsUFR
local FFlagVoiceRewarmGrafanaMetrics = require(RobloxGui.Modules.VoiceChat.Flags.FFlagVoiceRewarmGrafanaMetrics)

local func1 = (function(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = false
    return function(...)
        if bool1 then
            return nil
        end

        bool1 = true
        return arg1(...)
    end
end)(
    function()
        default:reportJoinVoiceUpsellEvent("Shown", if FFlagVoiceRewarmTelemetry then default.joinVoiceButtonContext else nil)
    end
)

local function JoinVoiceBinder()
    local var1 = useIsVoiceFocused()
    local var2 = useIsVoiceConnecting()
    local var3 = React.useMemo(function()
        return var1 or var2
    end, { var2, var1 })

    local var4 = React.useMemo(function()
        return if Service then Service:integrations().join_voice else nil
    end, {})

    local var5 = React.useCallback(function(num1: number)
        if not (var4 and Service) then
            return
        end

        if FFlagProactiveVoiceRestrictionsUFR and default:GetVoiceRestrictionState(false) ~= "normal" then
            var4.availability:unavailable()
            return
        end

        if var1 then
            return
        end

        if num1 ~= Service.AvailabilitySignal.Available then
            if num1 == Service.AvailabilitySignal.Unavailable then
                var4.availability:unavailable()
            end

            return
        end

        func1()
        if FFlagVoiceRewarmGrafanaMetrics then
            default:reportVoiceRewarmShown()
        end
        var4.availability:available()
    end, {})

    local var6 = React.useCallback(function()
        if not Service then
            return
        end

        if GetFFlagIntegratePhoneUpsellJoinVoice() then
            task.spawn(function()
                if default:ShouldShowJoinVoice() and not (var3 or isVoiceFocused()) then
                    var5(Service.AvailabilitySignal.Available)
                end
            end)
        elseif default:ShouldShowJoinVoice() and not (var3 or isVoiceFocused()) then
            var5(Service.AvailabilitySignal.Available)
        end
    end, { var4, var3 })

    local var7 = React.useCallback(function(arg1)
        if not var4 then
            return
        end

        if FFlagProactiveVoiceRestrictionsUFR and default:GetVoiceRestrictionState(false) ~= "normal" or var3 or isVoiceFocused() then
            var4.availability:unavailable()
            return
        end

        if arg1 == VOICE_JOIN_PROGRESS.Idle then
            var6()
            return
        end

        if arg1 ~= VOICE_JOIN_PROGRESS.Joined then
            return
        end

        var4.availability:unavailable()

        if default.inExpUpsellEntrypoint == Constants.IN_EXP_UPSELL_ENTRYPOINTS.JOIN_VOICE then
            default:ToggleMic()
            default:showPrompt(PromptType.VoiceConsentAcceptedToast)
        end
    end, { var4, var3 })

    local var8 = React.useCallback(function()
        var4.availability:unavailable()
    end, { var4 })

    local var9 = React.useCallback(function()
        local effect = if FFlagProactiveVoiceRestrictionsUFR and var4 then Signals.createEffect(function(arg1)
            if default:GetVoiceRestrictionState(arg1) ~= "normal" then
                var4.availability:unavailable()
            end
        end) else nil

        local connection = default.VoiceJoinProgressChanged.Event:Connect(var7)
        local connection2 = default.showVoiceUI.Event:Connect(var8)

        return function()
            if effect then
                effect()
            end
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, {})

    React.useEffect(function()
        var6()
        if FFlagProactiveVoiceRestrictionsUFR then
            return var9()
        end
        var9()
        return nil
    end, {})

    React.useEffect(function()
        var7(default.VoiceJoinProgress)
    end, { var3 })

    return nil
end

return JoinVoiceBinder
