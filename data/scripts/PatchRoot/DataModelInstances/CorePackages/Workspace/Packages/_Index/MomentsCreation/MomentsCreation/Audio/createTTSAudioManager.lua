-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local classifyTTSError = require(MomentsCreation.Audio.classifyTTSError)
local normalizeWaveform = require(MomentsCreation.Audio.normalizeWaveform)

local GetFIntMomentsTTSWaveformSamplesPerSecond = require(MomentsCreation.Flags.GetFIntMomentsTTSWaveformSamplesPerSecond)
local GetFIntMomentsTTSWaveformMinSamples = require(MomentsCreation.Flags.GetFIntMomentsTTSWaveformMinSamples)
local GetFIntMomentsTTSWaveformMaxSamples = require(MomentsCreation.Flags.GetFIntMomentsTTSWaveformMaxSamples)
local audioDuckingFastInts = require(MomentsCreationParent.MomentsCommon).Media.audioDuckingFastInts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local createSignal = Signals.createSignal

local function defaultCreateTtsInstance(arg1)
    if not game:GetEngineFeature("TextToSpeechPlatformPreview") then
        return nil
    end

    if arg1 == nil then
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            return nil
        end
        arg1 = localPlayer:FindFirstChildOfClass("PlayerGui")
        if arg1 == nil then
            return nil
        end
    end

    local ttsSharedGraph = Instance.new("Folder")
    ttsSharedGraph.Name = "TTSSharedGraph"

    local audioTextToSpeech = Instance.new("AudioTextToSpeech")
    audioTextToSpeech.Volume = audioDuckingFastInts.getTtsVolume()
    audioTextToSpeech.Parent = ttsSharedGraph

    local audioDeviceOutput = Instance.new("AudioDeviceOutput")
    audioDeviceOutput.Parent = ttsSharedGraph

    local wire = Instance.new("Wire")
    wire.SourceInstance = audioTextToSpeech
    wire.TargetInstance = audioDeviceOutput
    wire.Parent = ttsSharedGraph

    ttsSharedGraph.Parent = arg1

    return audioTextToSpeech
end

local function createTTSAudioManager(func1: ((...any) -> (...any))?, arg1)
    local var1 = func1 or function()
        return (defaultCreateTtsInstance(arg1))
    end

    local getState, var3 = createSignal("idle")
    local getErrorReason, var5 = createSignal(nil)
    local getTimeLength, var7 = createSignal(0)
    local getTimePosition, var9 = createSignal(0)
    local getIsLoaded, var11 = createSignal(false)
    local getLoadedText, var13 = createSignal("")
    local getLoadedVoiceId, var15 = createSignal(0)
    local getWaveform, var17 = createSignal({})

    local var18 = nil
    local parent = nil
    local num1 = 0
    local connection = nil
    local connection2 = nil
    local bool1 = false

    local function stopTimeTracking() -- Luacid: Inlined by compiler; 8 call sites recovered
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    local function startTimeTracking() -- Luacid: Inlined by compiler; 1 call site recovered
        stopTimeTracking()

        connection = RunService.RenderStepped:Connect(function()
            if var18 then
                var9(var18.TimePosition)
            end
        end)
    end

    local function ensureGraph() -- Luacid: Inlined by compiler; 1 call site recovered
        if var18 ~= nil then
            return var18
        end

        local var19 = var1()
        if var19 == nil then
            return nil
        end

        var18 = var19

        parent = var19.Parent

        connection2 = var19.Ended:Connect(function()
            if bool1 then
                return
            end
            var3("ready")
            var9(0)
            stopTimeTracking()
        end)

        return var19
    end

    local function failGeneration(arg2)
        var13("")
        var15(0)
        var11(false)
        var7(0)
        var17({})
        var5(arg2)
        var3("error")
    end

    return {
        getState = getState,
        getErrorReason = getErrorReason,
        getTimeLength = getTimeLength,
        getTimePosition = getTimePosition,
        getIsLoaded = getIsLoaded,
        getLoadedText = getLoadedText,
        getLoadedVoiceId = getLoadedVoiceId,
        getWaveform = getWaveform,
        generate = function(text: string, num2: number)
            if bool1 or text == getLoadedText(false) and num2 == getLoadedVoiceId(false) and getState(false) ~= "error" then
                return
            end

            local var19 = ensureGraph()

            if not var19 then
                var5("failure")
                var3("error")
                return
            end

            num1 += 1
            local num3 = num1

            var19:Pause()
            stopTimeTracking()
            var5(nil)
            var3("loading")
            var9(0)
            var17({})

            var13("")
            var15(0)

            task.spawn(function()
                if bool1 then
                    return
                end

                var19.Text = text
                var19.VoiceId = tostring(num2)

                local success, result = pcall(function()
                    return var19:LoadPlatformAsync()
                end)

                if bool1 or num1 ~= num3 then
                    return
                end

                if not success then
                    failGeneration(classifyTTSError(result))
                    return
                end

                if result ~= Enum.AssetFetchStatus.Success then
                    failGeneration("failure")
                    return
                end

                local num4 = math.clamp(
                    math.round(var19.TimeLength * GetFIntMomentsTTSWaveformSamplesPerSecond()),
                    GetFIntMomentsTTSWaveformMinSamples(),
                    GetFIntMomentsTTSWaveformMaxSamples()
                )
                local success2, result2 = pcall(function()
                    return var19:GetWaveformAsync(NumberRange.new(0, var19.TimeLength), num4)
                end)
                if bool1 or num1 ~= num3 then
                    return
                end

                var13(text)
                var15(num2)
                var7(var19.TimeLength)
                var11(true)
                var9(0)
                if success2 and type(result2) == "table" then
                    var17(normalizeWaveform(result2))
                end
                var3("ready")
            end)
        end,
        play = function()
            if bool1 then
                return
            end
            local var19 = var18
            if var19 and var19.IsLoaded then
                var19:Play()
                var3("playing")
                startTimeTracking()
            end
        end,
        pause = function()
            if bool1 then
                return
            end
            local var19 = var18
            if not var19 then
                return
            end

            var19:Pause()
            stopTimeTracking()

            if getState(false) == "playing" then
                var3("ready")
            end
        end,
        seek = function(num2: number)
            if bool1 then
                return
            end
            local var19 = var18
            if var19 then
                local timePosition = math.clamp(num2, 0, (getTimeLength(false)))
                var19.TimePosition = timePosition
                var9(timePosition)
            end
        end,
        setVolume = function(volume: number)
            if bool1 then
                return
            end
            local var19 = var18
            if var19 then
                var19.Volume = volume
            end
        end,
        reset = function()
            if bool1 then
                return
            end

            num1 += 1
            if var18 then
                var18:Pause()
            end

            stopTimeTracking()
            var5(nil)
            var3("idle")
            var9(0)
            var7(0)
            var11(false)
            var13("")
            var15(0)
            var17({})
        end,
        destroy = function()
            if bool1 then
                return
            end
            bool1 = true
            stopTimeTracking()

            if connection2 then
                connection2:Disconnect()
                connection2 = nil
            end

            if parent then
                parent:Destroy()
                parent = nil
            end

            var18 = nil
        end
    }
end
return createTTSAudioManager
