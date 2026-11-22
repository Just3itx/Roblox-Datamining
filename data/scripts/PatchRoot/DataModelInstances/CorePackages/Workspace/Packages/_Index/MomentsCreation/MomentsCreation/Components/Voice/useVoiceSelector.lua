-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo

local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local voiceCatalog = require(MomentsCreation.Components.Voice.voiceCatalog)
local createTTSAudioManager = require(MomentsCreation.Audio.createTTSAudioManager)
local DialogType = require(MomentsCreation.Enums.DialogType)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local EventNames = MomentsCommon.Analytics.EventNames

local FStringMomentsTTSPreviewText = require(MomentsCreation.Flags.FStringMomentsTTSPreviewText)

local function trimWhitespace(text: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (text:gsub("^%s*(.-)%s*$", "%1"))
end

local function useVoiceSelector(tbl1)
    local controller = tbl1.controller
    local playback = controller.preview.playback
    local ttsAudio = controller.ttsAudio
    assert(ttsAudio ~= nil, "useVoiceSelector requires controller.ttsAudio")
    local setSelectedVoiceId = controller.setSelectedVoiceId
    local selectedVoiceId = tbl1.selectedVoiceId
    local text = tbl1.text
    local canGenerate = tbl1.canGenerate
    local onCreateVoiceover = tbl1.onCreateVoiceover
    local lastGeneratedTextRef = tbl1.lastGeneratedTextRef

    local var1 = tbl1.createPreviewAudio or function()
        return createTTSAudioManager(nil, controller.ttsAudioParent)
    end
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = React.useRef(false)

    local var5 = useMemo(function()
        local get, set = Signals.createSignal(nil)
        return { get = get, set = set }
    end, {})

    local function ensurePreviewAudio() -- Luacid: Inlined by compiler; 1 call site recovered
        local current = var2.current
        if current ~= nil then
            return current
        end
        local var6 = var1()
        var2.current = var6
        var3.current = Signals.createEffect(function(arg1)
            local state = var6.getState(arg1)
            if state == "ready" and var4.current then
                var4.current = false
                var6.seek(0)
                var6.play()
            end

            if state ~= "loading" then
                var5.set(nil)
            end
        end)
        return var6
    end

    useEffect(function()
        return function()
            if var3.current ~= nil then
                var3.current()
                var3.current = nil
            end
            if var2.current ~= nil then
                var2.current.destroy()
                var2.current = nil
            end
        end
    end, {})

    local onAudition = useCallback(function(num1: number)
        fireAnalyticsEvent(
            EventNames.EditingFlowVoicePreviewPlayed,
            makeCreationEventFields.makeVoiceEventFields({ voice_id = tostring(num1) })
        )
        local var6 = trimWhitespace(text)
        if var6 == "" then
            var6 = FStringMomentsTTSPreviewText
        end
        ttsAudio.pause()
        local var7 = ensurePreviewAudio()

        if var7.getState(false) ~= "loading" and var7.getLoadedVoiceId(false) == num1 and var7.getLoadedText(false) == var6 then
            var7.seek(0)
            var7.play()
            return
        end
        var4.current = true
        var5.set(num1)
        var7.generate(var6, num1)
    end, { text })

    local var7 = useCallback(function()
        var4.current = false
        if var2.current ~= nil then
            var2.current.pause()
        end
        var5.set(nil)
    end, { var5 })

    local var8 = React.useRef(false)

    local onClose = useCallback(function()
        var7()
        controller.dismissModal()
        if var8.current then
            var8.current = false
            playback.play()
        end
    end, { controller, playback, var7 })

    local onSelect = useCallback(function(num1: number)
        local bool1 = num1 ~= selectedVoiceId
        if bool1 then
            setSelectedVoiceId(num1)
            fireAnalyticsEvent(
                EventNames.EditingFlowVoiceSelected,
                makeCreationEventFields.makeVoiceEventFields({ voice_id = tostring(num1) })
            )
        end

        if canGenerate and trimWhitespace(text) ~= "" then
            var7()
            controller.dismissModal()

            local current = var8.current
            var8.current = false
            onCreateVoiceover(num1, current)
            return
        end

        if bool1 and lastGeneratedTextRef.current ~= "" then
            var7()
            controller.dismissModal()

            var8.current = false
            onCreateVoiceover(num1, false, lastGeneratedTextRef.current, true)
        else
            onClose()
        end
    end, {
        controller,
        canGenerate,
        selectedVoiceId,
        onClose,
        onCreateVoiceover,
        var7,
        text
    })

    return {
        onOpenVoiceSelector = useCallback(function()
            fireAnalyticsEvent(EventNames.EditingFlowVoiceSelectorOpened, makeCreationEventFields.makeVoiceEventFields())

            if playback.getIsPlaying(false) then
                var8.current = true
                playback.pause()
            else
                var8.current = false
            end
            controller.showModal({
                modalType = DialogType.VoiceSelector,
                modalProps = {
                    voices = voiceCatalog.getOrderedVoices(),
                    selectedVoiceId = selectedVoiceId,
                    onSelect = onSelect,
                    onClose = onClose,
                    onAudition = onAudition,
                    getAuditioningVoiceId = var5.get
                }
            })
        end, {
            controller,
            playback,
            selectedVoiceId,
            onSelect,
            onAudition,
            onClose
        })
    }
end
return useVoiceSelector
