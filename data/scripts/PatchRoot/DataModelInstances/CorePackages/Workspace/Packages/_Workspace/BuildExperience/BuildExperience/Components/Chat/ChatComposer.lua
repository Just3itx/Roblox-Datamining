-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local ModelPickerContainer = if FFlagBuildExperienceModelPicker then require(BuildExperience.Components.ModelPicker.ModelPickerContainer) else nil
local ChatActionsRow = require(script.Parent.ChatActionsRow)
local var1 = if require(BuildExperience.Flags.FFlagBuildExperienceUseCommonTextArea) then require(BuildExperienceParent.AppBlox).Composer else require(BuildExperience.FoundationFork.TextArea)
local useReleaseFocusOnDownSwipe = require(script.Parent.useReleaseFocusOnDownSwipe)

local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local function trimMessage(str1: string) -- Luacid: Inlined by compiler; 7 call sites recovered
    return string.gsub(str1, "^%s*(.-)%s*$", "%1")
end

local function ChatComposer(tbl1)
    local var2 = useTokens()
    local ref = React.useRef(nil)
    local var4 = React.useMemo(function()
        local bool1 = trimMessage((tbl1.text:getValue())) == ""
        local getIsComposerEmpty, setIsComposerEmpty = Signals.createSignal(bool1)
        return { getIsComposerEmpty = getIsComposerEmpty, setIsComposerEmpty = setIsComposerEmpty }
    end, { tbl1.text })

    local var5 = tbl1.isAssistantResponding and tbl1.canSendWhileResponding ~= true
    local bool1 = false
    if FFlagBuildExperienceLibrary and tbl1.allowsTypingWhileResponding == true then
        bool1 = var5
        var5 = false
    end

    local modelPicker = if FFlagBuildExperienceModelPicker then tbl1.modelPicker else nil
    local isStopDisabled = tbl1.isReadOnly == true
    if isStopDisabled then
        var5 = true
    end

    local hasError = tbl1.composerErrorText ~= nil
    local hasAttachments = not (tbl1.images == nil) and #tbl1.images > 0
    local var6 = tbl1.isAttachmentSupported and tbl1.onOpenCaptureGallery ~= nil

    local onChanged = React.useCallback(function(str1: string)
        var4.setIsComposerEmpty(trimMessage(str1) == "")
        tbl1.onChanged(str1)
    end, { tbl1.onChanged, var4 })

    local useCallback = React.useCallback
    local function func1()
        if bool1 then
            return
        end
        if tbl1.onSend() then
            var4.setIsComposerEmpty(not FFlagBuildExperienceModelPicker or trimMessage((tbl1.text:getValue())) == "")
        end
    end

    local onSend = tbl1.onSend
    local var8 = bool1
    local text = if FFlagBuildExperienceModelPicker then tbl1.text else nil
    local var9 = useCallback(func1, { onSend, var4, var8, text })

    local onActivated = React.useCallback(function()
        if tbl1.textBoxRef ~= nil and tbl1.textBoxRef.current ~= nil then
            tbl1.textBoxRef.current.releaseFocus()
        end
        if tbl1.onOpenCaptureGallery ~= nil then
            tbl1.onOpenCaptureGallery()
        end
    end, { tbl1.textBoxRef, tbl1.onOpenCaptureGallery })

    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            local function updateEmptyState(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
                var4.setIsComposerEmpty(trimMessage(str1) == "")
            end
            local var11 = React.__subscribeToBinding(tbl1.text, updateEmptyState)
            updateEmptyState((tbl1.text:getValue()))
            return var11
        end, { tbl1.text, var4 })
    elseif FFlagBuildExperienceLibrary then
        React.useEffect(function()
            if not tbl1.tracksExternalText then
                return nil
            end
            local function updateEmptyState(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
                var4.setIsComposerEmpty(trimMessage(str1) == "")
            end
            local var11 = React.__subscribeToBinding(tbl1.text, updateEmptyState)
            updateEmptyState((tbl1.text:getValue()))
            return var11
        end, { tbl1.tracksExternalText, tbl1.text, var4 })
    end

    useReleaseFocusOnDownSwipe(ref, tbl1.textBoxRef)

    local var11 = FFlagBuildExperienceModelPicker
    local size100 = var2.Size.Size_100
    local str1, var12, var13

    if var11 then
        size100 = var2.Padding.Small - var2.Stroke.Standard
        str1 = "row align-y-center gap-small auto-xy"
        var12 = 1
        var13 = 3
    else
        str1 = "auto-xy"
        var12 = nil
        var13 = nil
    end

    local element

    if var6 or modelPicker ~= nil then
        element = React.createElement(View, {
            padding = {
                top = UDim.new(0, var2.Size.Size_200),
                bottom = UDim.new(0, var2.Size.Size_200 - 1),
                left = UDim.new(0, size100)
            },
            tag = str1
        }, {
            Attach = if var6 then React.createElement(IconButton, {
                LayoutOrder = var12,
                icon = IconName.PlusSmall,
                isCircular = true,
                isDisabled = tbl1.isAssistantResponding or isStopDisabled,
                onActivated = onActivated,
                size = InputSize.Small,
                variant = ButtonVariant.Standard,
                testId = "ChatComposer.AttachImage"
            }) else nil,
            Picker = if modelPicker == nil then nil else React.createElement(ModelPickerContainer, {
                LayoutOrder = 2,
                internalTesting = modelPicker.internalTesting,
                data = modelPicker.data,
                selectedId = modelPicker.selectedId,
                onSelect = modelPicker.onSelect,
                isDisabled = tbl1.isAssistantResponding or isStopDisabled or modelPicker.isDisabled == true
            })
        })
    else
        element = nil
    end

    local element2 = React.createElement(View, {
        LayoutOrder = var13,
        padding = {
            top = UDim.new(0, var2.Size.Size_200),
            bottom = UDim.new(0, var2.Size.Size_200 - 1),
            left = UDim.new(0, 0),
            right = UDim.new(0, size100)
        },
        tag = { ["auto-xy"] = true }
    }, {
        Actions = React.createElement(ChatActionsRow, {
            isAssistantResponding = tbl1.isAssistantResponding,
            canStopAssistantResponse = tbl1.canStopAssistantResponse,
            canSendWhileResponding = tbl1.canSendWhileResponding,
            getIsComposerEmpty = var4.getIsComposerEmpty,
            hasAttachments = hasAttachments,
            isSendDisabled = not FFlagBuildExperienceModelPicker and hasError or tbl1.isSendBlocked == true or isStopDisabled,
            isStopDisabled = isStopDisabled,
            onSend = var9,
            onStop = tbl1.onStop
        })
    })
    local footerElement = if var11 then React.createElement(
        View,
        { tag = "row align-y-center size-full-0 auto-y" },
        {
            Leading = element,
            Spacer = React.createElement(View, { LayoutOrder = 2, tag = "fill" }),
            Trailing = element2
        }
    ) else nil
    local createElement = React.createElement
    local var14 = var1
    local tbl2 = {
        text = tbl1.text,
        onChanged = onChanged,
        label = "",
        hint = tbl1.composerErrorText,
        hasError = hasError,
        placeholder = tbl1.placeholder or "",
        width = UDim.new(1, 0),
        size = InputSize.Large,
        maxLines = tbl1.maxLines or 5,
        isDisabled = var5,
        onReturnPressed = var9,
        textBoxRef = tbl1.textBoxRef,
        ref = ref,
        composerDebug = tbl1.composerDebug,
        LayoutOrder = tbl1.LayoutOrder,
        leadingElement = 0,
        trailingElement = 0,
        footerElement = 0
    }

    if var11 then
        element = nil
    end

    tbl2.leadingElement = element
    if var11 then
        element2 = nil
    end

    tbl2.trailingElement = element2
    tbl2.footerElement = footerElement
    return createElement(var14, tbl2)
end

return ChatComposer
