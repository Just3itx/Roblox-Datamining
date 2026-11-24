-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local ReactOtter = require(ExpChatParent.ReactOtter)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)

local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/Dictation")

local FFlagExpChatDictationStateStore = require(ExpChatParent.SharedFlags).FFlagExpChatDictationStateStore
local GetDictationStateStore = require(ExpChat.Stores.GetDictationStateStore)

local DictationMode = require(script.Parent.DictationMode)
local DictationState = require(script.Parent.DictationState)
local DictationAnalytics = require(script.Parent.DictationAnalytics)
local FFlagExpChatDictationExplicitFinish = require(ExpChat.Flags.FFlagExpChatDictationExplicitFinish)
local useDictationAudioPipeline = require(script.Parent.useDictationAudioPipeline)
local requestMicPermission = require(script.Parent.requestMicPermission)
local requestMicPermission2 = requestMicPermission.requestMicPermission
local PermissionStatus = requestMicPermission.PermissionStatus

local createSignal = Signals.createSignal
local useSignalBinding = SignalsReact.useSignalBinding

local function publishDictationState(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    GetDictationStateStore(false).setDictationState(arg1)
end

local DictationErrorReason = {
    PermissionDenied = "permission_denied",
    TranscriptionFailed = "transcription_failed",
    LanguageUnsupported = "language_unsupported",
    Other = "other"
}

local tbl2 = {
    duration = 10,
    easingStyle = Enum.EasingStyle.Linear
}

local function formatTime(num1: number)
    return string.format("%d:%02d", math.floor(num1 / 60), num1 % 60)
end

local function safeCancelThread(tbl3) -- Luacid: Inlined by compiler; 20 call sites recovered
    if tbl3.current then
        pcall(task.cancel, tbl3.current)
        tbl3.current = nil
    end
end

local function startCountdownTimer(tbl3, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    safeCancelThread(tbl3)

    tbl3.current = task.spawn(function()
        for i = 1, 10 do
            task.wait(1)
            callback(10 - i)
        end
    end)
end

return {
    useDictation = function(current)
        local var2 = React.useMemo(function()
            local get, set = createSignal(DictationState.Idle)
            return { get = get, set = set }
        end, {})
        local get = var2.get
        local set = var2.set

        local var3 = useDictationAudioPipeline()

        local var4, var5 = React.useBinding(0)
        local countdownProgress, var7 = ReactOtter.useAnimatedBinding(0)

        local isRecording = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Recording
        end)
        local isTranscribing = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Transcribing
        end)
        local isBusy = useSignalBinding(function(arg1): boolean
            local var10 = get(arg1)
            return var10 == DictationState.Recording or var10 == DictationState.Transcribing
        end)
        local isIdle = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Idle
        end)
        local isNotRecording = useSignalBinding(function(arg1): boolean
            return get(arg1) ~= DictationState.Recording
        end)
        local isListening = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Listening
        end)
        local isAudioActive = useSignalBinding(function(arg1): boolean
            local var14 = get(arg1)
            return var14 == DictationState.Recording or var14 == DictationState.Listening
        end)

        local var15 = React.useRef(current)
        var15.current = current

        local var16 = React.useRef(false)

        local var17 = React.useRef(false)

        local var18 = React.useRef(nil)
        local var19 = React.useRef(nil)

        local var20 = React.useRef(0)

        local var21 = React.useRef(nil)

        local function transitionTo(arg1)
            local var22 = get(false)
            set(arg1)

            local bool1 = arg1 == DictationState.Recording or arg1 == DictationState.Transcribing or arg1 == DictationState.Listening
            if bool1 ~= var16.current then
                var16.current = bool1
                local current2 = var15.current
                if current2 ~= nil and current2.onActivityChanged ~= nil then
                    current2.onActivityChanged(bool1)
                end
            end

            if arg1 == var22 then
                return
            end

            if FFlagExpChatDictationStateStore then
                publishDictationState(arg1)
            end

            local current2 = var15.current
            if current2 ~= nil and current2.onStateChanged ~= nil then
                current2.onStateChanged(arg1)
            end
        end

        local function fullCleanup(bool1: boolean?) -- Luacid: Inlined by compiler; 6 call sites recovered
            var3.stop(bool1)
            safeCancelThread(var19)
            safeCancelThread(var18)
            var7(ReactOtter.instant(0))
        end

        local function handleError(str1: string, str2: string)
            var1:warning("Dictation: {} ({})", str2, str1)
            local mode = if var21.current then var21.current.mode or nil else nil
            fullCleanup(nil)
            transitionTo(DictationState.Idle)
            local current2 = var15.current
            if current2 ~= nil and current2.onError ~= nil then
                current2.onError(mode, str1)
            end
            var21.current = nil
        end

        React.useEffect(function()
            return function()
                local var22 = var20
                var22.current += 1
                safeCancelThread(var19)
                safeCancelThread(var18)
                if get(false) == DictationState.Idle then
                    return
                end

                if FFlagExpChatDictationStateStore then
                    publishDictationState(DictationState.Idle)
                end
                local current2 = var15.current
                if current2 ~= nil and current2.onStateChanged ~= nil then
                    current2.onStateChanged(DictationState.Idle)
                end
            end
        end, { get })

        local function emitRecordingStop(arg1, num1: number?) -- Luacid: Inlined by compiler; 7 call sites recovered
            local current2 = var21.current
            local current3 = var15.current
            if current3 == nil or current3.onRecordingStop == nil or current2 == nil or current2.startedAt == nil then
                return
            end
            current3.onRecordingStop(current2.mode, arg1, os.clock() - current2.startedAt, num1)
        end

        local var22 = React.useRef(nil)
        local var23 = React.useCallback(function(arg1)
            local var23 = arg1 or DictationAnalytics.TriggerTypes.UserManual
            local var24 = get(false)

            if FFlagExpChatDictationExplicitFinish and var23 == DictationAnalytics.TriggerTypes.SafetyIntervention then
                local var25 = var20
                var25.current += 1
                var3.discardPending()
                if var24 == DictationState.Recording or var24 == DictationState.Transcribing then
                    return
                end

                fullCleanup(true)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var23, nil)
                var21.current = nil
                return
            end
            local bool1 = FFlagExpChatDictationExplicitFinish

            if bool1 then
                if var24 == DictationState.Listening then
                    bool1 = var23 == DictationAnalytics.TriggerTypes.UserManual
                else
                    bool1 = false
                end
            end

            if var24 == DictationState.Listening and not bool1 then
                var1:debug("Dictation: exited continuous mode")
                fullCleanup(true)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var23, nil)
                var21.current = nil
                return
            end

            if var24 ~= DictationState.Recording and not bool1 then
                return
            end

            safeCancelThread(var19)
            safeCancelThread(var18)

            if not var17.current then
                var1:debug("Dictation: no voice activity, returning to idle")
                fullCleanup(nil)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var23, nil)
                var21.current = nil
                return
            end

            if var3.audioDeviceInputRef.current then
                var3.audioDeviceInputRef.current.Muted = true
            end
            if FFlagExpChatDictationExplicitFinish and not var3.finishInput() then
                var1:warning("Dictation: explicit finish unavailable, waiting for muted input to end speech")
            end

            if bool1 then
                var3.drain(5)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var23, nil)
                var21.current = nil
                return
            end

            transitionTo(DictationState.Transcribing)
            var1:debug("Dictation: stopped recording, waiting for transcription")
            emitRecordingStop(var23, nil)

            var19.current = task.delay(5, function()
                handleError(DictationErrorReason.TranscriptionFailed, "transcription timed out")
            end)
        end, { var3, get })
        var22.current = var23

        local startDictation = React.useCallback(function(mode)
            if get(false) ~= DictationState.Idle then
                return
            end
            var21.current = { mode = mode }

            local var24 = var20
            var24.current += 1
            local current2 = var20.current

            local function doStartStandard()
                var17.current = false

                local success, result = pcall(function()
                    var3.start({
                        onTranscription = function(str1: string)
                            var1:debug("Dictation: received transcription: {}", str1)
                            if get(false) == DictationState.Recording then
                                emitRecordingStop(DictationAnalytics.TriggerTypes.AutoPause, #str1)
                            end

                            fullCleanup(nil)
                            transitionTo(DictationState.Idle)
                            local current3 = var15.current
                            if current3 ~= nil and current3.onTranscription ~= nil then
                                current3.onTranscription(str1, DictationMode.Standard)
                            end
                            var21.current = nil
                        end,
                        onSpeechStarted = function()
                            var17.current = true
                        end,
                        onError = function(str1: string)
                            handleError(DictationErrorReason.TranscriptionFailed, str1)
                        end
                    })
                end)

                if not success then
                    handleError(DictationErrorReason.Other, "failed to start recording: " .. tostring(result))

                    return
                end

                transitionTo(DictationState.Recording)
                if var21.current then
                    var21.current.startedAt = os.clock()
                end
                local current3 = var15.current
                if current3 and current3.onRecordingStart then
                    current3.onRecordingStart(DictationMode.Standard, DictationAnalytics.TriggerTypes.UserManual)
                end
                var5(10)

                var7(ReactOtter.instant(1))
                task.defer(function()
                    var7(ReactOtter.ease(0, tbl2))
                end)
                var1:debug("Dictation: started recording")

                startCountdownTimer(var18, var5)

                var19.current = task.delay(10, function()
                    var1:debug("Dictation: max recording time reached, stopping")
                    if var22.current then
                        var22.current(DictationAnalytics.TriggerTypes.TimeUp)
                    end
                end)
            end

            local function doStartContinuous()
                local current3 = var21.current
                if FFlagExpChatDictationExplicitFinish then
                    var17.current = false
                end
                local success, result = pcall(function()
                    var3.start({
                        onTranscription = function(str1: string)
                            var1:debug("Dictation: continuous utterance: {}", str1)
                            local current4 = var15.current
                            if current4 ~= nil and current4.onTranscription ~= nil then
                                current4.onTranscription(str1, DictationMode.Continuous)
                            end
                        end,
                        onSpeechStarted = function()
                            if FFlagExpChatDictationExplicitFinish and var21.current ~= current3 then
                                return
                            end
                            if FFlagExpChatDictationExplicitFinish then
                                var17.current = true
                            end
                            local current4 = var15.current
                            if current4 ~= nil and current4.onSpeechStarted ~= nil then
                                current4.onSpeechStarted(DictationMode.Continuous)
                            end
                        end,
                        onError = function(str1: string)
                            if FFlagExpChatDictationExplicitFinish and var21.current ~= current3 then
                                return
                            end

                            handleError(DictationErrorReason.TranscriptionFailed, str1)
                        end
                    }, { continuous = true })
                end)

                if not success then
                    handleError(DictationErrorReason.Other, "failed to enter continuous mode: " .. tostring(result))

                    return
                end

                transitionTo(DictationState.Listening)
                if var21.current then
                    var21.current.startedAt = os.clock()
                end
                local current4 = var15.current
                if current4 and current4.onRecordingStart then
                    current4.onRecordingStart(DictationMode.Continuous, DictationAnalytics.TriggerTypes.UserManual)
                end
                var1:debug("Dictation: entered continuous mode")
            end
            local function isStalePermissionRequest(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
                return var20.current ~= current2
            end

            requestMicPermission2():andThen(function(arg1)
                if isStalePermissionRequest() then
                    return
                end
                local current3 = var15.current
                if current3 ~= nil and current3.onPermissionResolved ~= nil then
                    current3.onPermissionResolved(arg1.status, mode)
                end
                if arg1.status == PermissionStatus.Denied then
                    handleError(
                        DictationErrorReason.PermissionDenied,
                        if arg1.error then "microphone permission denied: " .. arg1.error else "microphone permission denied"
                    )
                    return
                end

                if mode == DictationMode.Continuous then
                    doStartContinuous()
                else
                    doStartStandard()
                end
            end):catch(function(arg1)
                if isStalePermissionRequest() then
                    return
                end

                handleError(DictationErrorReason.PermissionDenied, "mic permission request failed: " .. tostring(arg1))
            end)
        end, { var3, get })

        local cancel = React.useCallback(function()
            var1:debug("Dictation: cancelled")

            local var25 = var20
            var25.current += 1
            fullCleanup(true)
            transitionTo(DictationState.Idle)
            emitRecordingStop(DictationAnalytics.TriggerTypes.UserManual, nil)
            var21.current = nil
        end, {})

        local countdownText = var4:map(function(num1: number)
            return formatTime(num1)
        end)

        local bindings = React.useMemo(function()
            return {
                isRecording = isRecording,
                isNotRecording = isNotRecording,
                isTranscribing = isTranscribing,
                isBusy = isBusy,
                isIdle = isIdle,
                isListening = isListening,
                isAudioActive = isAudioActive,
                countdownText = countdownText,
                countdownProgress = countdownProgress
            }
        end, {
            countdownText,
            countdownProgress,
            isAudioActive,
            isBusy,
            isIdle,
            isListening,
            isNotRecording,
            isRecording,
            isTranscribing
        })

        return {
            getDictationState = get,
            startDictation = startDictation,
            stopDictation = var23,
            cancel = cancel,
            audioDeviceInput = var3.audioDeviceInput,
            bindings = bindings
        }
    end,
    DictationState = DictationState,
    DictationErrorReason = DictationErrorReason,
    formatTime = formatTime,
    MAX_RECORDING_SECONDS = 10
}
