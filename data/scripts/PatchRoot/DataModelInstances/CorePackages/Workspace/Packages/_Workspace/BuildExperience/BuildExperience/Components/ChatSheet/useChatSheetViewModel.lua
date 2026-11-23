-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local useBuildModelSelection = require(BuildExperience.Chat.useBuildModelSelection)

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local useChatPlaytestFooter = require(BuildExperience.Chat.useChatPlaytestFooter)
local useBuildPromptDraft = require(BuildExperience.Chat.useBuildPromptDraft)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)

local FFlagBuildExperienceDeveloperProductContext = require(BuildExperience.Flags.FFlagBuildExperienceDeveloperProductContext)
local useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)

local FFlagBuildExperienceChatSheetDesktopAutoFocus = require(BuildExperience.Flags.FFlagBuildExperienceChatSheetDesktopAutoFocus)
local Responsive = require(BuildExperienceParent.Responsive)
local _BuildPillMenuPortal = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPortal)
local GetAssistantBuildStore = require(BuildExperience.Stores.GetAssistantBuildStore)
local GetCreatorAgentResumeStore = require(BuildExperience.Stores.GetCreatorAgentResumeStore)
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)
local getCurrentExperienceProject = require(BuildExperience.utils.getCurrentExperienceProject)
local _ChatSheetView = require(script.Parent.ChatSheetView)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local FFlagBuildExperienceAnalytics = SharedFlags.FFlagBuildExperienceAnalytics
local FFlagBuildExperienceInstanceSelection = SharedFlags.FFlagBuildExperienceInstanceSelection

local FFlagBuildExperienceInGameCaptureToChat = SharedFlags.FFlagBuildExperienceInGameCaptureToChat
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local useGamePermissions = require(BuildExperience.useGamePermissions)

local useChatSheetFundingRecovery = require(BuildExperience.Components.ChatSheet.useChatSheetFundingRecovery)

local function noop() end

local function useChatSheetViewModel(tbl1)
    local onClose = tbl1.onClose or noop
    local var2 = tbl1.isOpen == nil or tbl1.isOpen
    local assistantBuildStore = GetAssistantBuildStore()
    local var3 = SignalsReact.useSignalState(assistantBuildStore.getIsDisabled)
    local creatorAgentResumeStore = GetCreatorAgentResumeStore()
    local currentExperienceProject = getCurrentExperienceProject()
    local universeId = tbl1.universeId or currentExperienceProject.universeId
    local placeId = tbl1.placeId or currentExperienceProject.placeId
    local var4, var5, bool1

    if FFlagBuildCheckGamePermissions then
        var4, var5 = useGamePermissions({ universeId = universeId })

        bool1 = not var4.canEditOnBuild
    else
        bool1 = false
        var5 = false
        var4 = nil
    end

    local bool2 = tbl1.autoFocusComposer == true
    if FFlagBuildExperienceChatSheetDesktopAutoFocus then
        local bool3 = Responsive.usePreferredInput() == Responsive.Input.Pointer
        bool2 = bool2 or bool3
    end

    local var6 = useChatSessionCore({
        universeId = universeId,
        placeId = placeId,
        sessionId = tbl1.sessionId,
        autoFocusComposer = bool2,
        focusComposerWhen = var2,
        hydrateHistoryWhen = var2,
        sendMessageWhen = not bool1
    })
    local modelPicker = if FFlagBuildExperienceModelPicker then useBuildModelSelection(
        universeId,
        tbl1.modelSelectionDraftId,
        tbl1.modelPicker,
        var6.modelSessionModels,
        var6.hasPreparedModelSession,
        var6.internalTesting
    ) else nil

    if FFlagBuildExperienceMonetizationNativeUI then
        local var8 = useBuildPromptDraft

        local sessionId = tbl1.sessionId
        local setPrefilledComposerText = var6.setPrefilledComposerText
        local sendMessage = var6.sendMessage
        var8(
            universeId,
            sessionId,
            setPrefilledComposerText,
            sendMessage,
            var2 and not var3,
            if FFlagBuildExperienceDeveloperProductContext then var6 else nil
        )
    end

    local var8 = useChatPlaytestFooter(var6, "ChatSheetPlaytestCta")

    if FFlagBuildExperienceInstanceSelection then
        local playButtonStore = GetPlayButtonStore()

        local var9 = SignalsReact.useSignalState(playButtonStore.getPendingResourceAttachment)

        React.useEffect(function()
            if var9 == nil then
                return
            end
            local resourceAttachmentUri = chatTypes.getResourceAttachmentUri(var9)
            if var6.findComposerResourceAttachmentIndexByUri(resourceAttachmentUri) == nil then
                var6.addComposerResourceAttachment(var9)
            end
            playButtonStore.setPendingResourceAttachment(nil)
        end, { var9, var6.addComposerResourceAttachment, var6.findComposerResourceAttachmentIndexByUri })
    end

    if FFlagBuildExperienceInGameCaptureToChat then
        local var9 = React.useRef(nil)

        React.useEffect(function()
            if tbl1.captureToAttach == nil or var9.current == tbl1.captureToAttach then
                return
            end

            var9.current = tbl1.captureToAttach
            local var10 = table.clone(var6.composerImages)
            if #var10 >= 2 then
                table.remove(var10, 1)
            end
            table.insert(var10, { capture = tbl1.captureToAttach })
            var6.setComposerImages(var10)
            if tbl1.onCaptureAttached ~= nil then
                tbl1.onCaptureAttached()
            end
        end, {
            tbl1.captureToAttach,
            tbl1.onCaptureAttached,
            var6.composerImages,
            var6.setComposerImages
        })
    end

    local func1 = noop
    if FFlagBuildExperienceAnalytics then
        local var9, var10 = React.useState(nil)

        func1 = React.useCallback(function(str1: string)
            var6.setComposerText(str1)
            var10(str1)
        end, { var6.setComposerText })

        React.useEffect(function()
            if var9 == nil then
                return
            end

            var6.setComposerText(var9)
            if var6.sendMessage() then
                var10(nil)
            end
        end, { var9, var6.sendMessage, var6.setComposerText })
    end

    React.useEffect(function()
        if var2 and var3 then
            onClose()
        end
    end, { var2, var3, onClose })

    React.useEffect(function()
        if not var2 then
            creatorAgentResumeStore.setActiveTarget(nil)
            return
        end

        creatorAgentResumeStore.setActiveTarget({ universeId = universeId, sessionId = tbl1.sessionId })

        return function()
            creatorAgentResumeStore.setActiveTarget(nil)
        end
    end, {
        creatorAgentResumeStore,
        var2,
        universeId,
        tbl1.sessionId
    })

    local creatorCreditRecovery = if FFlagBuildExperienceModelPicker then useChatSheetFundingRecovery(var6, modelPicker, universeId, placeId, tbl1.sessionId) else nil
    return {
        isOpen = var2,
        creatorCreditRecovery = creatorCreditRecovery,
        onClose = onClose,
        snapPoints = tbl1.snapPoints,
        defaultSnapPointIndex = tbl1.defaultSnapPointIndex,
        messages = var6.messages,
        localToolActions = var6.localToolActions,
        answerForm = if FFlagBuildExperienceAnswerForm then var6.answerForm else nil,
        onSubmitAnswerText = if FFlagBuildExperienceAnswerForm then var6.submitAnswerText else nil,
        clockBinding = var6.clockBinding,
        onPlaytest = var8.onPlaytest,
        isPlaytestLoading = var8.isPlaytestLoading,
        isHistoryLoading = var6.isHistoryLoading or var5,
        scrollingFrameRef = var6.setScrollingFrame,
        anchorScrollToInstance = var6.anchorScrollToInstance,
        modelPicker = modelPicker,
        composerText = var6.composerText,
        composerErrorText = var6.composerErrorText,
        onComposerChanged = var6.setComposerText,
        composerImages = var6.composerImages,
        onComposerImagesChanged = var6.setComposerImages,
        onRetryComposerImage = var6.retryComposerImage,
        composerResourceAttachments = var6.composerResourceAttachments,
        onRemoveComposerResourceAttachment = var6.removeComposerResourceAttachmentAtIndex,
        isComposerSendBlocked = var6.isComposerSendBlocked,
        textBoxRef = var6.textBoxRef,
        isAssistantResponding = var6.isAssistantResponding,
        canStopAssistantResponse = var6.canStopAssistantResponse,
        canSendWhileResponding = var6.canSendWhileResponding,
        isChatReadOnly = bool1,
        chatPermissions = var4,
        onSend = var6.sendMessage,
        onStop = var6.stopAssistantResponse,
        onOpenChat = func1,
        topBarPillMenuTarget = tbl1.topBarPillMenuTarget
    }
end

return useChatSheetViewModel
