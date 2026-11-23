-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local GetLibraryStore = require(BuildExperience.Stores.GetLibraryStore)
local _createLibraryStore = require(BuildExperience.Stores.GetLibraryStore.createLibraryStore)
local LibraryTypes = require(script.Parent.LibraryTypes)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)

local function useLibraryChatComposer(current, bool1: boolean, isReadOnly: boolean?, modelPicker)
    local libraryStore = GetLibraryStore()
    local var1 = SignalsReact.useSignalState(libraryStore.getChatResourceRequest)
    local var2 = React.useRef(0)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(current)
    var4.current = current
    local onAddResource = React.useCallback(function(arg2): boolean
        local current2 = var4.current
        local var5 = LibraryTypes.toResourceAttachment(arg2)
        if current2.findComposerResourceAttachmentIndexByUri(var5.uri) ~= nil then
            return false
        end
        current2.addComposerResourceAttachment(var5)
        return true
    end, {})
    local onRemoveResourceByPath = React.useCallback(function(str1: string): boolean
        local current2 = var4.current
        local composerResourceAttachmentIndexByUri = current2.findComposerResourceAttachmentIndexByUri(LibraryTypes.toResourceUri(str1))
        if composerResourceAttachmentIndexByUri == nil then
            return false
        end
        current2.removeComposerResourceAttachmentAtIndex(composerResourceAttachmentIndexByUri)
        return true
    end, {})
    local isSendBlocked = current.isComposerSendBlocked or current.isAssistantResponding and #current.composerResourceAttachments > 0
    local answerForm = if FFlagBuildExperienceAnswerForm then current.answerForm else nil
    local localToolActions = if FFlagBuildExperienceAnswerForm then current.localToolActions else nil
    local submitAnswerText = if FFlagBuildExperienceAnswerForm then current.submitAnswerText else nil

    React.useEffect(function()
        if var1 == nil or var1.token <= var2.current then
            return
        end
        var2.current = var1.token
        local resources = var1.resources
        if var1.action == "Remove" then
            for _, value in resources do
                onRemoveResourceByPath(value.path)
            end
        else
            local tbl1 = {}
            for _, value in resources do
                tbl1[value.path] = true
            end
            for _, replacePath in var1.replacePaths do
                if not tbl1[replacePath] then
                    onRemoveResourceByPath(replacePath)
                end
            end
            for _, value in resources do
                onAddResource(value)
            end
        end
        libraryStore.consumeChatResourceRequest(var1.token)

        if bool1
            and answerForm == nil
            and var1.action == "Add"
            and var1.focusComposer ~= false
            and current.textBoxRef.current ~= nil
        then
            current.textBoxRef.current.focus()
        end
    end, {
        libraryStore,
        var1,
        bool1,
        answerForm,
        onAddResource,
        onRemoveResourceByPath,
        current.textBoxRef
    })

    React.useLayoutEffect(function()
        local tbl1 = {
            modelPicker = modelPicker,
            answerForm = answerForm,
            localToolActions = localToolActions,
            onSubmitAnswerText = submitAnswerText,
            composerText = current.composerText,
            composerErrorText = current.composerErrorText,
            onComposerChanged = current.setComposerText,
            images = current.composerImages,
            onImagesChanged = current.setComposerImages,
            onRetryImage = current.retryComposerImage,
            resourceAttachments = current.composerResourceAttachments,
            onAddResource = onAddResource,
            onRemoveResourceAttachment = current.removeComposerResourceAttachmentAtIndex,
            onRemoveResourceByPath = onRemoveResourceByPath,
            isSendBlocked = isSendBlocked,
            isReadOnly = isReadOnly,
            tracksExternalText = true,
            textBoxRef = current.textBoxRef,
            isAssistantResponding = current.isAssistantResponding,
            canStopAssistantResponse = current.canStopAssistantResponse,
            canSendWhileResponding = current.canSendWhileResponding,
            onSend = current.sendMessage,
            onStop = current.stopAssistantResponse
        }
        var3.current = tbl1
        libraryStore.setChatComposerState(tbl1)
    end, {
        libraryStore,
        modelPicker,
        current.composerText,
        answerForm,
        localToolActions,
        submitAnswerText,
        current.composerErrorText,
        current.setComposerText,
        current.composerImages,
        current.setComposerImages,
        current.retryComposerImage,
        current.composerResourceAttachments,
        onAddResource,
        current.removeComposerResourceAttachmentAtIndex,
        onRemoveResourceByPath,
        isSendBlocked,
        isReadOnly,
        current.textBoxRef,
        current.isAssistantResponding,
        current.canStopAssistantResponse,
        current.canSendWhileResponding,
        current.sendMessage,
        current.stopAssistantResponse
    })

    React.useEffect(function()
        return function()
            if libraryStore.getChatComposerState(false) == var3.current then
                libraryStore.setChatComposerState(nil)
            end
        end
    end, { libraryStore })
    return isSendBlocked
end

return useLibraryChatComposer
