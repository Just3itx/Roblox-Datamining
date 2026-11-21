-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCore = script:FindFirstAncestor("DictationCore")
local DictationCoreParent = DictationCore.Parent

local React = require(DictationCoreParent.React)
local SignalsReact = require(DictationCoreParent.SignalsReact)

local useDictation = require(script.Parent.useDictation)
local DictationMode = require(script.Parent.DictationMode)
local DictationInputMode = require(script.Parent.DictationInputMode)
local joinPhrase = require(DictationCore.Utils.joinPhrase)
local useTranscribedSamples = require(DictationCore.UI.useTranscribedSamples)

local useDictation2 = useDictation.useDictation
local DictationState = useDictation.DictationState

local function useDictationInputBar(tbl1)
    local getText = tbl1.getText
    local setText = tbl1.setText
    local onSubmit = tbl1.onSubmit

    local var1 = useTranscribedSamples()

    local var2 = React.useRef(nil)

    local onWaveformSample = React.useCallback(function(current: number, _: number)
        var2.current = current
    end, {})

    local onSpeechStarted = React.useCallback(function(continuous)
        if continuous ~= DictationMode.Continuous then
            return
        end
        if var2.current ~= nil then
            var1.begin(var2.current)
        end
    end, { var1 })

    local onActivityChanged = React.useCallback(function(bool1: boolean)
        if not bool1 then
            var2.current = nil
            var1.reset()
        end
    end, { var1 })

    local onTranscription = React.useCallback(function(str1: string, continuous)
        if continuous == DictationMode.Continuous and var2.current ~= nil then
            var1.commit(var2.current)
        end
        local text = getText()
        if text == nil then
            return
        end
        local var6 = joinPhrase(text, str1)
        setText(var6)
        if continuous == DictationMode.Continuous then
            onSubmit(var6)
        end
    end, {
        getText,
        setText,
        onSubmit,
        var1
    })
    local dictation = useDictation2({
        onTranscription = onTranscription,
        onSpeechStarted = onSpeechStarted,
        onActivityChanged = onActivityChanged,
        onError = tbl1.onError,
        logger = tbl1.logger,
        containerName = tbl1.containerName
    })

    local var8 = SignalsReact.useSignalState(dictation.getDictationState)
    local isAudioActive = var8 == DictationState.Recording or var8 == DictationState.Listening

    local hasText = tbl1.hasText
    local isIdle = dictation.bindings.isIdle
    local isMicVisible = React.useMemo(function()
        return React.joinBindings({ hasText = hasText, isIdle = isIdle }):map(function(arg1): boolean
            return not (arg1.hasText and arg1.isIdle)
        end)
    end, { hasText, isIdle })
    local isSubmitVisible = React.useMemo(function()
        return isMicVisible:map(function(bool2: boolean): boolean
            return not bool2
        end)
    end, { isMicVisible })

    return {
        dictation = dictation,
        inputMode = tbl1.inputMode or DictationInputMode.Standard,
        isAudioActive = isAudioActive,
        isMicVisible = isMicVisible,
        isSubmitVisible = isSubmitVisible,
        onWaveformSample = onWaveformSample,
        transcribedSamplesBinding = var1.binding
    }
end

return useDictationInputBar
