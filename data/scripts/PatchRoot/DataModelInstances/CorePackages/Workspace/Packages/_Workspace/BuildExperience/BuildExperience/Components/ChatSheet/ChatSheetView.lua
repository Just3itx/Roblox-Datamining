-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary

local Foundation = require(BuildExperienceParent.Foundation)
local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local InputHandlers = require(BuildExperienceParent.InputHandlers)
local React = require(BuildExperienceParent.React)
local _ReactFocusNavigation = require(BuildExperienceParent.ReactFocusNavigation)
local ReactUtils = require(BuildExperienceParent.ReactUtils)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local BuildEmptyState = require(BuildExperience.Components.BuildEmptyState.BuildEmptyState)
local BuildPillMenuPortal = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPortal)
local BuyMoreRobuxCard = require(BuildExperience.Components.Chat.BuyMoreRobuxCard)
local _useChatSheetFundingRecovery = require(script.Parent.useChatSheetFundingRecovery)
local BuildPillMenuPageHost = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPageHost)
local ChatActions = require(BuildExperience.Components.Chat.ChatActions)
local ChatCardEmphasisProvider = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardEmphasisProvider)
local ChatMessageList = require(BuildExperience.Components.Chat.ChatMessageList)
local ChatPermissionsContext = require(BuildExperience.Chat.ChatPermissionsContext)
local ChatScrollAnchorContext = require(BuildExperience.Chat.ChatScrollAnchorContext)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local chatConstants = require(BuildExperience.Chat.chatConstants)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local AnswerFormContainer = if FFlagBuildExperienceAnswerForm then require(BuildExperience.Components.AnswerForm.AnswerFormContainer) else nil
local _useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local FFlagBuildExperienceInGameShell = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceInGameShell

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local _useGamePermissions = require(BuildExperience.useGamePermissions)
local Sheet = Foundation.Sheet
local useScrollPerformanceTracker = require(BuildExperience.Telemetry.useScrollPerformanceTracker)

local DialogSize = Foundation.Enums.DialogSize
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local View = Foundation.View
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useTokens = Foundation.Hooks.useTokens

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function ChatSheetContent(tbl2)
    local var1 = React.useRef(nil)
    local var2 = nil
    local var3 = nil
    if FFlagBuildExperienceLibrary then
        var2, var3 = React.useState(nil)
    end
    useScrollPerformanceTracker("LuaApp_Build_Chat_Scroll", var1)

    local scrollingFrameRef = React.useCallback(function(current)
        var1.current = current
        if var3 ~= nil then
            var3(current)
        end
        tbl2.setScrollingFrame(current)
    end, { tbl2.setScrollingFrame, var3 })

    if FFlagBuildExperienceLibrary then
        React.useEffect(function()
            if tbl2.onFramesChanged ~= nil then
                tbl2.onFramesChanged(tbl2.sheet, var2)
            end
        end, { tbl2.onFramesChanged, tbl2.sheet, var2 })
    end

    return React.createElement(
        tbl2.sheetComponent.Content,
        { isReversed = true, scrollingFrameRef = scrollingFrameRef },
        tbl2.children
    )
end

local function ChatSheetView(tbl2)
    local var1 = FFlagBuildExperienceAnswerForm and tbl2.answerForm ~= nil
    local sheetComponent = tbl2.sheetComponent or Sheet
    local var3 = useLocalization({ composerPlaceholder = LocalizationStrings.CHAT_COMPOSER_PLACEHOLDER })

    local var4 = useTokens()
    local sheet, var6 = React.useState(nil)

    if FFlagBuildExperienceMonetizationNativeUI then
        local onClose = tbl2.onClose

        local eventHandlers = React.useMemo(function()
            return {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(function(arg1)
                        onClose()
                        arg1:cancel()
                    end)
                }
            }
        end, { onClose })

        local var8 = useFocusRoot({
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            eventMap = eventMap,
            eventHandlers = eventHandlers,
            isAutoFocusRoot = true,
            isFocusable = tbl2.isOpen
        })

        var6 = ReactUtils.useComposedRef(var6, var8)
    end
    local var7 = ChatMessageList({
        messages = tbl2.messages,
        clockBinding = tbl2.clockBinding,
        localToolActions = tbl2.localToolActions,
        emptyState = if var1 then nil else React.createElement(BuildEmptyState),
        isHistoryLoading = tbl2.isHistoryLoading,
        onPlaytest = tbl2.onPlaytest,
        isPlaytestLoading = tbl2.isPlaytestLoading
    })
    local creatorCreditRecovery = if FFlagBuildExperienceModelPicker then tbl2.creatorCreditRecovery else nil
    local element

    if creatorCreditRecovery == nil or not creatorCreditRecovery.card.showBuyMoreRobuxCard then
        element = nil
    else
        local card = creatorCreditRecovery.card
        element = React.createElement(BuyMoreRobuxCard, {
            LayoutOrder = 1,
            title = card.buyMoreRobuxCardTitle,
            description = card.buyMoreRobuxCardDescription,
            primaryActionText = card.buyMoreRobuxCardPrimaryActionText,
            onPrimaryAction = card.onBuyMoreRobuxCardPrimaryAction,
            secondaryActionText = card.buyMoreRobuxCardSecondaryActionText,
            onSecondaryAction = card.onBuyMoreRobuxCardSecondaryAction
        })
    end
    if var1 then
        var7.AnswerForm = React.createElement(AnswerFormContainer, {
            LayoutOrder = (#tbl2.messages + 2) * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE,
            state = tbl2.answerForm,
            actions = tbl2.localToolActions,
            onSubmitText = tbl2.onSubmitAnswerText,
            onStop = tbl2.onStop,
            errorText = tbl2.composerErrorText,
            isReadOnly = tbl2.isChatReadOnly
        })
    end
    local var8 = FFlagBuildExperienceChatAccordionScrollAnchor
        and {
            ScrollAnchor = React.createElement(ChatScrollAnchorContext.Provider, { value = tbl2.anchorScrollToInstance }, var7)
        }
        or var7

    local var9 = FFlagBuildCheckGamePermissions
        and {
            Permissions = React.createElement(ChatPermissionsContext.Provider, { value = tbl2.chatPermissions }, var8)
        }
        or var8

    local messageList = React.createElement(View, {
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, var4.Size.Size_800)
        },
        padding = FFlagBuildExperienceLibrary and tbl2.reservesHandleSpace == true and {
            top = UDim.new(0, var4.Size.Size_600)
        } or nil,
        tag = {
            ["size-full"] = #tbl2.messages == 0 and not var1,
            ["size-full-0 auto-y"] = #tbl2.messages > 0 or var1
        },
        testId = "ChatSheet.MessageList"
    }, var9)

    local element3 = React.createElement(ChatActions, {
        LayoutOrder = if element ~= nil then 2 else nil,
        modelPicker = if FFlagBuildExperienceModelPicker then tbl2.modelPicker else nil,
        composerText = tbl2.composerText,
        composerErrorText = tbl2.composerErrorText,
        onComposerChanged = tbl2.onComposerChanged,
        images = tbl2.composerImages,
        onImagesChanged = tbl2.onComposerImagesChanged,
        onRetryImage = tbl2.onRetryComposerImage,
        isSendBlocked = tbl2.isComposerSendBlocked,
        tracksExternalText = tbl2.tracksExternalComposerText,
        resourceAttachments = tbl2.composerResourceAttachments,
        onRemoveResourceAttachment = tbl2.onRemoveComposerResourceAttachment,
        onActivateResourceAttachment = tbl2.onActivateComposerResourceAttachment,
        placeholder = var3.composerPlaceholder,
        textBoxRef = tbl2.textBoxRef,
        isAssistantResponding = tbl2.isAssistantResponding,
        canStopAssistantResponse = tbl2.canStopAssistantResponse,
        canSendWhileResponding = tbl2.canSendWhileResponding,
        allowsTypingWhileResponding = tbl2.allowsComposerTypingWhileResponding,
        isReadOnly = tbl2.isChatReadOnly,
        onSend = tbl2.onSend,
        onStop = tbl2.onStop
    })

    local createElement = React.createElement
    local root = sheetComponent.Root
    local tbl3 = {
        ref = var6,
        isOpen = tbl2.isOpen,
        snapPoints = tbl2.snapPoints,
        defaultSnapPointIndex = tbl2.defaultSnapPointIndex,
        onSnapPointChanged = tbl2.onSnapPointChanged,
        size = DialogSize.Large,
        onClose = tbl2.onClose
    }
    local tbl4 = {
        Content = React.createElement(ChatSheetContent, {
            setScrollingFrame = tbl2.scrollingFrameRef,
            sheetComponent = sheetComponent,
            sheet = sheet,
            onFramesChanged = tbl2.onFramesChanged
        }, { MessageList = messageList }),
        Actions = 0,
        CreatorCreditPage = 0,
        TopBarPillMenu = 0
    }
    local var10

    if var1 then
        var10 = nil
    else
        local createElement2 = React.createElement
        local actions = sheetComponent.Actions
        local var11 = nil
        local tbl5 = { Footer = 0 }
        if element ~= nil then
            element3 = React.createElement(
                View,
                { tag = "col gap-medium size-full-0 auto-y" },
                { FundingRecovery = element, Composer = element3 }
            )
        end

        tbl5.Footer = element3
        var10 = createElement2(actions, var11, tbl5)
    end

    tbl4.Actions = var10

    tbl4.CreatorCreditPage = if creatorCreditRecovery == nil or creatorCreditRecovery.page == nil then nil else React.createElement(BuildPillMenuPageHost, creatorCreditRecovery.page)

    tbl4.TopBarPillMenu = if FFlagBuildExperienceInGameShell or tbl2.topBarPillMenuTarget == nil then nil else React.createElement(
        BuildPillMenuPortal,
        {
            sheet = sheet,
            target = tbl2.topBarPillMenuTarget,
            onOpenChat = tbl2.onOpenChat,
            testId = "build-pill-menu"
        }
    )
    local element4 = createElement(root, tbl3, tbl4)

    if FFlagBuildExperienceChatCardEmphasis then
        return React.createElement(ChatCardEmphasisProvider, nil, element4)
    end
    return element4
end

return ChatSheetView
