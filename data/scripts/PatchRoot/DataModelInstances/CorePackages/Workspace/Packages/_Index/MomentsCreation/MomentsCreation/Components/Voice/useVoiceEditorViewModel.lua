-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local UserInputService = game:GetService("UserInputService")

local useCallback = React.useCallback
local useEffect = React.useEffect
local useLayoutEffect = React.useLayoutEffect
local useLocalization = Localization.Hooks.useLocalization
local useMemo = React.useMemo
local useState = React.useState
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens

local _VoiceEditorView = require(script.Parent.VoiceEditorView)
local useVoiceSelector = require(script.Parent.useVoiceSelector)
local useComposerParentTextPadding = require(MomentsCreation.Hooks.useComposerParentTextPadding)
local useOnScreenKeyboardHeight = require(MomentsCreation.Hooks.useOnScreenKeyboardHeight)
local useTtsStartTimeDrag = require(MomentsCreation.Hooks.useTtsStartTimeDrag)
local clampTtsStartTime = require(MomentsCreation.Utils.clampTtsStartTime)
local computeVoiceButtonState = require(MomentsCreation.Utils.computeVoiceButtonState)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local measureTextLineCount = require(MomentsCreation.Utils.measureTextLineCount)
local voiceCatalog = require(MomentsCreation.Components.Voice.voiceCatalog)

local EventNames = MomentsCommon.Analytics.EventNames

local GetFIntMomentsTTSComposerMaxLines = require(MomentsCreation.Flags.GetFIntMomentsTTSComposerMaxLines)
local GetFIntMomentsTTSComposerMinLines = require(MomentsCreation.Flags.GetFIntMomentsTTSComposerMinLines)
local GetFIntMomentsTTSDefaultVoiceId = require(MomentsCreation.Flags.GetFIntMomentsTTSDefaultVoiceId)
local GetFIntMomentsTTSMaxCharacters = require(MomentsCreation.Flags.GetFIntMomentsTTSMaxCharacters)
local GetFFlagMomentsTTSStartTimePositioning = require(MomentsCreation.Flags.GetFFlagMomentsTTSStartTimePositioning)
local FFlagMomentsTTSStartTimeScrubberFollow = require(MomentsCreation.Flags.FFlagMomentsTTSStartTimeScrubberFollow)
local FFlagMomentsTTSComposerCaretAlignment = require(MomentsCreation.Flags.FFlagMomentsTTSComposerCaretAlignment)
local FFlagMomentsTTSVoiceSelector = require(MomentsCreation.Flags.FFlagMomentsTTSVoiceSelector)
local FFlagMomentsTTSComposerUncontrolledInput = require(MomentsCreation.Flags.FFlagMomentsTTSComposerUncontrolledInput)
local FFlagMomentsTTSTooManyDigitsError = require(MomentsCreation.Flags.FFlagMomentsTTSTooManyDigitsError)
local DialogType = require(MomentsCreation.Enums.DialogType)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local fIntMomentsTTSDefaultVoiceId = GetFIntMomentsTTSDefaultVoiceId()

local fIntMomentsTTSComposerMinLines = GetFIntMomentsTTSComposerMinLines()
local fIntMomentsTTSComposerMaxLines = GetFIntMomentsTTSComposerMaxLines()

local BuilderSans = Enum.Font.BuilderSans

local tbl1 = {
    ["‘"] = "'",
    ["’"] = "'",
    ["“"] = "\"",
    ["”"] = "\"",
    ["–"] = "-",
    ["—"] = "-"
}

local function trimWhitespace(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (str1:gsub("^%s*(.-)%s*$", "%1"))
end

local function isPointWithin(current, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if current == nil then
        return false
    end
    local absolutePosition = current.AbsolutePosition
    local absoluteSize = current.AbsoluteSize
    return absolutePosition.X <= num1
        and num1 <= absolutePosition.X + absoluteSize.X
        and absolutePosition.Y <= num2
        and num2 <= absolutePosition.Y + absoluteSize.Y
end

local function useVoiceEditorViewModel(tbl2)
    local controller = tbl2.controller
    local fIntMomentsTtsMaxCharacters = GetFIntMomentsTTSMaxCharacters()
    local playback = controller.preview.playback

    local ttsAudio = controller.ttsAudio
    assert(ttsAudio ~= nil, "VoiceEditor requires controller.ttsAudio")

    local tbl3 = {
        createText = "Feature.Moments.Action.CreateVoiceover",
        saveText = "Feature.Moments.Action.SaveVoiceover",
        placeholderText = {
            "Feature.Moments.Label.VoicePlaceholder",
            maxCount = fIntMomentsTtsMaxCharacters
        },
        helperDefault = "Feature.Moments.Label.VoiceHelperDefault",
        overLimit = "Feature.Moments.Label.ExceedsCharacterLimit",
        generating = "Feature.Moments.Label.VoiceGenerating",
        moderationError = "Feature.Moments.Label.VoiceModerationError",
        limitError = "Feature.Moments.Label.VoiceLimitReachedBody",
        timeoutError = "Feature.Moments.Label.VoiceTimeoutBody",
        failureError = "Feature.Moments.Label.VoiceGenerationFailedBody"
    }

    if FFlagMomentsTTSTooManyDigitsError then
        tbl3.tooManyDigitsError = "Feature.Moments.Label.VoiceTooManyNumbersError"
    end
    local var1 = useLocalization(tbl3)

    local tbl4 = {
        moderated = var1.moderationError,
        quotaExceeded = var1.limitError,
        timeout = var1.timeoutError,
        tooManyDigits = var1.tooManyDigitsError,
        failure = var1.failureError
    }
    local failureError = var1.failureError

    local current = useOnScreenKeyboardHeight() > 0

    local var2, var3 = useState(UserInputService.PreferredInput == Enum.PreferredInput.Touch)
    useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            var3(UserInputService.PreferredInput == Enum.PreferredInput.Touch)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    local composerContainerRef = useComposerParentTextPadding(FFlagMomentsTTSComposerCaretAlignment and var2)

    local var5 = useTokens()

    local text, var7 = useState("")

    local setSelectedVoiceId = controller.setSelectedVoiceId
    local var8 = fIntMomentsTTSDefaultVoiceId
    if FFlagMomentsTTSVoiceSelector then
        var8 = useSignalState(controller.getSelectedVoiceId) or fIntMomentsTTSDefaultVoiceId
    end

    local voiceById = voiceCatalog.getVoiceById(var8)

    local var9 = nil
    local var10 = nil
    local var11 = nil
    if FFlagMomentsTTSComposerUncontrolledInput then
        local var12
        var9, var12 = React.useBinding("")
        var10 = var12

        var11 = React.useRef("")
    end

    local var12, var13 = useState(0)
    local textBoxRef = React.useRef(nil)

    local var15 = React.useRef(false)

    local var16 = React.useRef(nil)

    local var17, var18 = useState(0)

    local createButtonRef = React.useRef(nil)
    local deleteButtonRef = React.useRef(nil)
    local voiceSelectorButtonRef = if FFlagMomentsTTSVoiceSelector then React.useRef(nil) else nil

    local var22 = React.useRef(false)
    local hasGenerated, var24 = useState(false)

    local hasCleared, var26 = useState(false)

    local lastSavedText, var28 = useState("")
    local lastGeneratedTextRef = React.useRef("")

    local startTime, var31 = useState(0)

    local lastSavedStartTime, var33 = useState(0)

    local var34 = fIntMomentsTTSDefaultVoiceId
    local var35 = nil
    if FFlagMomentsTTSVoiceSelector then
        local var36
        var34, var36 = useState(fIntMomentsTTSDefaultVoiceId)
        var35 = var36
    end
    local var36 = if GetFFlagMomentsTTSStartTimePositioning then startTime else 0
    local var37 = React.useRef(false)

    local var38 = React.useRef(false)

    local var39 = React.useRef(nil)

    local var40 = React.useRef(0)

    local ttsState = useSignalState(ttsAudio.getState)
    local errorReason = useSignalState(ttsAudio.getErrorReason)
    local var43 = useSignalState(ttsAudio.getTimeLength)
    local waveformSamples = useSignalState(ttsAudio.getWaveform)

    local var45 = React.useRef(false)
    local var46, var47 = useState(controller.getActiveSession(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var47(controller.getActiveSession(arg1))
        end)
    end, { controller })

    useEffect(function()
        if var45.current or var46 == nil then
            return
        end

        local draft = var46.getDraft(false)
        if draft == nil or draft.text == nil or not (#draft.text > 0) then
            var45.current = true
            return
        end

        var45.current = true
        var7(draft.text)
        if FFlagMomentsTTSComposerUncontrolledInput and var11 and var10 then
            var11.current = draft.text
            var10(draft.text)
        end
        lastGeneratedTextRef.current = draft.text
        var24(true)
        var28(draft.text)
        if FFlagMomentsTTSVoiceSelector and draft.voiceId ~= nil and var35 ~= nil then
            setSelectedVoiceId(draft.voiceId)
            var35(draft.voiceId)
        end

        if GetFFlagMomentsTTSStartTimePositioning then
            local startTime = draft.startTime or 0
            local duration = playback.getDuration(false)
            if duration > 0 then
                startTime = clampTtsStartTime(startTime, duration)
            end
            var31(startTime)
            var33(draft.startTime or 0)
        end
        var37.current = true
    end, { var46, playback, setSelectedVoiceId })

    useEffect(function()
        if ttsState == "ready" and lastGeneratedTextRef.current ~= "" then
            var24(true)
            if not var37.current then
                var37.current = true

                fireAnalyticsEvent(
                    EventNames.EditingFlowVoiceGenerateSucceeded,
                    makeCreationEventFields.makeVoiceEventFields({
                        char_count = tostring(utf8.len(lastGeneratedTextRef.current) or #lastGeneratedTextRef.current),
                        tts_duration = tostring(ttsAudio.getTimeLength(false)),
                        voice_id = tostring(ttsAudio.getLoadedVoiceId(false))
                    })
                )
                if var38.current then
                    var38.current = false

                    var40.current = playback.getPosition(false)
                    playback.play()
                    return
                end

                var40.current = var36
                playback.seek(var36)
                ttsAudio.seek(0)
                playback.play()
                ttsAudio.play()
            end
        elseif ttsState == "error" then
            var24(false)

            local errorReason = ttsAudio.getErrorReason(false)

            fireAnalyticsEvent(
                EventNames.EditingFlowVoiceGenerateFailed,
                makeCreationEventFields.makeVoiceEventFields({ failure_reason = tostring(errorReason or "failure") })
            )
            if errorReason ~= "moderated" and errorReason ~= "tooManyDigits" then
                controller.showModal({
                    modalType = DialogType.VoiceoverError,
                    modalProps = {
                        message = tbl4[errorReason] or failureError,
                        onTryAgain = function()
                            controller.dismissModal()
                            if var39.current ~= nil then
                                var39.current()
                            end
                        end,
                        onDismiss = controller.dismissModal
                    }
                })
            end
        end
    end, { ttsState })

    local var48, var49 = useState(playback.getIsPlaying(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var49(playback.getIsPlaying(arg1))
        end)
    end, { playback })

    useEffect(function()
        if var43 <= 0 then
            return
        end

        local isPlaying = playback.getIsPlaying(false)
        local var50 = var36 + var43
        local position = playback.getPosition(false)
        local bool2 = var36 <= position and position < var50

        if isPlaying and bool2 then
            if var36 > 0 then
                ttsAudio.seek(position - var36)
            end
            ttsAudio.play()
        elseif not isPlaying or GetFFlagMomentsTTSStartTimePositioning then
            ttsAudio.pause()
        end
    end, { var48, var43, var36 })

    useEffect(function()
        if var43 <= 0 then
            return
        end

        local var50 = var36 + var43

        return Signals.createEffect(function(arg1)
            local position = playback.getPosition(arg1)
            local current = var40.current
            var40.current = position

            if not playback.getIsPlaying(false) then
                return
            end

            local bool2 = var36 <= position and position < var50

            if not (current - position > 0.5) then
                if GetFFlagMomentsTTSStartTimePositioning and current < var36 and bool2 then
                    ttsAudio.seek(position - var36)
                    ttsAudio.play()
                end

                return
            end

            if bool2 then
                ttsAudio.seek(position - var36)
                ttsAudio.play()
                return
            end

            if GetFFlagMomentsTTSStartTimePositioning then
                ttsAudio.pause()
            end
        end)
    end, { var43, var36 })

    local onTimelineSeek = useCallback(function(num1: number)
        if var43 <= 0 then
            return
        end
        local var50 = var36 + var43
        if var36 <= num1 and num1 < var50 then
            ttsAudio.seek(num1 - var36)
        end
    end, { var43, var36 })

    local onTextChanged = useCallback(function(str1: string)
        local var51 = str1:gsub("[\r\n]+", " ")

        for value, value2 in tbl1 do
            var51 = var51:gsub(value, value2)
        end

        local var52 = var51:gsub("[^ -~]", "")

        if FFlagMomentsTTSComposerUncontrolledInput and var11 and var10 then
            var7(var52)
            var11.current = var52
            if var52 ~= str1 then
                var10(str1)
                var10(var52)
            end
        elseif var52 == text and var52 ~= str1 then
            var16.current = var52
            var7(str1)
        else
            var7(var52)
        end

        if var52 ~= "" and not var15.current then
            var15.current = true
            fireAnalyticsEvent(EventNames.EditingFlowVoiceTextEntered, makeCreationEventFields.makeVoiceEventFields())
        end

        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end

        if FFlagMomentsTTSVoiceSelector then
            local draft = activeSession.getDraft(false)
            if draft ~= nil and draft.text == var52 then
                return
            end
        end

        activeSession.update(var52 ~= "" and { text = var52, voiceId = var8, startTime = var36 } or nil)
    end, {
        text,
        controller,
        var36,
        var8
    })

    useLayoutEffect(function()
        if var16.current ~= nil then
            local current = var16.current
            var16.current = nil
            var7(current)
        end
    end)

    local onComposerResize = useCallback(function(arg1)
        var13(arg1.AbsoluteSize.X)
    end, {})

    local fontSize = var5.Typography.BodyMedium.FontSize
    local numLines = useMemo(function(): number
        return math.max(
            fIntMomentsTTSComposerMinLines,
            (measureTextLineCount(text, var12 - 32, fontSize, BuilderSans, fIntMomentsTTSComposerMaxLines))
        )
    end, { text, var12, fontSize })

    local var54 = computeVoiceButtonState({
        text = text,
        lastGeneratedText = lastGeneratedTextRef.current,
        lastSavedText = lastSavedText,
        maxChars = fIntMomentsTtsMaxCharacters,
        ttsState = ttsState,
        errorReason = errorReason,
        hasGenerated = hasGenerated,
        hasCleared = hasCleared,
        startTime = var36,
        lastSavedStartTime = lastSavedStartTime,
        voiceId = var8,
        lastSavedVoiceId = var34
    })
    local isGenerating = var54.isGenerating
    local charCount = var54.charCount
    local isOverLimit = var54.isOverLimit
    local canGenerate = var54.canGenerate

    local showSave = var54.showSave and not current

    local isModerated = var54.isModerated
    local isTooManyDigits = var54.isTooManyDigits
    local isInputInvalid = isOverLimit or isModerated or isTooManyDigits

    local var57 = React.useRef(false)

    useEffect(function()
        if ttsState ~= "loading" then
            var57.current = false
        end
    end, { ttsState })

    local var58 = useCallback(function(num1: number?, bool2: boolean?, str1: string?, bool3: boolean?)
        if var57.current or ttsAudio.getState(false) == "loading" or not canGenerate and str1 == nil then
            return
        end

        if textBoxRef.current ~= nil then
            textBoxRef.current.releaseFocus()
        end
        if FFlagMomentsTTSComposerUncontrolledInput and var10 and var11 then
            var10(var11.current)
        end

        var57.current = true
        local voiceId = num1 or var8
        local var59 = trimWhitespace(str1 or text)
        lastGeneratedTextRef.current = var59

        local activeSession = controller.getActiveSession(false)

        if var59 == "" then
            var57.current = false
            controller.clearActiveTool()
            var24(false)
            var26(true)
            return
        end

        var26(false)

        local var60 = var36
        if GetFFlagMomentsTTSStartTimePositioning and not bool3 then
            var60 = if bool2 or playback.getIsPlaying(false) then 0 else clampTtsStartTime(playback.getPosition(false), playback.getDuration(false))
            var31(var60)
            if var60 > 0 and var60 ~= var36 then
                local duration = playback.getDuration(false)
                fireAnalyticsEvent(
                    EventNames.EditingFlowVoiceoverStartTimeAdjusted,
                    makeCreationEventFields.makeVoiceEventFields({
                        source = "generate",
                        start_time_seconds = tostring(var60),
                        video_duration_seconds = tostring(duration),
                        start_time_fraction = tostring(if duration > 0 then var60 / duration else 0)
                    })
                )
            end
        end
        if activeSession ~= nil then
            activeSession.update({ text = var59, voiceId = voiceId, startTime = var60 })
        end

        fireAnalyticsEvent(EventNames.EditingFlowVoiceGeneratePressed, makeCreationEventFields.makeVoiceEventFields())

        var37.current = false
        var38.current = bool3 == true
        ttsAudio.generate(var59, voiceId)
    end, {
        text,
        controller,
        canGenerate,
        var36,
        var8
    })
    var39.current = var58

    local onCreateVoiceover = useCallback(function()
        var58()
    end, { var58 })

    local onSave = useCallback(function()
        local current = lastGeneratedTextRef.current
        local activeSession = controller.getActiveSession(false)
        if activeSession ~= nil then
            activeSession.update(current ~= "" and { text = current, voiceId = var8, startTime = var36 } or nil)
        end

        var28(current)
        var33(var36)
        if var35 ~= nil then
            var35(var8)
        end

        controller.commitActiveTool()
    end, { controller, var36, var8 })

    local var61 = if FFlagMomentsTTSVoiceSelector then useVoiceSelector({
        controller = controller,
        text = text,
        canGenerate = canGenerate,
        selectedVoiceId = var8,
        onCreateVoiceover = var58,
        lastGeneratedTextRef = lastGeneratedTextRef,
        createPreviewAudio = tbl2.createPreviewAudio
    }) else nil
    local onOpenVoiceSelector = if var61 == nil then nil else var61.onOpenVoiceSelector

    useEffect(function()
        if var17 > 0 and textBoxRef.current ~= nil then
            textBoxRef.current.focus()
        end
    end, { var17 })

    local onDelete = useCallback(function()
        var22.current = current
        local function refocusIfEditing() -- Luacid: Inlined by compiler; 1 call site recovered
            if var22.current and textBoxRef.current ~= nil then
                textBoxRef.current.focus()
            end
        end
        local function performDelete()
            fireAnalyticsEvent(EventNames.EditingFlowVoiceoverDeleted, makeCreationEventFields.makeVoiceEventFields())
            controller.dismissModal()

            if textBoxRef.current ~= nil then
                textBoxRef.current.releaseFocus()
            end
            var7("")
            if FFlagMomentsTTSComposerUncontrolledInput and var11 and var10 then
                var11.current = ""
                var10("")
            end
            var24(false)
            var26(false)
            lastGeneratedTextRef.current = ""
            var37.current = false

            controller.clearActiveTool()
            controller.saveActiveTool()
            var28("")
            if var22.current then
                var18(function(arg1): number
                    return arg1 + 1
                end)
            end
        end
        local function cancelDelete()
            fireAnalyticsEvent(EventNames.EditingFlowVoiceoverDeleteCancelled, makeCreationEventFields.makeVoiceEventFields())

            controller.dismissModal()
            refocusIfEditing()
        end

        fireAnalyticsEvent(EventNames.EditingFlowVoiceoverDeleteButtonPressed, makeCreationEventFields.makeVoiceEventFields())

        controller.showModal(
            {
                modalType = DialogType.VoiceoverDelete,
                modalProps = { onConfirm = performDelete, onCancel = cancelDelete }
            }
        )
    end, { controller, current })

    local onTextBoxFocusLost = useCallback(function(arg1)
        if FFlagMomentsTTSComposerUncontrolledInput and var10 and var11 then
            var10(var11.current)
        end
        if arg1 == nil then
            return
        end
        local position = arg1.Position

        if isPointWithin(createButtonRef.current, position.X, position.Y) then
            if showSave then
                onSave()
                return
            end
            var58()
        elseif isPointWithin(deleteButtonRef.current, position.X, position.Y) then
            onDelete()
        elseif voiceSelectorButtonRef ~= nil
            and onOpenVoiceSelector ~= nil
            and isPointWithin(voiceSelectorButtonRef.current, position.X, position.Y)
        then
            onOpenVoiceSelector()
        end
    end, {
        showSave,
        onSave,
        var58,
        onDelete,
        onOpenVoiceSelector
    })
    local capture, var65 = useState(controller.preview.getCapture(false))

    local videoDuration, var67 = useState(playback.getDuration(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var65(controller.preview.getCapture(arg1))
            var67(playback.getDuration(arg1))
        end)
    end, { controller, playback })

    local helperText = if isOverLimit then var1.overLimit elseif isModerated then var1.moderationError elseif isTooManyDigits then var1.tooManyDigitsError elseif isGenerating then var1.generating else var1.helperDefault
    local bool2 = (ttsState == "ready" or ttsState == "playing") and var43 > 0 and videoDuration > 0
    local var69 = React.useRef(var36)

    local var70 = useCallback(function(num1: number)
        var31(num1)
        if FFlagMomentsTTSStartTimeScrubberFollow then
            var69.current = num1
        end
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        if draft == nil or draft.text == nil or draft.text == "" then
            return
        end

        activeSession.update({ text = draft.text, voiceId = draft.voiceId, startTime = num1 })
    end, { controller })

    local var71 = React.useRef(false)
    local var72 = React.useRef(0)
    local var73 = React.useRef(var43)
    useEffect(function()
        var69.current = var36
        var73.current = var43
    end, { var36, var43 })

    local var74 = useCallback(function()
        var72.current = var69.current
        if playback.getIsPlaying(false) then
            var71.current = true
            playback.pause()
        end
    end, { playback })

    local var75 = useCallback(function(bool3: boolean)
        local current = var71.current
        var71.current = false
        local current2 = var69.current
        if GetFFlagMomentsTTSStartTimePositioning and current2 ~= var72.current then
            local duration = playback.getDuration(false)
            fireAnalyticsEvent(
                EventNames.EditingFlowVoiceoverStartTimeAdjusted,
                makeCreationEventFields.makeVoiceEventFields({
                    source = "drag",
                    start_time_seconds = tostring(current2),
                    video_duration_seconds = tostring(duration),
                    start_time_fraction = tostring(if duration > 0 then current2 / duration else 0)
                })
            )
        end
        if FFlagMomentsTTSStartTimeScrubberFollow and not bool3 and current2 ~= var72.current then
            playback.seek(current2)
            ttsAudio.seek(0)
            playback.play()
            ttsAudio.play()
            return
        end
        local position = playback.getPosition(false)
        local var75 = current2 + var73.current
        if current2 <= position and position < var75 then
            ttsAudio.seek(position - current2)
        else
            ttsAudio.pause()
        end
        if current then
            playback.play()
        end
    end, { playback })

    local var76 = useTtsStartTimeDrag(GetFFlagMomentsTTSStartTimePositioning and bool2, videoDuration, startTime, var70, var74, var75)

    local tbl5 = {
        layoutOrder = tbl2.layoutOrder,
        playback = playback,
        capture = capture,
        onTimelineSeek = onTimelineSeek,
        playheadPosition = if FFlagMomentsTTSStartTimeScrubberFollow then if var76.isSelected then startTime else nil else nil,
        showAudioWaveform = bool2,
        audioDuration = var43,
        videoDuration = videoDuration,
        startTime = startTime,
        waveformDragDetectorRef = var76.dragDetectorRef,
        waveformSelected = var76.isSelected,
        waveformSamples = waveformSamples
    }
    if not FFlagMomentsTTSComposerUncontrolledInput then
        var9 = text
    end

    tbl5.text = var9
    tbl5.textBoxRef = textBoxRef
    tbl5.composerContainerRef = composerContainerRef
    tbl5.numLines = numLines
    tbl5.onComposerResize = onComposerResize
    tbl5.onTextChanged = onTextChanged
    tbl5.onTextBoxFocusLost = onTextBoxFocusLost
    tbl5.createButtonRef = createButtonRef
    tbl5.deleteButtonRef = deleteButtonRef
    tbl5.placeholderText = var1.placeholderText
    tbl5.isGenerating = isGenerating
    tbl5.isInputInvalid = isInputInvalid

    tbl5.showVoiceSelector = FFlagMomentsTTSVoiceSelector
    tbl5.selectedVoiceName = if voiceById == nil then nil else voiceById.name
    tbl5.onOpenVoiceSelector = onOpenVoiceSelector
    tbl5.voiceSelectorButtonRef = voiceSelectorButtonRef

    tbl5.helperText = helperText
    tbl5.charCount = charCount
    tbl5.maxChars = fIntMomentsTtsMaxCharacters
    tbl5.isOverLimit = isOverLimit

    tbl5.showSave = showSave
    tbl5.canGenerate = canGenerate
    tbl5.onSave = onSave
    tbl5.onCreateVoiceover = onCreateVoiceover
    tbl5.createText = var1.createText
    tbl5.saveText = var1.saveText

    tbl5.showDelete = bool2
    tbl5.onDelete = onDelete
    return tbl5
end

return useVoiceEditorViewModel
