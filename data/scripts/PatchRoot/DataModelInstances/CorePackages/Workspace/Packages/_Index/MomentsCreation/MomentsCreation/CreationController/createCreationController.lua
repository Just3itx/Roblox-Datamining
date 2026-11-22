-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Cryo = require(MomentsCreationParent.Cryo)
local Signals = require(MomentsCreationParent.Signals)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local DialogType = require(MomentsCreation.Enums.DialogType)
local MomentType = require(MomentsCreation.Enums.MomentType)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local creationToolRegistry = require(MomentsCreation.Tools.creationToolRegistry)
local defaultCreationTools = require(MomentsCreation.Tools.defaultCreationTools)
local createCapturePreviewController = require(MomentsCreation.Preview.createCapturePreviewController)
local createTTSAudioManager = require(MomentsCreation.Audio.createTTSAudioManager)
local createEditSession = require(MomentsCreation.Stores.createEditSession)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeDefaultTextOverlayEdit = require(MomentsCreation.Utils.makeDefaultTextOverlayEdit)
local clampTtsStartTime = require(MomentsCreation.Utils.clampTtsStartTime)
local isAvatarMoment = require(MomentsCreation.Utils.isAvatarMoment)
local FFlagMomentsCommentsCreatorControl = require(MomentsCreation.Flags.FFlagMomentsCommentsCreatorControl)
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)
local GetFFlagMomentsTTSStartTimePositioning = require(MomentsCreation.Flags.GetFFlagMomentsTTSStartTimePositioning)
local FFlagMomentsTTSVoiceSelector = require(MomentsCreation.Flags.FFlagMomentsTTSVoiceSelector)
local FFlagMomentsTTSPublishMetadataEdits = require(MomentsCreation.Flags.FFlagMomentsTTSPublishMetadataEdits)
local FFlagMomentsTTSDraftRestore = require(MomentsCreation.Flags.FFlagMomentsTTSDraftRestore)
local GetFFlagMomentsGenerateTextInTextOverlay = require(MomentsCreation.Flags.GetFFlagMomentsGenerateTextInTextOverlay)
local FFlagMomentsTextOverlayOnPhotos = require(MomentsCreation.Flags.FFlagMomentsTextOverlayOnPhotos)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts
local FFlagMomentsRenderCreatePostStatus = require(MomentsCreationParent.SharedFlags).FFlagMomentsRenderCreatePostStatus
local MomentsDraftStorage = require(MomentsCreation.Storage.MomentsDraftStorage)

local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local GetFFlagMomentsCreationSaveDraft = MomentsCommon.Flags.GetFFlagMomentsCreationSaveDraft
local FFlagMomentTextGenerationFilteredSignal = MomentsCommon.Flags.FFlagMomentTextGenerationFilteredSignal
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign

local createComputed = Signals.createComputed
local createSignal = Signals.createSignal

local function createCreationController(tbl1)
    local store = tbl1.store
    local host = tbl1.host or {}
    local tbl2 = defaultCreationTools
    if host.toolKinds ~= nil then
        local tbl3 = ({})
        for _, toolKind in host.toolKinds do
            tbl3[toolKind] = true
        end
        tbl2 = {}
        for _, defaultCreationTool in defaultCreationTools do
            if tbl3[defaultCreationTool.kind] then
                table.insert(tbl2, defaultCreationTool)
            end
        end
    end
    local var1 = tbl1.registry or creationToolRegistry(tbl2)

    if SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow) == nil then
        SessionManager.startSession(FunnelEventNames.FunnelTypes.CreationFlow)
    end

    if FFlagMomentsCreateAvatarPosts
        and tbl1.initialAvatarMoment ~= nil
        and store.getSelectedCapture(false) ~= tbl1.initialAvatarMoment
    then
        store.clearEdits(CreationFlowState.Preview)
        store.onSelectedCaptureUpdated(tbl1.initialAvatarMoment)
    end

    local var2 = nil

    local getActiveSession = store.getActiveSession
    local setActiveSession = store.setActiveSession

    local getActiveModal, var4 = createSignal(nil)
    local signal = nil
    local var5 = nil
    if FFlagMomentsRenderCreatePostStatus then
        signal, var5 = createSignal(false)
    end

    local getComposedEdits = createComputed(function(arg1)
        local result = ({})

        for value, value2 in (store.getEditsMap(arg1)) do
            if value2 == nil then
                continue
            end

            local var6 = var1.get(value)
            if var6 ~= nil and var6.toEdits ~= nil then
                for value3, value4 in var6.toEdits(value2) do
                    result[value3] = value4
                end
            else
                result[value] = value2
            end
        end

        return result
    end)

    local var6, var7

    if GetFFlagEnableMomentTextGeneration() then
        var6 = store.getIsGenerating
        var7 = store.setIsGenerating
    else
        var6, var7 = createSignal(false)
    end

    local var8, var9

    if GetFFlagEnableMomentTextGeneration() then
        var8 = store.getActiveGeneration
        var9 = store.setActiveGeneration
    else
        var8, var9 = createSignal(nil)
    end

    local function cancelActiveGeneration() -- Luacid: Inlined by compiler; 3 call sites recovered
        local var10 = var8(false)
        if var10 == nil then
            return
        end
        var10.promise:cancel()
        var9(nil)
        var7(false)
    end

    local getVoiceCoachmarkDismissed, var11 = createSignal(false)

    local getSelectedVoiceId, setSelectedVoiceId = createSignal(nil)

    local getAvailableTools = createComputed(function(arg1)
        local selectedCapture = store.getSelectedCapture(arg1)
        local captureType = if selectedCapture == nil then nil else selectedCapture.CaptureType
        local avatar = if FFlagMomentsCreateAvatarPosts and isAvatarMoment(selectedCapture) then MomentType.Avatar else nil
        local tbl3 = {
            canGenerateText = host.generateMomentText ~= nil,
            captureType = captureType,
            momentType = avatar,
            getComposedEdits = getComposedEdits
        }
        local result = {}
        for _, value in var1.getAll() do
            local bool1 = value.supportedCaptureTypes == nil
                or not (captureType == nil) and table.find(value.supportedCaptureTypes, captureType) ~= nil

            if FFlagMomentsCreateAvatarPosts and avatar ~= nil then
                if value.supportedMomentTypes == nil then
                    bool1 = false
                else
                    bool1 = table.find(value.supportedMomentTypes, avatar) ~= nil
                end
            end

            if bool1 and (value.isAvailable == nil or value.isAvailable(tbl3)) then
                table.insert(result, value)
            end
        end
        return result
    end)

    local getActiveTool = createComputed(function(arg1)
        local step = store.getStep(arg1)
        for _, value in var1.getAll() do
            if value.step == step then
                return value
            end
        end
        return nil
    end)

    local computed4 = createComputed(function(arg1)
        local var14 = getActiveTool(arg1)
        if var14 ~= nil and var14.kind == "trim" then
            local activeSession = getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)

            if draft ~= nil and draft.startTime ~= nil and draft.endTime ~= nil then
                return {
                    startTime = draft.startTime,
                    endTime = draft.endTime
                }
            end
        end

        local trim = getComposedEdits(arg1).trim
        return if trim == nil or trim.startTime == nil or trim.endTime == nil then nil else {
            startTime = trim.startTime,
            endTime = trim.endTime
        }
    end)

    local computed5 = createComputed(function(arg1)
        local var14 = getActiveTool(arg1)
        if var14 ~= nil and var14.kind == "music" then
            local activeSession = getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)

            if draft ~= nil and draft.assetId ~= nil then
                return draft
            end
        end
        return getComposedEdits(arg1).music
    end)

    local getEffectiveTts = createComputed(function(arg1)
        if not GetFFlagMomentsTTSAudioOverlay then
            return nil
        end
        local var14 = getActiveTool(arg1)
        if var14 ~= nil and var14.kind == "voice" then
            local activeSession = getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)

            if draft ~= nil and draft.text ~= nil and draft.text ~= "" then
                return draft
            end
        end
        return getComposedEdits(arg1).tts
    end)

    local preview = tbl1.preview or createCapturePreviewController(store, computed4, computed5)

    local bool1 = host.toolKinds == nil or table.find(host.toolKinds, "voice") ~= nil
    local var15 = nil
    if tbl1.ttsAudio ~= nil then
        var15 = tbl1.ttsAudio
    elseif GetFFlagMomentsTTSAudioOverlay and bool1 then
        var15 = store.getTTSAudio(false)
        if var15 == nil then
            var15 = createTTSAudioManager(nil, host.ttsAudioParent)
            store.setTTSAudio(var15)
        end
    end

    local function dismissModal()
        var4(nil)
    end

    local function withCreationSession(tbl3)
        local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        return Cryo.Dictionary.join(tbl3, makeCreationEventFields.makeCreationBaseFields(sessionId))
    end

    local function returnToGallery()
        if GetFFlagEnableMomentTextGeneration() then
            cancelActiveGeneration()
        end

        store.clearEdits(CreationFlowState.Gallery)
        setActiveSession(nil)

        if var15 ~= nil then
            var15.reset()
        end
        if not GetFFlagMomentsCreationSaveDraft() then
            return
        end

        if not host.disableDrafts then
            MomentsDraftStorage.clear()
        end
        fireAnalyticsEvent(EventNames.MomentsReturnToGallery, withCreationSession({}))
    end

    local function selectCapture(capture)
        local var16 = var8(false)
        if GetFFlagEnableMomentTextGeneration() and var16 ~= nil and capture ~= var16.capture then
            cancelActiveGeneration()
        end

        store.onSelectedCaptureUpdated(capture)
        if capture ~= nil then
            fireAnalyticsEvent(
                EventNames.EditingFlowGalleryItemSelected,
                withCreationSession(makeCreationEventFields.makeToolFieldFromKind("gallery"))
            )
            MomentsCommon.Analytics.reportMomentsCreationStep("gallery_selected")
        end
    end

    local function beginTool(str1: string)
        local var16 = var1.get(str1)
        if var16 == nil then
            return
        end
        MomentsCommon.Analytics.reportMomentsEditToolOpened(var16.kind)
        if var16.cta.analyticsEvent ~= nil then
            fireAnalyticsEvent(var16.cta.analyticsEvent, withCreationSession(makeCreationEventFields.makeToolField(var16)))
        end

        if var16.presentation == "InstantAction" then
            if var16.apply ~= nil then
                var16.apply(var2)
            end
            return
        end

        local createSession = var16.createSession
        local var17 = if createSession ~= nil then createSession() else createEditSession()

        if var16.step ~= nil and not store.navigate(var16.step) then
            return
        end
        local var18 = store.getEditsMap(false)[str1]
        var17.begin(var18)
        setActiveSession(var17)
    end

    local function commitActiveTool()
        local activeSession = getActiveSession(false)
        local var16 = getActiveTool(false)
        if activeSession == nil or var16 == nil then
            store.navigate(CreationFlowState.Preview)
            return
        end
        local var17 = activeSession.commit()

        if var16.onCommit ~= nil and var16.onCommit(var17, var2) == false then
            return
        end
        store.setCommittedEdit(var16.kind, var17)

        if GetFFlagMomentsTTSStartTimePositioning
            and var16.kind == "trim"
            and var17 ~= nil
            and var17.startTime ~= nil
            and var17.endTime ~= nil
        then
            local var18 = var17.endTime - var17.startTime

            local tts = getComposedEdits(false).tts
            if tts ~= nil and tts.startTime ~= nil and var18 > 0 then
                local startTime = clampTtsStartTime(tts.startTime, var18)
                if startTime ~= tts.startTime then
                    local var20 = table.clone(tts)
                    var20.startTime = startTime
                    store.setCommittedEdit("voice", var20)
                end
            end
        end

        local bool2 = var16.toEdits == nil or next(var16.toEdits(var17)) ~= nil
        if var16.cta.commitAnalyticsEvent ~= nil and (not var16.cta.commitRequiresEdit or bool2) then
            fireAnalyticsEvent(var16.cta.commitAnalyticsEvent, withCreationSession(makeCreationEventFields.makeToolField(var16)))
        end

        setActiveSession(nil)
        store.navigate(CreationFlowState.Preview)
    end

    local function saveActiveTool()
        local activeSession = getActiveSession(false)
        local var16 = getActiveTool(false)
        if activeSession == nil or var16 == nil then
            return
        end
        local var17 = activeSession.commit()
        store.setCommittedEdit(var16.kind, var17)
    end

    local function clearActiveTool()
        local activeSession = getActiveSession(false)
        local var16 = getActiveTool(false)
        if var16 == nil then
            return
        end
        if activeSession ~= nil then
            activeSession.update(nil)
        end
        if var16.kind == "voice" and var15 ~= nil then
            var15.reset()
        end
    end

    local function discardActiveTool()
        local activeSession = getActiveSession(false)
        local var16 = getActiveTool(false)
        if activeSession ~= nil then
            activeSession.discard()
        end

        if var16 ~= nil and var16.kind == "voice" and var15 ~= nil then
            local tts = getComposedEdits(false).tts
            if tts ~= nil and tts.text ~= nil and tts.text ~= "" then
                var15.generate(tts.text, tts.voiceId)
            else
                var15.reset()
            end
        end
        if var16 ~= nil and var16.cta.cancelAnalyticsEvent ~= nil then
            fireAnalyticsEvent(var16.cta.cancelAnalyticsEvent, withCreationSession(makeCreationEventFields.makeToolField(var16)))
        end

        if var16 ~= nil then
            MomentsCommon.Analytics.reportMomentsEditToolAbandoned(var16.kind)
        end
        setActiveSession(nil)
        store.navigate(CreationFlowState.Preview)
    end

    local function dismiss()
        if FFlagMomentsRenderCreatePostStatus and host.canDismissCreationFlow ~= nil and not host.canDismissCreationFlow() then
            return
        end

        local selectedCapture = if FFlagMomentsCreateAvatarPosts then store.getSelectedCapture(false) else nil
        local var16 = FFlagMomentsCreateAvatarPosts and isAvatarMoment(selectedCapture)
        if GetFFlagEnableMomentTextGeneration() then
            cancelActiveGeneration()

            if host.dismissGenerationToasts ~= nil then
                host.dismissGenerationToasts()
            end
        end
        var4(nil)
        local var17 = if tbl1.excludeGallery then CreationFlowState.Preview else CreationFlowState.Gallery
        store.clearEdits(var17)

        if var15 ~= nil then
            var15.destroy()
            store.setTTSAudio(nil)
        end
        if GetFFlagMomentsCreationSaveDraft() and not (host.disableDrafts or var16) then
            MomentsDraftStorage.clear()
        end
        if host.exitCreationFlow ~= nil then
            host.exitCreationFlow()
        end
    end

    local function emitGeneratedTextFeedback(str1: string)
        if not FFlagMomentTextGenerationFilteredSignal or host.momentGeneratedTextFeedback == nil then
            return
        end
        local generationToken = store.getGenerationToken(false)
        if generationToken == nil or generationToken == "" then
            return
        end
        host.momentGeneratedTextFeedback(generationToken, str1):catch(function() end)
    end

    local function submitGeneratedTextFeedback(str1: string)
        if not FFlagMomentTextGenerationFilteredSignal then
            return
        end

        if str1 == "policy_violation" then
            store.setGeneratedTextFeedback(nil)
            emitGeneratedTextFeedback(str1)
        else
            store.setGeneratedTextFeedback(str1)
        end
    end

    local num1 = 0

    local function acceptPublishTap(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        if host.publishDebounceSeconds == nil then
            return true
        end

        local var16 = if tbl1.clock ~= nil then tbl1.clock() else os.clock()

        if var16 - num1 < host.publishDebounceSeconds then
            return false
        end
        num1 = var16
        return true
    end

    local function settlePublishResult(arg1)
        local promise = require(MomentsCreationParent.Promise)
        if not (FFlagMomentsRenderCreatePostStatus and promise.is(arg1)) then
            dismiss()
            return
        end

        var5(true)
        local function finishPublish(bool2: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
            var5(false)
            if host.onPublishFinished ~= nil then
                host.onPublishFinished(bool2)
            end
            if bool2 then
                dismiss()
            end
        end
        arg1:andThen(function(arg2)
            finishPublish(arg2 == true)
        end, function()
            finishPublish(false)
        end)
    end

    var2 = {
        getStep = store.getStep,
        navigate = function(arg1)
            store.navigate(arg1)
        end,
        returnToGallery = returnToGallery,
        getSelectedCapture = store.getSelectedCapture,
        selectCapture = selectCapture,
        getDescription = store.getDescription,
        setDescription = function(str1: string)
            store.updateDescription(str1)
        end,
        getAvailableTools = getAvailableTools,
        getActiveTool = getActiveTool,
        getActiveSession = getActiveSession,
        getComposedEdits = getComposedEdits,
        getEffectiveTTS = getEffectiveTts,
        beginTool = beginTool,
        commitActiveTool = commitActiveTool,
        saveActiveTool = saveActiveTool,
        clearActiveTool = clearActiveTool,
        discardActiveTool = discardActiveTool,
        updateCommittedEdit = function(str1: string, arg1)
            store.setCommittedEdit(str1, arg1)
        end,
        onDisabledToolActivated = function(str1: string)
            if GetFFlagEnableMomentTextGeneration() and str1 == "text" and var6(false) and host.onGenerateTextManualEditBlocked ~= nil then
                host.onGenerateTextManualEditBlocked()
            end
        end,
        getActiveModal = getActiveModal,
        showModal = function(arg1)
            var4(arg1)
        end,
        dismissModal = dismissModal,
        getVoiceCoachmarkDismissed = getVoiceCoachmarkDismissed,
        dismissVoiceCoachmark = function()
            var11(true)
        end,
        getSelectedVoiceId = getSelectedVoiceId,
        setSelectedVoiceId = setSelectedVoiceId,
        getIsPublishing = signal,
        publish = function()
            if FFlagMomentsRenderCreatePostStatus and signal(false) then
                return
            end
            local description = store.getDescription(false)
            if host.isTextFiltered ~= nil and host.isTextFiltered(description) then
                var4({ modalType = DialogType.TextFiltered, modalProps = { onConfirm = dismissModal } })
                return
            end

            if not acceptPublishTap() then
                return
            end

            if FFlagMomentsTTSDraftRestore and store.getPendingRestoredVoice(false) ~= nil then
                store.setPendingRestoredVoice(nil)
                store.setCommittedEdit("voice", nil)
            end

            if FFlagMomentTextGenerationFilteredSignal then
                local generatedTextFeedback = store.getGeneratedTextFeedback(false)
                if generatedTextFeedback ~= nil then
                    emitGeneratedTextFeedback(generatedTextFeedback)
                end
            end

            local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
            local moment

            if host.createMoment == nil then
                moment = nil
            else
                local timeLength = preview.playback.getTimeLength(false)
                if FFlagMomentsCommentsCreatorControl then
                    moment = host.createMoment(
                        store.getSelectedCapture(false),
                        getComposedEdits(false),
                        description,
                        sessionId,
                        timeLength,
                        store.getCommentsEnabled(false)
                    )
                else
                    moment = host.createMoment(store.getSelectedCapture(false), getComposedEdits(false), description, sessionId, timeLength)
                end
            end

            local var16 = Cryo.Dictionary.join(
                makeCreationEventFields.makeStepField(EventNames.MomentsEditingFlowPublished),
                makeCreationEventFields.makeCreationBaseFields(sessionId)
            )
            if GetFFlagEnableMomentTextGeneration() then
                local textOverlayEdits = store.getTextOverlayEdits(false)
                local text = if textOverlayEdits == nil or textOverlayEdits[1] == nil then nil else textOverlayEdits[1].text
                var16 = Cryo.Dictionary.join(
                    var16,
                    makeCreationEventFields.makeGeneratedTextOutcomeFields(
                        store.getGeneratedDescription(false),
                        description,
                        store.getGeneratedSummary(false),
                        text
                    )
                )
            end

            local var17 = GetFFlagMomentsTTSAudioOverlay and FFlagMomentsTTSPublishMetadataEdits

            if FFlagMomentsTTSVoiceSelector and not var17 then
                local tts = getComposedEdits(false).tts
                if tts ~= nil then
                    var16 = Cryo.Dictionary.join(var16, { voiceId = tostring(tts.voiceId) })
                end
            end
            if GetFFlagMomentsTTSAudioOverlay and GetFFlagMomentsTTSStartTimePositioning and not var17 then
                local var18 = getComposedEdits(false)
                local tts = var18.tts
                if tts ~= nil then
                    local startTime = tts.startTime or 0
                    local var19 = if var18.trim ~= nil then var18.trim.endTime - var18.trim.startTime else preview.playback.getTimeLength(false)
                    var16 = Cryo.Dictionary.join(var16, {
                        ttsStartTimeSeconds = tostring(startTime),
                        ttsVideoDurationSeconds = tostring(var19),
                        ttsStartTimeFraction = tostring(if var19 > 0 then startTime / var19 else 0)
                    })
                end
            end
            if var17 then
                local var18 = getComposedEdits(false)
                local tts = var18.tts
                if tts ~= nil then
                    local var19 = if var18.trim ~= nil then var18.trim.endTime - var18.trim.startTime else preview.playback.getTimeLength(false)
                    local timeLength = if var15 == nil or var15.getLoadedText(false) ~= tts.text or var15.getLoadedVoiceId(false) ~= tts.voiceId then nil else var15.getTimeLength(false)
                    var16 = Cryo.Dictionary.join(var16, makeCreationEventFields.makeVoicePublishSummaryFields(tts, var19, timeLength))
                end
            end

            if FFlagMomentsTextOverlayV2Redesign then
                local textOverlays = getComposedEdits(false).textOverlays
                var16 = Cryo.Dictionary.join(
                    var16,
                    makeCreationEventFields.makeTextOverlayPublishSummaryFields(textOverlays and textOverlays[1])
                )
            end
            fireAnalyticsEvent(EventNames.MomentsEditingFlowPublished, var16)
            MomentsCommon.Analytics.reportMomentsCreationStep("published")

            local analytics = MomentsCommon.Analytics
            local var18 = getComposedEdits(false)
            local num2 = 0
            if var18.music ~= nil then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("music")
            end
            if var18.trim ~= nil then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("trim")
            end
            if var18.textOverlays ~= nil and #var18.textOverlays > 0 then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("text_overlay")
            end
            if var18.stickerOverlays ~= nil and #var18.stickerOverlays > 0 then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("sticker")
            end
            if description ~= nil and description ~= "" then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("description")
            end

            if GetFFlagMomentsTTSAudioOverlay and var18.tts ~= nil then
                num2 += 1
                analytics.reportMomentsPublishedWithEdit("tts")
            end
            analytics.reportMomentsPublishedEditCount(num2)

            local selectedCapture = store.getSelectedCapture(false)
            if selectedCapture ~= nil then
                local str1 = if selectedCapture.CaptureType == Enum.CaptureType.Video then "video" elseif selectedCapture.CaptureType == Enum.CaptureType.Screenshot then "screenshot" else "unknown"

                analytics.reportMomentsPublishedByCaptureType(str1)
            end
            if FFlagMomentsRenderCreatePostStatus then
                settlePublishResult(moment)
                return
            end
            dismiss()
        end,
        exit = function()
            fireAnalyticsEvent(
                EventNames.MomentsEditingFlowExited,
                withCreationSession(makeCreationEventFields.makeStepField(EventNames.MomentsEditingFlowExited))
            )
            dismiss()
        end,
        generateText = function(str1: string?)
            if var6(false) or host.generateMomentText == nil then
                return
            end

            local capture = store.getSelectedCapture(false)
            if capture == nil then
                return
            end
            if GetFFlagEnableMomentTextGeneration() and host.onGenerateTextWillReplaceInput ~= nil then
                local textOverlayEdits = store.getTextOverlayEdits(false)
                if textOverlayEdits ~= nil and #textOverlayEdits > 0 then
                    host.onGenerateTextWillReplaceInput()
                end
            end
            var7(true)
            local promise = host.generateMomentText(capture, str1)
            if promise == nil then
                var7(false)
                return
            end
            if GetFFlagEnableMomentTextGeneration() then
                var9({ promise = promise, capture = capture })
            end

            promise:andThen(function(arg1)
                if GetFFlagEnableMomentTextGeneration() then
                    var9(nil)
                end
                if FFlagMomentTextGenerationFilteredSignal and arg1 ~= nil and arg1.error == "CONTENT_FILTERED" then
                    fireAnalyticsEvent(EventNames.EditingFlowGenerateTextFiltered, withCreationSession({}))
                    MomentsCommon.Analytics.reportMomentsGenerateText("filtered")
                    if host.onGenerateTextFiltered ~= nil then
                        host.onGenerateTextFiltered()
                    end
                    var7(false)
                    return
                end

                if arg1 == nil or arg1.error ~= nil then
                    fireAnalyticsEvent(EventNames.EditingFlowGenerateTextFailed, withCreationSession({}))
                    MomentsCommon.Analytics.reportMomentsGenerateText("failed")
                    if host.onGenerateTextFailure ~= nil then
                        host.onGenerateTextFailure()
                    end
                    var7(false)
                    return
                end

                if arg1.summary ~= nil and arg1.summary ~= "" then
                    local textOverlayEdits = store.getTextOverlayEdits(false)
                    local textOverlayEdit = if textOverlayEdits == nil then nil else textOverlayEdits[1]
                    local defaultTextOverlayEdit

                    if GetFFlagEnableMomentTextGeneration() and textOverlayEdit ~= nil then
                        defaultTextOverlayEdit = table.clone(textOverlayEdit)
                        defaultTextOverlayEdit.text = arg1.summary
                    else
                        defaultTextOverlayEdit = makeDefaultTextOverlayEdit()
                        defaultTextOverlayEdit.text = arg1.summary
                    end

                    local var17

                    if textOverlayEdits == nil or #textOverlayEdits == 0 then
                        var17 = { defaultTextOverlayEdit }
                    else
                        var17 = table.clone(textOverlayEdits)
                        var17[1] = defaultTextOverlayEdit
                    end
                    store.updateTextOverlayEdits(var17)

                    if GetFFlagMomentsGenerateTextInTextOverlay() then
                        local activeSession = getActiveSession(false)
                        local var18 = getActiveTool(false)
                        if activeSession ~= nil and var18 ~= nil and var18.kind == "text" then
                            local draft = activeSession.getDraft(false)
                            local var19 = draft and draft[1]
                            if var19 ~= nil then
                                local var20 = table.clone(var19)
                                var20.text = arg1.summary
                                activeSession.update({ var20 })
                            else
                                activeSession.update(var17)
                            end
                        end
                    end

                    if GetFFlagEnableMomentTextGeneration() then
                        store.setGeneratedSummary(arg1.summary)
                    end
                end
                if arg1.description ~= nil and arg1.description ~= "" then
                    store.updateDescription(arg1.description)

                    if FFlagMomentTextGenerationFilteredSignal or GetFFlagEnableMomentTextGeneration() then
                        store.setGeneratedDescription(arg1.description)
                        store.setGenerationToken(arg1.generationToken)

                        store.setGeneratedTextFeedback(nil)
                    end
                end
                fireAnalyticsEvent(EventNames.EditingFlowGenerateTextSucceeded, withCreationSession({}))
                MomentsCommon.Analytics.reportMomentsGenerateText("succeeded")
                if host.onGenerateTextSuccess ~= nil then
                    host.onGenerateTextSuccess()
                end
                var7(false)
            end):catch(function()
                if GetFFlagEnableMomentTextGeneration() then
                    var9(nil)
                end
                fireAnalyticsEvent(EventNames.EditingFlowGenerateTextFailed, withCreationSession({}))
                MomentsCommon.Analytics.reportMomentsGenerateText("failed")
                if host.onGenerateTextFailure ~= nil then
                    host.onGenerateTextFailure()
                end
                var7(false)
            end)
        end,
        getIsGenerating = var6,
        getCanGenerateText = function(_): boolean
            if host.generateMomentText == nil then
                return false
            end
            if not FFlagMomentsTextOverlayOnPhotos then
                return true
            end
            local selectedCapture = store.getSelectedCapture(false)
            return not (selectedCapture == nil) and selectedCapture.CaptureType == Enum.CaptureType.Video
        end,
        submitGeneratedTextFeedback = submitGeneratedTextFeedback,
        preview = preview,
        ttsAudio = var15,
        ttsAudioParent = host.ttsAudioParent
    }

    return var2
end

return createCreationController
