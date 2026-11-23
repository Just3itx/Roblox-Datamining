-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local useChatPlaytestFooter = require(BuildExperience.Chat.useChatPlaytestFooter)
local useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local _ChatSheetView = require(BuildExperience.Components.ChatSheet.ChatSheetView)
local _useChatSheetViewModel = require(BuildExperience.Components.ChatSheet.useChatSheetViewModel)
local GetAssistantBuildStore = require(BuildExperience.Stores.GetAssistantBuildStore)
local GetCreatorAgentResumeStore = require(BuildExperience.Stores.GetCreatorAgentResumeStore)
local GetLibraryStore = require(BuildExperience.Stores.GetLibraryStore)
local getCurrentExperienceProject = require(BuildExperience.utils.getCurrentExperienceProject)
local useLibraryChatComposer = require(script.Parent.useLibraryChatComposer)
local chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local useGamePermissions = require(BuildExperience.useGamePermissions)

local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local useBuildModelSelection = require(BuildExperience.Chat.useBuildModelSelection)
local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)

local useChatSheetFundingRecovery = require(BuildExperience.Components.ChatSheet.useChatSheetFundingRecovery)

local function noop() end

local function useLibraryChatSheetViewModel(arg1)
    local onClose = arg1.onClose or noop
    local var2 = arg1.isOpen == nil or arg1.isOpen
    local var3 = SignalsReact.useSignalState(GetAssistantBuildStore().getIsDisabled)
    local creatorAgentResumeStore = GetCreatorAgentResumeStore()
    local currentExperienceProject = getCurrentExperienceProject()
    local universeId = arg1.universeId or currentExperienceProject.universeId
    local var4, var5, bool1

    if FFlagBuildCheckGamePermissions then
        var4, var5 = useGamePermissions({ universeId = universeId })

        bool1 = not var4.canEditOnBuild
    else
        bool1 = false
        var5 = false
        var4 = nil
    end

    local var6 = useChatSessionCore({
        universeId = universeId,
        placeId = arg1.placeId or currentExperienceProject.placeId,
        sessionId = arg1.sessionId,
        autoFocusComposer = false,
        hydrateHistoryWhen = var2,
        sendMessageWhen = not bool1,
        isLibraryChat = true,
        onPromptFailure = GetLibraryStore().reportPromptFailure
    })
    local var7 = useChatPlaytestFooter(var6, "ChatSheetPlaytestCta")
    local modelPicker = if FFlagBuildExperienceModelPicker then useBuildModelSelection(
        universeId,
        arg1.modelSelectionDraftId,
        arg1.modelPicker,
        var6.modelSessionModels,
        var6.hasPreparedModelSession,
        var6.internalTesting
    ) else nil
    local isComposerSendBlocked = useLibraryChatComposer(var6, var2, bool1, modelPicker)

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

        creatorAgentResumeStore.setActiveTarget({ universeId = universeId, sessionId = arg1.sessionId })

        return function()
            creatorAgentResumeStore.setActiveTarget(nil)
        end
    end, {
        creatorAgentResumeStore,
        var2,
        universeId,
        arg1.sessionId
    })
    local composerResourceAttachments = var6.composerResourceAttachments
    local removeComposerResourceAttachmentAtIndex = var6.removeComposerResourceAttachmentAtIndex
    local onRemoveComposerResourceAttachment = React.useCallback(function(num1: number)
        local composerResourceAttachment = composerResourceAttachments[num1]
        removeComposerResourceAttachmentAtIndex(num1)
        if composerResourceAttachment ~= nil then
            GetLibraryStore().reportChipEvent("Removed", { chatTypes.getResourceAttachmentUri(composerResourceAttachment) })
        end
    end, { composerResourceAttachments, removeComposerResourceAttachmentAtIndex })
    local onActivateComposerResourceAttachment = React.useCallback(function(num1: number)
        local composerResourceAttachment = composerResourceAttachments[num1]
        if composerResourceAttachment ~= nil then
            GetLibraryStore().reportChipEvent("Activated", { chatTypes.getResourceAttachmentUri(composerResourceAttachment) })
        end
    end, { composerResourceAttachments })
    local sendMessage = var6.sendMessage
    local onSend = React.useCallback(function(func1: ((...any) -> (...any))?)
        local tbl1 = {}
        for _, composerResourceAttachment in composerResourceAttachments do
            table.insert(tbl1, chatTypes.getResourceAttachmentUri(composerResourceAttachment))
        end
        local var12 = sendMessage(func1)
        if var12 and #tbl1 > 0 then
            GetLibraryStore().reportChipEvent("Sent", tbl1)
        end
        return var12
    end, { composerResourceAttachments, sendMessage })

    local creatorCreditRecovery = if FFlagBuildExperienceModelPicker then useChatSheetFundingRecovery(
        var6,
        modelPicker,
        universeId,
        arg1.placeId or currentExperienceProject.placeId,
        arg1.sessionId
    ) else nil
    return {
        isOpen = var2,
        creatorCreditRecovery = creatorCreditRecovery,
        onClose = onClose,
        sheetComponent = Foundation.Sheet,
        snapPoints = arg1.snapPoints,
        defaultSnapPointIndex = arg1.defaultSnapPointIndex,
        messages = var6.messages,
        localToolActions = var6.localToolActions,
        answerForm = if FFlagBuildExperienceAnswerForm then var6.answerForm else nil,
        onSubmitAnswerText = if FFlagBuildExperienceAnswerForm then var6.submitAnswerText else nil,
        clockBinding = var6.clockBinding,
        onPlaytest = var7.onPlaytest,
        isPlaytestLoading = var7.isPlaytestLoading,
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
        onRemoveComposerResourceAttachment = onRemoveComposerResourceAttachment,
        onActivateComposerResourceAttachment = onActivateComposerResourceAttachment,
        isComposerSendBlocked = isComposerSendBlocked,
        tracksExternalComposerText = true,
        textBoxRef = var6.textBoxRef,
        isAssistantResponding = var6.isAssistantResponding,
        canStopAssistantResponse = var6.canStopAssistantResponse,
        canSendWhileResponding = var6.canSendWhileResponding,
        allowsComposerTypingWhileResponding = true,
        isChatReadOnly = bool1,
        chatPermissions = var4,
        reservesHandleSpace = true,
        onSend = onSend,
        onStop = var6.stopAssistantResponse,
        onOpenChat = noop
    }
end

return useLibraryChatSheetViewModel
