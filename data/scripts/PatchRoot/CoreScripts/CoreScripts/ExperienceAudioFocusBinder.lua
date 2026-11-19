-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.Promise)
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice

local Constants = require(RobloxGui.Modules.VoiceChat.Constants)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local CrossExperience = require(CorePackages.Workspace.Packages.CrossExperience)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local Constants2 = CrossExperience.Constants

local FIntPartyVoiceUndeafenDelayMS = SharedFlags.FIntPartyVoiceUndeafenDelayMS
local bool1 = game:DefineFastFlag("FixJoinVoiceDelayedAFMInit", false)

local bool2 = false
local var2 = nil
local bool3 = false
local bool4 = false
local bool5 = false
local bool6 = false

local var3 = nil

if GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then
    default:subscribe("OnStateChanged", function(_, voiceChatState)
        var2 = voiceChatState
        if voiceChatState == Enum.VoiceChatState.Ended then
            bool4 = false
        end
    end)
    default.VoiceJoinProgressChanged.Event:Connect(function(suspended)
        if suspended == Constants.VOICE_JOIN_PROGRESS.Suspended then
            bool2 = true
        end
    end)

    function performVoiceOperationWhenReady(callback)
        default:asyncInit():andThen(function()
            callback()
        end):catch(function()
            var1:info("VCSM was not initialized to perform operation [CEV ExperienceAudioFocusBinder]")
        end)
    end

    function isConnectedToPublicVoice(): boolean
        return not default:ShouldShowJoinVoice() or var2 == Enum.VoiceChatState.Joined
    end

    function initializeAFM()
        if bool1 and bool3 then
            var1:info("VCSM was already initialized [CEV ExperienceAudioFocusBinder]")
            return
        end
        if bool1 then
            bool3 = true
        end
        local success, result = pcall(function(): AudioFocusService
            return game:GetService("AudioFocusService")
        end)
        if not success or not result then
            return
        end

        local contextId = Constants2.AUDIO_FOCUS_MANAGEMENT.UGC.CONTEXT_ID
        local focusPriority = Constants2.AUDIO_FOCUS_MANAGEMENT.UGC.FOCUS_PRIORITY

        result:RegisterContextIdFromLua(contextId)

        local function func1()
            if not isConnectedToPublicVoice() then
                return
            end

            if FIntPartyVoiceUndeafenDelayMS > 0 and var3 then
                task.cancel(var3)
                var3 = nil
            end

            default:MuteAll(true, "AudioFocusManagement UGC")
            if not default.localMuted then
                default:ToggleMic("AudioFocusManagement - UGC deafenAll")
            end

            default:HideVoiceUI()
        end

        local function func2()
            if not isConnectedToPublicVoice() then
                return
            end

            if FIntPartyVoiceUndeafenDelayMS > 0 and var3 then
                task.cancel(var3)
                var3 = nil
            end
            default:MuteAll(false, "AudioFocusManagement UGC")
            if not default.localMuted then
                default:ToggleMic("AudioFocusManagement - UGC undeafenAll")
            end

            default:ShowVoiceUI()
        end

        result.OnDeafenVoiceAudio:Connect(function(contextId2: number)
            if contextId2 ~= contextId then
                return
            end

            if FIntPartyVoiceUndeafenDelayMS > 0 and var3 then
                task.cancel(var3)
                var3 = nil
            end
            var1:info("UGC OnDeafenVoiceAudio fired" .. contextId2)
            performVoiceOperationWhenReady(func1)
        end)

        result.OnUndeafenVoiceAudio:Connect(function(contextId2: number)
            if contextId2 ~= contextId then
                return
            end

            if not (FIntPartyVoiceUndeafenDelayMS > 0) then
                var1:info("UGC OnUndeafenVoiceAudio fired" .. contextId2)
                performVoiceOperationWhenReady(func2)
                return
            end

            if var3 then
                task.cancel(var3)
            end
            var3 = task.delay(FIntPartyVoiceUndeafenDelayMS / 1000, function()
                var3 = nil
                var1:info("UGC OnUndeafenVoiceAudio fired delayed" .. contextId2)
                performVoiceOperationWhenReady(func2)
            end)
        end)

        local function func3(contextId2, focusPriority2) -- Luacid: Inlined by compiler; 1 call site recovered
            var1:info("UGC requestAudioFocusWithPromise - id: {} - priority: {}", contextId2, focusPriority2)
            return Promise.new(function(callback, callback2)
                local success2, result2 = pcall(result.RequestFocus, result, contextId2, focusPriority2)
                if success2 then
                    var1:info("UGC requestAudioFocusWithPromise - focusGranted: {}", result2)
                    callback(result2)
                    return
                end
                var1:info("UGC requestAudioFocusWithPromise - rejected")
                callback2("Failed to call RequestFocus due to an error")
            end)
        end

        local function func4(arg1, arg2)
            if arg1 == nil then
                return
            end

            if arg2 then
                var1:info("UGC audio focus request granted, preparing to undeafen.")
                default:MuteAll(false, "AudioFocusManagement UGC")
                default:ShowVoiceUI()
                return
            end
            var1:info("UGC audio focus requested denied, preparing to deafen.")
            default:MuteAll(true, "AudioFocusManagement UGC")
            default:HideVoiceUI()
        end

        local function func5(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool4 then
                return
            end

            performVoiceOperationWhenReady(function()
                if not bool2 then
                    func4(arg1, arg2)
                end
            end)
            bool4 = true
        end

        func3(contextId, focusPriority):andThen(function(arg1)
            default.muteChanged.Event:Connect(function(arg2)
                if not bool6 then
                    func5(arg2, arg1)
                    bool6 = true
                    return
                end
                func5(arg2, (isConnectedToPublicVoice()))
            end)
        end):catch(function()
            var1:info("[UGC] Error requesting focus inside UGCdatamodel")
        end)
    end

    local canUseServiceResult = default.canUseServiceResult
    if canUseServiceResult then
        initializeAFM()
    elseif canUseServiceResult == nil then
        if bool1 then
            default:subscribe("OnVoiceChatServiceInitialized", function()
                if bool5 then
                    initializeAFM()
                    bool5 = false
                end
            end)
        end

        default:subscribe("OnCanUseServiceResult", function(arg1)
            if arg1 then
                initializeAFM()
                return
            end
            if bool1 then
                bool5 = true
            end
            var1:info("VCSM cannot be used [CEV ExperienceAudioFocusBinder]")
        end)
    else
        var1:info("VCSM cannot be used [CEV ExperienceAudioFocusBinder]")
    end
else
    default:asyncInit():andThen(function()
        local success, result = pcall(function(): AudioFocusService
            return game:GetService("AudioFocusService")
        end)
        if not success or not result then
            return
        end

        local contextId = Constants2.AUDIO_FOCUS_MANAGEMENT.UGC.CONTEXT_ID
        local focusPriority = Constants2.AUDIO_FOCUS_MANAGEMENT.UGC.FOCUS_PRIORITY

        result:RegisterContextIdFromLua(contextId)

        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            default:MuteAll(true, "AudioFocusManagement UGC")
            if not default.localMuted then
                default:ToggleMic("AudioFocusManagement - UGC deafenAll")
            end

            default:HideVoiceUI()
        end

        local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
            default:MuteAll(false, "AudioFocusManagement UGC")
            if not default.localMuted then
                default:ToggleMic("AudioFocusManagement - UGC undeafenAll")
            end

            default:ShowVoiceUI()
        end

        result.OnDeafenVoiceAudio:Connect(function(contextId2: number)
            if contextId2 == contextId then
                var1:info("UGC OnDeafenVoiceAudio fired" .. contextId2)
                func1()
            end
        end)

        result.OnUndeafenVoiceAudio:Connect(function(contextId2: number)
            if contextId2 == contextId then
                var1:info("UGC OnUndeafenVoiceAudio fired" .. contextId2)
                func2()
            end
        end)

        local function func3(contextId2, focusPriority2) -- Luacid: Inlined by compiler; 1 call site recovered
            return Promise.new(function(callback, callback2)
                local success2, result2 = pcall(result.RequestFocus, result, contextId2, focusPriority2)
                if success2 then
                    callback(result2)
                    return
                end
                callback2("Failed to call RequestFocus due to an error")
            end)
        end

        func3(contextId, focusPriority):andThen(function(arg1)
            if arg1 then
                var1:info("UGC audio focus request granted, preparing to undeafen.")
                default.muteChanged.Event:Once(function(arg2)
                    if arg2 ~= nil then
                        default:MuteAll(false, "AudioFocusManagement UGC")
                    end
                end)
                default:ShowVoiceUI()
                return
            end
            var1:info("UGC audio focus requested denied, preparing to deafen.")
            default.muteChanged.Event:Once(function(arg2)
                if arg2 ~= nil then
                    default:MuteAll(true, "AudioFocusManagement UGC")
                end
            end)
            default:HideVoiceUI()
        end):catch(function()
            var1:info("[UGC] Error requesting focus inside UGCdatamodel")
        end)
    end):catch(function()
        var1:info("VCSM was not initialized [CEV ExperienceAudioFocusBinder]")
    end)
end
