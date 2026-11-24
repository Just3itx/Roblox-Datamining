-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local FFlagDictationAudioDeviceInputEnabled = require(ExpChatParent.SharedFlags).FFlagDictationAudioDeviceInputEnabled
local finishDictationInput = require(script.Parent.finishDictationInput)
local prepareDictationInput = require(script.Parent.prepareDictationInput)
local setDictationUsageType = require(script.Parent.setDictationUsageType)
local FFlagExpChatDictationExplicitFinish = require(ExpChat.Flags.FFlagExpChatDictationExplicitFinish)

local bool1 = game:DefineFastFlag("EngineAudioSTTIsDictationEnabled", false)
local bool2 = game:DefineFastFlag("ExpChatDictationSendUsageType", false)
local FFlagExpChatDictationStreamingAudio = require(ExpChat.Flags.FFlagExpChatDictationStreamingAudio)

local function destroyIfExists(tbl1) -- Luacid: Inlined by compiler; 24 call sites recovered
    if tbl1.current then
        tbl1.current:Destroy()
        tbl1.current = nil
    end
end

local function disconnectIfExists(tbl1) -- Luacid: Inlined by compiler; 13 call sites recovered
    if tbl1.current then
        tbl1.current:Disconnect()
        tbl1.current = nil
    end
end

local function teardownInstances(tbl1) -- Luacid: Inlined by compiler; 5 call sites recovered
    disconnectIfExists(tbl1.textConnection)
    disconnectIfExists(tbl1.vadConnection)
    destroyIfExists(tbl1.wire)
    destroyIfExists(tbl1.audioSTT)
    destroyIfExists(tbl1.audioDeviceInput)
    destroyIfExists(tbl1.container)
end

local function teardownPending(current)
    for value, value2 in current do
        pcall(task.cancel, value2)
        teardownInstances(value)
        current[value] = nil
    end
end

local function useDictationAudioPipeline()
    local audioDeviceInput, var2 = React.useState(nil)

    local var3 = React.useRef({})
    local var4 = React.useRef(nil)
    local audioStt = React.useRef(nil)
    local wire = React.useRef(nil)
    local container = React.useRef(nil)
    local textConnection = React.useRef(nil)
    local vadConnection = React.useRef(nil)

    local var10 = React.useMemo(function()
        return {
            audioDeviceInput = var4,
            audioSTT = audioStt,
            wire = wire,
            container = container,
            textConnection = textConnection,
            vadConnection = vadConnection
        }
    end, {})

    local stop = React.useCallback(function(bool3: boolean?)
        teardownInstances(var10)
        if bool3 then
            teardownPending(var3.current)
        end
        var2(nil)
    end, { var10 })

    local drain = React.useCallback(function(num1: number)
        local tbl1 = {
            audioDeviceInput = {
                current = var10.audioDeviceInput.current
            },
            audioSTT = {
                current = var10.audioSTT.current
            },
            wire = {
                current = var10.wire.current
            },
            container = {
                current = var10.container.current
            },
            textConnection = {
                current = var10.textConnection.current
            },
            vadConnection = {
                current = var10.vadConnection.current
            }
        }
        var10.audioDeviceInput.current = nil
        var10.audioSTT.current = nil
        var10.wire.current = nil
        var10.container.current = nil
        var10.textConnection.current = nil
        var10.vadConnection.current = nil
        disconnectIfExists(tbl1.vadConnection)
        var3.current[tbl1] = task.delay(num1, function()
            var3.current[tbl1] = nil
            teardownInstances(tbl1)
        end)
        var2(nil)
    end, { var10 })

    local start = React.useCallback(function(tbl1, tbl2): AudioDeviceInput
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            error("No local player")
        end

        teardownInstances(var10)
        local bool3 = not (tbl2 == nil) and tbl2.continuous == true
        local expChatDictation = Instance.new("Folder")
        expChatDictation.Name = "ExpChatDictation"
        expChatDictation.Parent = CoreGui
        var10.container.current = expChatDictation

        local audioDeviceInput = Instance.new("AudioDeviceInput")
        if FFlagDictationAudioDeviceInputEnabled then
            pcall(function()
                audioDeviceInput.DictationEnabled = true
            end)
        end
        audioDeviceInput.Player = localPlayer
        audioDeviceInput.Muted = false
        if FFlagExpChatDictationStreamingAudio and bool3 then
            audioDeviceInput.Streaming = true
        end
        audioDeviceInput.Parent = expChatDictation
        audioDeviceInput.Active = true
        var10.audioDeviceInput.current = audioDeviceInput

        local audioSpeechToText = Instance.new("AudioSpeechToText")
        if FFlagExpChatDictationStreamingAudio and bool3 then
            audioSpeechToText.Streaming = true
        end

        if bool1 then
            audioSpeechToText.DictationEnabled = true
        end
        if bool2 then
            setDictationUsageType(audioSpeechToText, bool3)
        end
        if FFlagExpChatDictationExplicitFinish then
            prepareDictationInput(audioSpeechToText)
        end
        audioSpeechToText.Enabled = true
        audioSpeechToText.Parent = expChatDictation
        var10.audioSTT.current = audioSpeechToText

        local wire = Instance.new("Wire")
        wire.SourceInstance = audioDeviceInput
        wire.TargetInstance = audioSpeechToText
        wire.Parent = expChatDictation
        var10.wire.current = wire

        var10.textConnection.current = audioSpeechToText:GetPropertyChangedSignal("Text"):Connect(function()
            local audioSpeechToTextText = audioSpeechToText.Text
            if not audioSpeechToTextText or audioSpeechToTextText == "" then
                return
            end

            if bool3 then
                audioSpeechToText.Text = ""
            end
            tbl1.onTranscription(audioSpeechToTextText)
        end)

        if tbl1.onSpeechStarted then
            local onSpeechStarted = tbl1.onSpeechStarted
            var10.vadConnection.current = audioSpeechToText:GetPropertyChangedSignal("VoiceDetected"):Connect(function()
                if audioSpeechToText.VoiceDetected then
                    onSpeechStarted()
                end
            end)
        end

        var2(audioDeviceInput)
        return audioDeviceInput
    end, { var10 })

    React.useEffect(function()
        return function()
            teardownInstances(var10)
            teardownPending(var3.current)
        end
    end, { var10 })

    return React.useMemo(function()
        return {
            start = start,
            finishInput = function()
                return finishDictationInput(var10.audioSTT.current)
            end,
            stop = stop,
            drain = drain,
            discardPending = function()
                teardownPending(var3.current)
            end,
            audioDeviceInput = audioDeviceInput,
            audioDeviceInputRef = var4
        }
    end, {
        start,
        stop,
        drain,
        audioDeviceInput,
        var10
    })
end
return useDictationAudioPipeline
