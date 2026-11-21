-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCore = script:FindFirstAncestor("DictationCore")
local DictationCoreParent = DictationCore.Parent

local React = require(DictationCoreParent.React)
local Foundation = require(DictationCoreParent.Foundation)
local Signals = require(DictationCoreParent.Signals)
local SignalsReact = require(DictationCoreParent.SignalsReact)

local DictationState = require(DictationCore.Dictation.useDictation).DictationState
local DictationMode = require(DictationCore.Dictation.DictationMode)
local DictationInputMode = require(DictationCore.Dictation.DictationInputMode)
local DictationAffordances = require(script.Parent.DictationAffordances)
local CountdownRing = require(script.Parent.CountdownRing)
local StopCountdownButton = require(script.Parent.StopCountdownButton)
local useLongPress = require(script.Parent.useLongPress)

local FFlagDictationMicKeepsFocus = require(DictationCore.Flags.FFlagDictationMicKeepsFocus)

local useSignalState = SignalsReact.useSignalState

local signal = Signals.createSignal(false)

local function noop() end

return React.memo(function(tbl1) -- name: MicButton
    local getDictationState = tbl1.getDictationState
    local onStart = tbl1.onStart
    local onStop = tbl1.onStop
    local var1 = tbl1.inputMode or DictationInputMode.Standard
    local isDictationEligible = tbl1.isDictationEligible == nil or tbl1.isDictationEligible
    local var3 = if var1 == DictationInputMode.Continuous then DictationMode.Continuous else DictationMode.Standard
    local var4 = useSignalState(getDictationState)
    local isMicInUseElsewhere = useSignalState(tbl1.getIsMicInUseElsewhere or signal)

    local var6 = React.useCallback(function()
        if getDictationState(false) == DictationState.Idle then
            onStart(var3)
            return
        end
        onStop()
    end, {
        getDictationState,
        onStart,
        onStop,
        var3
    })
    local var7 = React.useCallback(function()
        if getDictationState(false) == DictationState.Idle then
            onStart(DictationMode.Continuous)
        end
    end, { getDictationState, onStart })

    local var8 = useLongPress
    local tbl2 = { onLongPress = 0, onTap = 0 }
    if var1 ~= DictationInputMode.Hybrid then
        var7 = nil
    end

    tbl2.onLongPress = var7
    tbl2.onTap = var6
    local micGestureHandlers = var8(tbl2)

    local tbl3 = {
        isRecording = var4 == DictationState.Recording,
        isTranscribing = var4 == DictationState.Transcribing,
        isListening = var4 == DictationState.Listening,
        isMicInUseElsewhere = isMicInUseElsewhere,
        isDictationEligible = isDictationEligible,
        onMicTap = var6,
        dictation = { cancel = var6 },
        micGestureHandlers = micGestureHandlers
    }

    local var10 = DictationAffordances.deriveMicSendButton(tbl3, {
        hasEmptyInputText = true,
        idleSendIcon = Foundation.Enums.IconName.Microphone,
        idleSendVariant = Foundation.Enums.ButtonVariant.Utility,
        idleSendActivated = nil,
        idleSendDisabled = not isDictationEligible
    })
    local useLongPressOverlay = var10.useLongPressOverlay

    if not FFlagDictationMicKeepsFocus and tbl3.isRecording then
        return React.createElement(StopCountdownButton, { countdownProgress = tbl1.countdownProgress, onActivated = onStop })
    end

    local isRecording = FFlagDictationMicKeepsFocus and tbl3.isRecording
    local countdownProgress = tbl1.countdownProgress

    local button = React.createElement(Foundation.IconButton, {
        icon = if isRecording then Foundation.Enums.IconName.StopSmall else var10.icon,
        size = tbl1.size or Foundation.Enums.InputSize.Small,
        variant = if isRecording then Foundation.Enums.ButtonVariant.Utility else var10.variant,
        isCircular = true,
        testId = tbl1.testId,
        isDisabled = var10.isDisabled,
        Selectable = not useLongPressOverlay and nil,
        onActivated = if useLongPressOverlay then noop else var10.onActivated or noop,
        tag = tbl1.tag
    })

    if not FFlagDictationMicKeepsFocus and micGestureHandlers == nil then
        return button
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Size = UDim2.new()
    }
    local tbl5 = {
        Progress = if isRecording and countdownProgress ~= nil then React.createElement(CountdownRing, { countdownProgress = countdownProgress }) else nil,
        Button = button,
        HoldTarget = 0
    }
    local element2

    if useLongPressOverlay and micGestureHandlers ~= nil then
        element2 = React.createElement("TextButton", {
            Active = true,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = "",
            ZIndex = 2,
            Selectable = true,
            [React.Event.Activated] = micGestureHandlers[React.Event.Activated],
            [React.Event.InputBegan] = micGestureHandlers[React.Event.InputBegan],
            [React.Event.InputEnded] = micGestureHandlers[React.Event.InputEnded]
        })
    else
        element2 = nil
    end

    tbl5.HoldTarget = element2
    return createElement(str1, tbl4, tbl5)
end)
