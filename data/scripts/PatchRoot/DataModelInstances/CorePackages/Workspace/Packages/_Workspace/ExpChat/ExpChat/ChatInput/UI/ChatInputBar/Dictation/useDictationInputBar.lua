-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local FFlagExpChatDictationExplicitFinish = require(ExpChat.Flags.FFlagExpChatDictationExplicitFinish)

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)
local useAsync = require(ExpChatParent.ReactUtils).useAsync
local SignalsReact = require(ExpChatParent.SignalsReact)
local SetUIBloxToast = require(ExpChatParent.NotificationModalsManager).SetUIBloxToast

local LinkingProtocol = require(ExpChatParent.LinkingProtocol)
local default = LinkingProtocol.LinkingProtocol.default
local SettingsRoute = LinkingProtocol.Enums.SettingsRoute

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagExpChatLongPressContinuousDictation = SharedFlags.FFlagExpChatLongPressContinuousDictation

local var1 = SharedFlags.FFlagExpChatContinuousDictation or FFlagExpChatLongPressContinuousDictation

local FFlagExpChatDictationVoiceTypingModeSetting = SharedFlags.FFlagExpChatDictationVoiceTypingModeSetting
local FFlagExpChatDictationContinuousSafetyReminder = SharedFlags.FFlagExpChatDictationContinuousSafetyReminder
local FFlagExpChatDictationStopOnSafetyIntervention = SharedFlags.FFlagExpChatDictationStopOnSafetyIntervention
local FFlagEnableRetryForLinkingProtocolFetch = SharedFlags.FFlagEnableRetryForLinkingProtocolFetch
local FIntLinkingProtocolFetchRetries = SharedFlags.FIntLinkingProtocolFetchRetries
local FIntLinkingProtocolFetchTimeoutMS = SharedFlags.FIntLinkingProtocolFetchTimeoutMS
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatDictationFTUX = require(ExpChat.Flags.FFlagExpChatDictationFTUX)
local FFlagExpChatDictationU13PolicyToast = require(ExpChat.Flags.FFlagExpChatDictationU13PolicyToast)
local FFlagExpChatDictationMicToastFix = require(ExpChat.Flags.FFlagExpChatDictationMicToastFix)
local FFlagExpChatDictationStopOnRateLimit = require(ExpChat.Flags.FFlagExpChatDictationStopOnRateLimit)
local bool1 = game:DefineFastFlag("ExpChatDictationMicToastAnalytics", false)

local tbl1 = { "CoreScripts.TextChat.ChatWindow.TranscriptionNoMicAccessToastBody", "CoreScripts.TextChat.ChatWindow.TranscriptionNoMicAccessToastBodyAlternate" }

local noMicAccessToastBody = tbl1[game:DefineFastInt("ExpChatDictationNoMicAccessToastBodyKeyIndex", 1)] or tbl1[1]

local engineFeature = FFlagExpChatDictationMicToastFix and game:GetEngineFeature("LinkingResumeOnDataModelThread")

local Localization = require(ExpChat.Localization)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetDictationModeSettingStore = require(ExpChat.Stores.GetDictationModeSettingStore)
local experienceChatInterventionShownSignal = require(ExpChatParent.InterventionShared.experienceChatInterventionShownSignal)

local Parent = require(script.Parent)
local DictationMode = require(script.Parent.DictationMode)
local DictationAnalytics = require(script.Parent.DictationAnalytics)
local DictationRateLimit = require(script.Parent.DictationRateLimit)
local useDictationFTUX = require(script.Parent.useDictationFTUX)
local useDictationTelemetry = require(script.Parent.useDictationTelemetry)
local useTranscribedSamples = require(script.Parent.useTranscribedSamples)
local useDictationEligibility = require(script.Parent.useDictationEligibility)
local useIsLocalUserUnder13 = require(script.Parent.useIsLocalUserUnder13)
local useLongPress = require(script.Parent.Parent.useLongPress)
local U13PolicyToastStorage = require(script.Parent.U13PolicyToastStorage)
local DictationSafetyReminder = require(script.Parent.DictationSafetyReminder)
local PermissionStatus = require(script.Parent.requestMicPermission).PermissionStatus

local DictationState = Parent.DictationState
local DictationErrorReason = Parent.DictationErrorReason
local useDictation = Parent.useDictation

local function getTapDictationMode() -- Luacid: Inlined by compiler; 1 call site recovered
    return if FFlagExpChatLongPressContinuousDictation then DictationMode.Standard elseif var1 then DictationMode.Continuous else DictationMode.Standard
end

local function getLongPressDictationMode() -- Luacid: Inlined by compiler; 1 call site recovered
    return if FFlagExpChatDictationVoiceTypingModeSetting then nil elseif FFlagExpChatLongPressContinuousDictation then DictationMode.Continuous else nil
end

local function getSystemMessageChannelName(targetTextChannel, isGlobalChatTabActive: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    return if GetFFlagTextChatEnableUniverseChatTabs() and isGlobalChatTabActive then "RBXGlobal" elseif targetTextChannel then targetTextChannel.Name else "RBXGeneral"
end

local function useDictationInputBar(tbl2)
    local var2 = Foundation.Hooks.useTokens()

    local micCursor = Foundation.Hooks.useCursor(
        {
            radius = UDim.new(0, var2.Radius.Circle),
            offset = var2.Size.Size_150,
            borderWidth = var2.Stroke.Thicker
        }
    )
    local var4 = React.useRef(false)

    local micButtonSlotRef = React.useRef(nil)
    local var6 = if FFlagExpChatDictationFTUX then React.useRef(nil) else nil
    local var7 = if FFlagExpChatDictationFTUX then React.useRef(false) else nil
    local var8 = useDictationTelemetry()
    local var9 = if bool1 then React.useRef(nil) else nil

    local onActivated = if bool1 then React.useCallback(function()
        var8.logMicToastActivated(var9.current, false)
    end, { var8.logMicToastActivated }) else nil

    local var11 = useDictationEligibility()
    local var12 = useIsLocalUserUnder13()
    local var13 = React.useRef(U13PolicyToastStorage.hasBeenShown())

    local var14 = useAsync(function()
        if not engineFeature then
            return false
        end
        if not FFlagEnableRetryForLinkingProtocolFetch then
            local var14, var15 = default:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
            return var14 and var15 == true
        end

        local bool2 = false
        local var14 = nil
        for _ = 0, FIntLinkingProtocolFetchRetries do
            local var15 = task.spawn(function()
                bool2, var14 = default:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
            end)
            task.wait(FIntLinkingProtocolFetchTimeoutMS / 1000)

            if coroutine.status(var15) ~= "dead" then
                task.cancel(var15)
            end
            if var14 ~= nil then
                break
            end
        end

        return bool2 and var14 == true
    end, {})

    local var15 = Localization.useLocalization({
        transcriptionFailedText = "CoreScripts.TextChat.ChatWindow.TranscriptionFailed",
        transcriptionLanguageUnsupportedText = "CoreScripts.TextChat.ChatWindow.TranscriptionLanguageUnsupported",
        noMicAccessToastHeader = "CoreScripts.TextChat.ChatWindow.TranscriptionNoMicAccessToastHeader",
        noMicAccessToastBody = noMicAccessToastBody,
        u13PolicyToastHeader = "CoreScripts.TextChat.ChatWindow.DictationU13PolicyToastHeader",
        u13PolicyToastBody = "CoreScripts.TextChat.ChatWindow.DictationU13PolicyToastBody",
        u13MicAccessToastHeader = "CoreScripts.TextChat.ChatWindow.TranscriptionU13MicAccessToastHeader",
        u13MicAccessToastBody = "CoreScripts.TextChat.ChatWindow.TranscriptionU13MicAccessToastBody"
    })

    local var16 = if var15.transcriptionFailedText then if var15.transcriptionFailedText == "" then "Sorry did not get that! Try to speak again." else var15.transcriptionFailedText else "Sorry did not get that! Try to speak again."

    local var17 = if var15.transcriptionLanguageUnsupportedText then if var15.transcriptionLanguageUnsupportedText == "" then "Sorry, that language isn't supported yet." else var15.transcriptionLanguageUnsupportedText else "Sorry, that language isn't supported yet."

    local toastTitle = if var15.noMicAccessToastHeader then if var15.noMicAccessToastHeader == "" then "Microphone access needed" else var15.noMicAccessToastHeader else "Microphone access needed"

    local toastSubtitle = if var15.noMicAccessToastBody then if var15.noMicAccessToastBody == "" then "Enable microphone access in your device settings to use voice input." else var15.noMicAccessToastBody else "Enable microphone access in your device settings to use voice input."

    local var3 = if var15.u13PolicyToastHeader then if var15.u13PolicyToastHeader == "" then "You've enabled voice to text chat" else var15.u13PolicyToastHeader else "You've enabled voice to text chat"

    local var5 = if var15.u13PolicyToastBody then if var15.u13PolicyToastBody == "" then "To send messages with your voice, we'll process your audio and delete it right away, per our privacy policy." else var15.u13PolicyToastBody else "To send messages with your voice, we'll process your audio and delete it right away, per our privacy policy."

    local var10 = if var15.u13MicAccessToastHeader then if var15.u13MicAccessToastHeader == "" then "Microphone enabled" else var15.u13MicAccessToastHeader else "Microphone enabled"

    local var18 = if var15.u13MicAccessToastBody then if var15.u13MicAccessToastBody == "" then "Your voice is converted to text and never shared with other players." else var15.u13MicAccessToastBody else "Your voice is converted to text and never shared with other players."

    local var24 = React.useCallback(function(currentText: string): boolean
        local current = if tbl2.customTextBoxRef.current then tbl2.customTextBoxRef.current else tbl2.textBoxRef.current

        if current == nil then
            return false
        end
        current.Text = currentText
        tbl2.setInputText(currentText)
        return true
    end, {
        tbl2.setInputText,
        tbl2.customTextBoxRef,
        tbl2.textBoxRef,
        tbl2.chatInputBarSettings.TextBox
    })

    local var25 = React.useCallback(function(str2: string)
        local systemMessageChannelName = getSystemMessageChannelName(tbl2.targetTextChannel, tbl2.isGlobalChatTabActive)
        GetMessagesStore(false).addSystemMessage(str2, systemMessageChannelName, "Roblox.Dictation.Error", nil, true)
    end, { tbl2.targetTextChannel, tbl2.isGlobalChatTabActive })

    local useCallback = React.useCallback
    local function func1(current, arg1)
        var4.current = false
        if arg1 ~= DictationErrorReason.PermissionDenied then
            var8.logTranscriptionFailed(current)
            if arg1 == DictationErrorReason.LanguageUnsupported then
                var25(var17)
                return
            end
            var25(var16)
            return
        end

        local tbl3 = {
            toastTitle = toastTitle,
            toastSubtitle = toastSubtitle,
            sequenceNumber = if engineFeature then DateTime.now().UnixTimestamp else nil,
            onActivated = engineFeature and var14.status == "ok" and var14.value and function()
                default:switchToSettingsApp(SettingsRoute.Microphone)
            end or nil
        }

        if bool1 then
            local onActivated2 = tbl3.onActivated
            var9.current = current
            if onActivated2 then
                function tbl3.onActivated()
                    var8.logMicToastActivated(current, true)
                    onActivated2()
                end
            else
                tbl3.onActivated = onActivated
            end

            function tbl3.onAppeared()
                var8.logMicToastShown(current, onActivated2 ~= nil)
            end

            local bool2 = false
            function tbl3.onTouchSwipeUp()
                if bool2 then
                    return
                end
                bool2 = true
                var8.logMicToastDismissed(current, DictationAnalytics.DismissReasons.UserInteraction)
            end
        end
        SetUIBloxToast(tbl3)
    end

    local logTranscriptionFailed = var8.logTranscriptionFailed
    local var26 = bool1 and {
        var8.logMicToastShown,
        var8.logMicToastActivated,
        var8.logMicToastDismissed,
        onActivated
    } or {}
    local onError = useCallback(
        func1,
        {
            var25,
            var16,
            var17,
            toastTitle,
            toastSubtitle,
            var14,
            logTranscriptionFailed,
            table.unpack(var26)
        }
    )

    local var28 = useTranscribedSamples()

    local var29 = React.useRef(nil)

    local onWaveformSample = React.useCallback(function(current: number, _: number)
        var29.current = current
    end, {})

    local onSpeechStarted = React.useCallback(function(continuous)
        if continuous ~= DictationMode.Continuous then
            return
        end
        if var29.current ~= nil then
            var28.begin(var29.current)
        end
        var8.logSpeechStarted()
    end, { var28, var8.logSpeechStarted })

    local onTranscription = React.useCallback(function(str2: string, continuous)
        if continuous ~= DictationMode.Continuous then
            if not var4.current and tbl2.onTranscriptionStaged ~= nil then
                tbl2.onTranscriptionStaged(str2, DictationAnalytics.Modes.Standard)
            end

            local var32 = var24(str2)
            var8.logTranscription(str2, continuous, var32)
            if var32 and var4.current then
                var4.current = false
                tbl2.onSendRecordingTap({
                    mode = DictationAnalytics.Modes.Standard,
                    outcome = DictationAnalytics.Outcomes.Full,
                    textStt = str2,
                    textSent = str2
                })
            end
            return
        end

        if var29.current ~= nil then
            var28.commit(var29.current)
        end
        local var32 = var24(str2)
        var8.logTranscription(str2, continuous, var32)
        if not var32 then
            return
        end

        if FFlagExpChatDictationContinuousSafetyReminder then
            DictationSafetyReminder.trackContinuousSend(str2)
        end
        tbl2.onSendRecordingTap({
            mode = DictationAnalytics.Modes.Continuous,
            outcome = DictationAnalytics.Outcomes.Full,
            textStt = str2,
            textSent = str2
        })
    end, {
        var24,
        tbl2.onSendRecordingTap,
        tbl2.onTranscriptionStaged,
        var28,
        var8.logTranscription
    })

    local onActivityChanged = React.useCallback(function(bool2: boolean)
        if bool2 then
            if FFlagExpChatDictationFTUX and var6.current and var7.current then
                var7.current = false
                var6.current.markUsed()
            end

            if FFlagExpChatDictationU13PolicyToast and var12 and not var13.current then
                var13.current = true
                U13PolicyToastStorage.markShown()
                SetUIBloxToast({
                    toastTitle = var3,
                    toastSubtitle = var5,
                    duration = 5,
                    onActivated = function() end
                })
            end
        else
            var29.current = nil
            var28.reset()
        end
        local onDictationActivityChanged = tbl2.onDictationActivityChanged
        if onDictationActivityChanged ~= nil then
            onDictationActivityChanged(bool2)
        end
    end, {
        var12,
        tbl2.onDictationActivityChanged,
        var28,
        var5,
        var3
    })

    local var34 = React.useRef(false)
    local onPermissionResolved = React.useCallback(function(granted, arg1)
        var8.logPermissionResolved(arg1, granted)

        if not FFlagExpChatDictationU13PolicyToast or granted ~= PermissionStatus.Granted or var34.current or not var12 then
            return
        end
        var34.current = true

        var13.current = true
        SetUIBloxToast({ toastTitle = var10, toastSubtitle = var18 })
    end, {
        var8.logPermissionResolved,
        var12,
        var10,
        var18
    })

    local dictation = useDictation({
        onTranscription = onTranscription,
        onSpeechStarted = onSpeechStarted,
        onActivityChanged = onActivityChanged,
        onStateChanged = tbl2.onDictationStateChanged,
        onPermissionResolved = onPermissionResolved,
        onRecordingStart = var8.logRecordingStart,
        onRecordingStop = var8.logRecordingStop,
        onError = onError
    })

    local state = SignalsReact.useSignalState(dictation.getDictationState)
    local isRecording = state == DictationState.Recording
    local isTranscribing = state == DictationState.Transcribing
    local isListening = state == DictationState.Listening

    local startDictation = dictation.startDictation
    local stopDictation = dictation.stopDictation

    if FFlagExpChatDictationStopOnSafetyIntervention then
        React.useEffect(function()
            local connection = experienceChatInterventionShownSignal:connect(function()
                if FFlagExpChatDictationExplicitFinish or dictation.getDictationState(false) == DictationState.Listening then
                    stopDictation(DictationAnalytics.TriggerTypes.SafetyIntervention)
                end
            end)
            return function()
                connection:disconnect()
            end
        end, { dictation.getDictationState, stopDictation })
    end

    if FFlagExpChatDictationStopOnRateLimit then
        React.useEffect(function()
            local connection = DictationRateLimit.stopRequested:connect(function()
                if dictation.getDictationState(false) == DictationState.Listening then
                    stopDictation(DictationAnalytics.TriggerTypes.RateLimited)
                end
            end)
            return function()
                connection:disconnect()
            end
        end, { dictation.getDictationState, stopDictation })
    end

    local var38 = getTapDictationMode()

    if FFlagExpChatDictationVoiceTypingModeSetting then
        var38 = SignalsReact.useSignalState(GetDictationModeSettingStore(false).getMode)
    end

    local longPressDictationMode = getLongPressDictationMode()
    local var39 = if FFlagExpChatDictationFTUX
        and FFlagExpChatLongPressContinuousDictation
        and not FFlagExpChatDictationVoiceTypingModeSetting then useDictationFTUX({ isEligible = var11, isComposing = tbl2.inputText ~= "", isActive = state ~= DictationState.Idle }) else nil

    if var6 then
        var6.current = var39
    end

    local var40 = React.useCallback(function()
        if dictation.getDictationState(false) == DictationState.Recording then
            var4.current = true
            stopDictation()
            return
        end

        var4.current = false
        var8.logMicClick(var38, DictationAnalytics.EntryPoints.Tap)

        if FFlagExpChatDictationFTUX and var39 and var39.shouldShow then
            var39.dismiss()
        elseif var7 then
            var7.current = true
        end
        startDictation(var38)
    end, {
        var38,
        startDictation,
        stopDictation,
        var39,
        dictation.getDictationState,
        var7,
        var8.logMicClick
    })

    local var41 = React.useCallback(function()
        if dictation.getDictationState(false) ~= DictationState.Idle then
            return
        end

        var8.logMicClick(DictationMode.Continuous, DictationAnalytics.EntryPoints.LongPress)

        if FFlagExpChatDictationFTUX and var39 and var39.shouldShow then
            var39.dismiss()
        end
        startDictation(DictationMode.Continuous)
    end, {
        dictation.getDictationState,
        startDictation,
        var39,
        var8.logMicClick
    })

    local var42 = useLongPress
    local tbl3 = { onLongPress = 0, onTap = 0 }
    if longPressDictationMode ~= DictationMode.Continuous then
        var41 = nil
    end

    tbl3.onLongPress = var41
    tbl3.onTap = var40
    return {
        state = state,
        isRecording = isRecording,
        isTranscribing = isTranscribing,
        isListening = isListening,
        isDictationEligible = var11,
        dictation = dictation,
        onMicTap = var40,
        micGestureHandlers = var42(tbl3),
        micCursor = micCursor,
        ftux = var39,
        micButtonSlotRef = micButtonSlotRef,
        onWaveformSample = onWaveformSample,
        transcribedSamplesBinding = var28.binding,
        chatInputBarSettings = tbl2.chatInputBarSettings,
        customTextBoxRef = tbl2.customTextBoxRef,
        textBoxRef = tbl2.textBoxRef
    }
end

return useDictationInputBar
