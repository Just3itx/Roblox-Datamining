-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local FFlagBuildEnableFTUXChips = require(BuildExperience.Flags.FFlagBuildEnableFTUXChips)

local FFlagBuildExperienceFTUXChipExhaustedTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipExhaustedTelemetry)
local isImageAttachmentSupported = require(BuildExperience.utils.isImageAttachmentSupported)

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local createGalleryCaptureSource = require(BuildExperienceParent.Moments.createGalleryCaptureSource)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local ChatCaptureGalleryContainer = require(script.Parent.ChatCaptureGallery.ChatCaptureGalleryContainer)
local ChatComposer = require(script.Parent.ChatComposer)
local ChatImagePreviewList = require(script.Parent.ChatImagePreviewList)
local PromptChipGroup = require(script.Parent.PromptChipGroup)
local ChatResourceAttachmentList = require(script.Parent.ChatResourceAttachmentList)

local View = Foundation.View

local function ChatActions(tbl1)
    local images = tbl1.images or {}
    local attachments = tbl1.resourceAttachments or {}
    local promptChips = tbl1.promptChips or {}
    local bool1 = #images > 0
    local bool2 = #attachments > 0
    local var3 = FFlagBuildEnableFTUXChips and (#promptChips > 0 or tbl1.isPromptChipsLoading == true)
    local layoutOrder = bool2 and (if bool1 then 3 else 2) or (if bool1 then 2 else 1)
    local var4, var5 = React.useState("unmounted")
    local var6 = React.useRef(nil)
    local var7 = React.useRef(false)
    local isAttachmentSupported = not (tbl1.allowImageAttachments == false) and isImageAttachmentSupported()

    local function setCapturedImages(tbl2)
        if tbl1.onImagesChanged == nil then
            return
        end
        local tbl3 = {}
        for _, capture in tbl2 do
            local var9 = nil
            for _, value2 in images do
                if value2.capture == capture then
                    var9 = value2
                    break
                end
            end

            table.insert(tbl3, var9 or { capture = capture })
        end
        tbl1.onImagesChanged(tbl3)
    end

    local function openCaptureGallery()
        var7.current = true
        var6.current = createGalleryCaptureSource(nil, nil, { Enum.CaptureType.Screenshot })
        var5("open")
    end

    local function requestCloseCaptureGallery() -- Luacid: Inlined by compiler; 1 call site recovered
        var5("closing")
    end

    local function confirmCaptureGallery(tbl2)
        setCapturedImages(tbl2)
        requestCloseCaptureGallery()
    end

    local function handleCaptureGalleryClosed()
        var5("unmounted")
    end

    local function removeImage(num2: number)
        if tbl1.onImagesChanged == nil then
            return
        end
        local var9 = table.clone(images)
        table.remove(var9, num2)
        tbl1.onImagesChanged(var9)
    end

    local initialCaptures = {}
    for _, value in images do
        if value.capture ~= nil then
            table.insert(initialCaptures, value.capture)
        end
    end

    local createElement = React.createElement
    local var9 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col gap-small size-full-0 auto-y"
    }
    local tbl4 = {
        ResourceAttachments = if bool2 then React.createElement(ChatResourceAttachmentList, {
            LayoutOrder = 1,
            attachments = attachments,
            onRemove = tbl1.onRemoveResourceAttachment,
            onActivateAttachment = tbl1.onActivateResourceAttachment,
            testId = "ChatActions.ResourceAttachments"
        }) else nil,
        Images = if bool1 then React.createElement(ChatImagePreviewList, {
            LayoutOrder = if bool2 then 2 else 1,
            images = images,
            onRemove = removeImage,
            onRetry = tbl1.onRetryImage,
            testId = "ChatActions.Images"
        }) else nil,
        Composer = 0,
        PromptChips = 0,
        Gallery = 0
    }

    local createElement2 = React.createElement
    local var10 = ChatComposer
    local tbl5 = {
        LayoutOrder = layoutOrder,
        modelPicker = if FFlagBuildExperienceModelPicker then tbl1.modelPicker else nil,
        text = tbl1.composerText,
        composerErrorText = tbl1.composerErrorText,
        onChanged = tbl1.onComposerChanged,
        placeholder = tbl1.placeholder,
        textBoxRef = tbl1.textBoxRef,
        isAssistantResponding = tbl1.isAssistantResponding,
        canStopAssistantResponse = tbl1.canStopAssistantResponse,
        canSendWhileResponding = tbl1.canSendWhileResponding,
        allowsTypingWhileResponding = tbl1.allowsTypingWhileResponding,
        images = images,
        isSendBlocked = tbl1.isSendBlocked,
        isReadOnly = tbl1.isReadOnly,
        tracksExternalText = tbl1.tracksExternalText,
        isAttachmentSupported = isAttachmentSupported,
        onOpenCaptureGallery = 0,
        onSend = 0,
        onStop = 0,
        maxLines = 0,
        composerDebug = 0
    }

    if not isAttachmentSupported then
        openCaptureGallery = nil
    end

    tbl5.onOpenCaptureGallery = openCaptureGallery
    tbl5.onSend = tbl1.onSend
    tbl5.onStop = tbl1.onStop
    tbl5.maxLines = tbl1.maxLines
    tbl5.composerDebug = tbl1.composerDebug
    tbl4.Composer = createElement2(var10, tbl5)
    local element = if var3 then React.createElement(PromptChipGroup, {
        LayoutOrder = layoutOrder + 1,
        promptChips = promptChips,
        isLoading = tbl1.isPromptChipsLoading,
        onActivated = tbl1.onPromptChipActivated,
        onExhausted = if FFlagBuildExperienceFTUXChipExhaustedTelemetry then tbl1.onPromptChipExhausted else nil
    }) else nil
    tbl4.PromptChips = element

    tbl4.Gallery = if var4 == "unmounted" or var6.current == nil then nil else React.createElement(
        ChatCaptureGalleryContainer,
        {
            captureSource = var6.current,
            initialCaptures = initialCaptures,
            isOpen = var4 == "open",
            maxSelections = 2,
            onClose = handleCaptureGalleryClosed,
            onConfirm = confirmCaptureGallery,
            shouldProgressivelyLoad = var7.current
        }
    )
    return createElement(var9, tbl3, tbl4)
end

return ChatActions
