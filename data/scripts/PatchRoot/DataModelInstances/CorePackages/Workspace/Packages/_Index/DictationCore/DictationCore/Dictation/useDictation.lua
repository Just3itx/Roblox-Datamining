-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCore = script:FindFirstAncestor("DictationCore")
local DictationCoreParent = DictationCore.Parent

local React = require(DictationCoreParent.React)
local ReactOtter = require(DictationCoreParent.ReactOtter)
local Signals = require(DictationCoreParent.Signals)
local SignalsReact = require(DictationCoreParent.SignalsReact)

local DictationMode = require(script.Parent.DictationMode)
local DictationTriggerTypes = require(script.Parent.DictationTriggerTypes)
local FFlagDictationSharedMic = require(DictationCore.Flags.FFlagDictationSharedMic)
local FFlagDictationExplicitFinish = require(DictationCore.Flags.FFlagDictationExplicitFinish)
local GetMicStore = require(DictationCore.Stores.GetMicStore)
local useDictationAudioPipeline = require(script.Parent.useDictationAudioPipeline)
local requestMicPermission = require(script.Parent.requestMicPermission)
local requestMicPermission2 = requestMicPermission.requestMicPermission
local PermissionStatus = requestMicPermission.PermissionStatus

local createSignal = Signals.createSignal
local useSignalBinding = SignalsReact.useSignalBinding

local DictationState = require(script.Parent.DictationState)

local DictationErrorReason = require(script.Parent.DictationErrorReason)

local tbl1 = {
    debug = function() end,
    warning = function() end
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
        local var1 = React.useMemo(function()
            local get, set = createSignal(DictationState.Idle)
            return { get = get, set = set }
        end, {})
        local get = var1.get
        local set = var1.set

        local micStore = GetMicStore(false)
        local var2 = React.useMemo(function()
            return micStore.createHolderId()
        end, { micStore })

        local getIsMicInUseElsewhere = React.useCallback(function(arg1): boolean
            local holderId = micStore.getHolderId(arg1)
            return not (holderId == nil) and holderId ~= var2
        end, { micStore, var2 })

        local var4 = useDictationAudioPipeline()

        local var5, var6 = React.useBinding(0)
        local countdownProgress, var8 = ReactOtter.useAnimatedBinding(0)

        local isRecording = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Recording
        end)
        local isTranscribing = useSignalBinding(function(arg1): boolean
            return get(arg1) == DictationState.Transcribing
        end)
        local isBusy = useSignalBinding(function(arg1): boolean
            local var11 = get(arg1)
            return var11 == DictationState.Recording or var11 == DictationState.Transcribing
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
            local var15 = get(arg1)
            return var15 == DictationState.Recording or var15 == DictationState.Listening
        end)

        local var16 = React.useRef(current)
        var16.current = current

        local function getLogger() -- Luacid: Inlined by compiler; 11 call sites recovered
            local current2 = var16.current
            return current2 ~= nil and current2.logger or tbl1
        end

        local var17 = React.useRef(false)

        local var18 = React.useRef(false)

        local var19 = React.useRef(nil)
        local var20 = React.useRef(nil)

        local var21 = React.useRef(0)

        local var22 = React.useRef(nil)

        local function transitionTo(arg1)
            set(arg1)

            if not FFlagDictationSharedMic and arg1 ~= DictationState.Recording and arg1 ~= DictationState.Listening then
                micStore.drop(var2)
            end

            local bool1 = arg1 == DictationState.Recording or arg1 == DictationState.Transcribing or arg1 == DictationState.Listening
            if bool1 == var17.current then
                return
            end

            var17.current = bool1
            local current2 = var16.current
            if current2 ~= nil and current2.onActivityChanged ~= nil then
                current2.onActivityChanged(bool1)
            end
        end

        local function fullCleanup(bool1: boolean?) -- Luacid: Inlined by compiler; 6 call sites recovered
            var4.stop(bool1)
            safeCancelThread(var20)
            safeCancelThread(var19)
            var8(ReactOtter.instant(0))
        end

        local function handleError(arg1, str1: string)
            getLogger():warning("Dictation: {} ({})", str1, arg1)
            local mode = if var22.current then var22.current.mode else nil
            fullCleanup(nil)
            transitionTo(DictationState.Idle)
            local current2 = var16.current
            if current2 ~= nil and current2.onError ~= nil then
                current2.onError(mode, arg1)
            end
            var22.current = nil
        end

        React.useEffect(function()
            return function()
                local var23 = var21
                var23.current += 1
                safeCancelThread(var20)
                safeCancelThread(var19)
                if not FFlagDictationSharedMic then
                    micStore.drop(var2)
                end
            end
        end, {})

        local function emitRecordingStop(arg1, num1: number?) -- Luacid: Inlined by compiler; 7 call sites recovered
            local current2 = var22.current
            local current3 = var16.current
            if current3 == nil or current3.onRecordingStop == nil or current2 == nil or current2.startedAt == nil then
                return
            end
            current3.onRecordingStop(current2.mode, arg1, os.clock() - current2.startedAt, num1)
        end

        local var23 = React.useRef(nil)
        local var24 = React.useCallback(function(arg1)
            local var24 = arg1 or DictationTriggerTypes.UserManual
            local var25 = get(false)
            if FFlagDictationExplicitFinish and var24 == DictationTriggerTypes.SafetyIntervention then
                local var26 = var21
                var26.current += 1
                var4.discardPending()
                if var25 == DictationState.Recording or var25 == DictationState.Transcribing then
                    return
                end

                fullCleanup(true)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var24, nil)
                var22.current = nil
                return
            end
            local bool1 = FFlagDictationExplicitFinish

            if bool1 then
                if var25 == DictationState.Listening then
                    bool1 = var24 == DictationTriggerTypes.UserManual
                else
                    bool1 = false
                end
            end

            if var25 == DictationState.Listening and not bool1 then
                getLogger():debug("Dictation: exited continuous mode")
                fullCleanup(true)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var24, nil)
                var22.current = nil
                return
            end

            if var25 ~= DictationState.Recording and not bool1 then
                return
            end

            safeCancelThread(var20)
            safeCancelThread(var19)

            if not var18.current then
                getLogger():debug("Dictation: no voice activity, returning to idle")
                fullCleanup(nil)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var24, nil)
                var22.current = nil
                return
            end

            if var4.audioDeviceInputRef.current then
                var4.audioDeviceInputRef.current.Muted = true
            end
            if FFlagDictationExplicitFinish and not var4.finishInput() then
                getLogger():warning("Dictation: explicit finish unavailable, waiting for muted input to end speech")
            end

            if bool1 then
                var4.drain(5)
                transitionTo(DictationState.Idle)
                emitRecordingStop(var24, nil)
                var22.current = nil
                return
            end

            transitionTo(DictationState.Transcribing)
            getLogger():debug("Dictation: stopped recording, waiting for transcription")
            emitRecordingStop(var24, nil)

            var20.current = task.delay(5, function()
                handleError(DictationErrorReason.TranscriptionFailed, "transcription timed out")
            end)
        end, { var4, get })
        var23.current = var24

        local var25 = React.useCallback(function()
            local var25 = get(false)
            if var25 == DictationState.Recording or var25 == DictationState.Listening then
                if var23.current then
                    var23.current(DictationTriggerTypes.MicStolen)
                end
            else
                local var26 = var21
                var26.current += 1
                var22.current = nil
            end
        end, { get })

        local startDictation = React.useCallback(function(mode)
            if get(false) ~= DictationState.Idle or not FFlagDictationSharedMic and not micStore.hold(var2, var25) then
                return
            end

            var22.current = { mode = mode }

            local var26 = var21
            var26.current += 1
            local current2 = var21.current

            local function doStartStandard()
                var18.current = false

                local success, result = pcall(function()
                    var4.start({
                        onTranscription = function(str1: string)
                            getLogger():debug("Dictation: received transcription: {}", str1)
                            if get(false) == DictationState.Recording then
                                emitRecordingStop(DictationTriggerTypes.AutoPause, #str1)
                            end

                            fullCleanup(nil)
                            transitionTo(DictationState.Idle)
                            local current3 = var16.current
                            if current3 ~= nil and current3.onTranscription ~= nil then
                                current3.onTranscription(str1, DictationMode.Standard)
                            end
                            var22.current = nil
                        end,
                        onSpeechStarted = function()
                            var18.current = true
                        end,
                        onError = function(str1: string)
                            handleError(DictationErrorReason.TranscriptionFailed, str1)
                        end
                    }, {
                        containerName = var16.current and var16.current.containerName
                    })
                end)
                if not success then
                    handleError(DictationErrorReason.Other, "failed to start recording: " .. tostring(result))

                    return
                end

                transitionTo(DictationState.Recording)
                if var22.current then
                    var22.current.startedAt = os.clock()
                end
                local current3 = var16.current
                if current3 and current3.onRecordingStart then
                    current3.onRecordingStart(DictationMode.Standard, DictationTriggerTypes.UserManual)
                end
                var6(10)

                var8(ReactOtter.instant(1))
                task.defer(function()
                    var8((ReactOtter.ease(0, tbl2)))
                end)
                getLogger():debug("Dictation: started recording")

                startCountdownTimer(var19, var6)

                var20.current = task.delay(10, function()
                    getLogger():debug("Dictation: max recording time reached, stopping")
                    if var23.current then
                        var23.current(DictationTriggerTypes.TimeUp)
                    end
                end)
            end

            local function doStartContinuous()
                local current3 = var22.current
                if FFlagDictationExplicitFinish then
                    var18.current = false
                end
                local success, result = pcall(function()
                    var4.start({
                        onTranscription = function(str1: string)
                            getLogger():debug("Dictation: continuous utterance: {}", str1)
                            local current4 = var16.current
                            if current4 ~= nil and current4.onTranscription ~= nil then
                                current4.onTranscription(str1, DictationMode.Continuous)
                            end
                        end,
                        onSpeechStarted = function()
                            if FFlagDictationExplicitFinish and var22.current ~= current3 then
                                return
                            end
                            if FFlagDictationExplicitFinish then
                                var18.current = true
                            end
                            local current4 = var16.current
                            if current4 ~= nil and current4.onSpeechStarted ~= nil then
                                current4.onSpeechStarted(DictationMode.Continuous)
                            end
                        end,
                        onError = function(str1: string)
                            if FFlagDictationExplicitFinish and var22.current ~= current3 then
                                return
                            end

                            handleError(DictationErrorReason.TranscriptionFailed, str1)
                        end
                    }, {
                        continuous = true,
                        containerName = var16.current and var16.current.containerName
                    })
                end)

                if not success then
                    handleError(DictationErrorReason.Other, "failed to enter continuous mode: " .. tostring(result))

                    return
                end

                transitionTo(DictationState.Listening)
                if var22.current then
                    var22.current.startedAt = os.clock()
                end
                local current4 = var16.current
                if current4 and current4.onRecordingStart then
                    current4.onRecordingStart(DictationMode.Continuous, DictationTriggerTypes.UserManual)
                end
                getLogger():debug("Dictation: entered continuous mode")
            end
            local function isStalePermissionRequest(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
                return var21.current ~= current2
            end

            requestMicPermission2():andThen(function(arg1)
                if isStalePermissionRequest() then
                    return
                end
                local current3 = var16.current
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
        end, {
            var4,
            get,
            micStore,
            var2,
            var25
        })
        local cancel = React.useCallback(function()
            getLogger():debug("Dictation: cancelled")

            local var27 = var21
            var27.current += 1
            fullCleanup(true)
            transitionTo(DictationState.Idle)
            emitRecordingStop(DictationTriggerTypes.UserManual, nil)
            var22.current = nil
        end, {})

        local countdownText = var5:map(function(num1: number)
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
            getIsMicInUseElsewhere = getIsMicInUseElsewhere,
            startDictation = startDictation,
            stopDictation = var24,
            cancel = cancel,
            audioDeviceInput = var4.audioDeviceInput,
            bindings = bindings
        }
    end,
    DictationState = DictationState,
    DictationErrorReason = DictationErrorReason,
    formatTime = formatTime,
    MAX_RECORDING_SECONDS = 10
}
