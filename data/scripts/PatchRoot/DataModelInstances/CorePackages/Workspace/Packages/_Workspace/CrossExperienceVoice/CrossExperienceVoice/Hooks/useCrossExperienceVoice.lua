-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)
local Players = game:GetService("Players")

local ExperienceService = dependencies.ExperienceService.ExperienceService
local CrossExperience = dependencies.CrossExperience
local React = dependencies.React
local RoactUtils = dependencies.RoactUtils
local useStore = RoactUtils.Hooks.RoactRodux.useStore
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local SharedFlags = dependencies.SharedFlags
local getFFlagEnableCrossExpVoiceMemoryCheck = SharedFlags.getFFlagEnableCrossExpVoiceMemoryCheck
local FIntPartyVoiceJoinRequestPulseCheckTimeout = SharedFlags.FIntPartyVoiceJoinRequestPulseCheckTimeout

local engineFeature = game:GetEngineFeature("CevReadinessSync")

local VoiceStatusChanged = CrossExperience.Actions.VoiceStatusChanged

local useEffect = React.useEffect

local Logger = require(CrossExperienceVoice.Logger)
local default = require(CrossExperienceVoice.CrossExperienceVoiceManager).default
local default2 = require(CrossExperienceVoice.CrossExperienceVoiceAnalytics).default
local Flags = require(CrossExperienceVoice.Flags)
local FFlagFireErrorRCCTimeoutSignal = Flags.FFlagFireErrorRCCTimeoutSignal
local FFlagEnableCEVForceInitialize = Flags.FFlagEnableCEVForceInitialize

local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    return if game.PlaceId == 0 then CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP else CrossExperience.Constants.EXPERIENCE_TYPE_UGC
end

local function useCrossExperienceVoice(tbl1)
    local var1 = useStore()
    local var2 = useDispatch()
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(nil)
    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(nil)

    local var12 = React.useMemo(function()
        return CrossExperience.EventManager.new(func1(), true)
    end, {})

    local var13 = React.useRef(false)

    local function func2() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var13.current then
            return
        end

        var13.current = true
        var12:subscribe(var1, Logger)
    end

    local function func3() -- Luacid: Inlined by compiler; 4 call sites recovered
        if not var13.current then
            return
        end

        var13.current = false
        var12:unsubscribe(var1, Logger)
    end

    local function func4()
        func3()

        if var4.current then
            var4.current:Disconnect()
            var4.current = nil
        end
        if var5.current then
            var5.current:Disconnect()
            var5.current = nil
        end
        if var6.current then
            var6.current:Disconnect()
            var6.current = nil
        end
        if var9.current then
            var9.current:Disconnect()
            var9.current = nil
        end
        if var10.current then
            var10.current:Disconnect()
            var10.current = nil
        end
        if var11.current then
            var11.current:Disconnect()
            var11.current = nil
        end
        if var3.current then
            var3.current:Disconnect()
            var3.current = nil
        end
    end

    local function func5()
        var9.current = default.JoinRequested.Event:Connect(function()
            var2(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.RCC_CONNECTING }))

            local var14 = default2
            local tbl2 = {
                status = CrossExperience.Constants.VOICE_STATUS.RCC_CONNECTING,
                voiceChannelId = nil,
                voiceSessionId = nil,
                userId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else ""
            }
            var14:logPartyVoiceStatusChanged(tbl2)
        end)

        if FIntPartyVoiceJoinRequestPulseCheckTimeout > 0 then
            var3.current = default.JoinRequestPulseCheck.Event:Connect(function()
                local state = var1:getState()
                if not state
                    or not state.Squad
                    or not state.Squad.CrossExperienceVoice
                    or state.Squad.CrossExperienceVoice.Experience.voiceStatus ~= CrossExperience.Constants.VOICE_STATUS.RCC_CONNECTING
                then
                    return
                end
                if FFlagFireErrorRCCTimeoutSignal then
                    local var14 = var12
                    local partyVoiceStatusChanged = CrossExperience.Constants.EVENTS.PARTY_VOICE_STATUS_CHANGED
                    local tbl2 = {
                        status = CrossExperience.Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT,
                        userId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else ""
                    }
                    var14:notify(partyVoiceStatusChanged, tbl2)
                    return
                end

                var2(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT }))

                if tbl1 and tbl1.handleRCCConnectionTimeout then
                    default:logPartyVoiceTimeout()
                    default:leave()
                end
            end)
        end

        var10.current = default.JoinRequestSubmitted.Event:Connect(function(bool1: boolean)
            if bool1 then
                return
            end

            var2(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.ERROR_START_BACKGROUND_DM }))

            local var14 = default2
            local tbl2 = {
                status = CrossExperience.Constants.VOICE_STATUS.ERROR_START_BACKGROUND_DM,
                voiceChannelId = nil,
                voiceSessionId = nil,
                userId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else ""
            }
            var14:logPartyVoiceStatusChanged(tbl2)
        end)

        if getFFlagEnableCrossExpVoiceMemoryCheck() then
            var11.current = default.JoinFeasibilityCheckPerformed.Event:Connect(function(bool1: boolean)
                if bool1 then
                    return
                end

                var2(VoiceStatusChanged({ status = CrossExperience.Constants.VOICE_STATUS.ERROR_JOIN_FEASIBILITY_CHECK_FAILED }))

                local var14 = default2
                local tbl2 = {
                    status = CrossExperience.Constants.VOICE_STATUS.ERROR_JOIN_FEASIBILITY_CHECK_FAILED,
                    voiceChannelId = nil,
                    voiceSessionId = nil,
                    userId = if Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else ""
                }
                var14:logPartyVoiceStatusChanged(tbl2)
            end)
        end

        var4.current = default.ExperienceJoined.Event:Connect(function()
            func2()

            if engineFeature then
                default:signalCevReadinessSync()
            end
        end)
        var5.current = default.ExperienceJoinFailed.Event:Connect(function()
            func3()
        end)

        var6.current = default.ExperienceLeft.Event:Connect(function()
            func3()
        end)

        if ExperienceService then
            var7.current = ExperienceService:RegisterForExperienceJoin(function()
                if game.PlaceId == 0 then
                    func3()
                end
            end)

            var8.current = ExperienceService:RegisterForExperienceLeave(function()
                if game.PlaceId == 0 then
                    var12:restoreStateFromBackground(var1, Logger)
                end
            end)
        end

        if FFlagEnableCEVForceInitialize and tbl1 and tbl1.forceInitializeStoreOnMount then
            func2()
        end
    end

    useEffect(function()
        func5()
        return function()
            func4()
        end
    end, {})

    return nil
end

return useCrossExperienceVoice
