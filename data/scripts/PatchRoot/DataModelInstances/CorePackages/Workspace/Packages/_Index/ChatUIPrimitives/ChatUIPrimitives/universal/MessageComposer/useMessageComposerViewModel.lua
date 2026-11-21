-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Types = require(script.Parent.Parent.Types)
local MessageDraftModel = require(script.Parent.Parent.MessageDraftModel)
local _Types2 = require(ChatUIPrimitives.UniversalMessage.Types)
local _createExpressionCatalogResource = require(ChatUIPrimitives.createExpressionCatalogResource)
local messageDraftFromExpressionContent = require(script.Parent.Parent.messageDraftFromExpressionContent)

local _AutocompleteTypes = require(ChatUIPrimitives.universal.Autocomplete.AutocompleteTypes)
local _ChatInputBarView = require(ChatUIPrimitives.Components.ChatInputBar.ChatInputBarView)
local getTextLengthIfValidUtf8 = require(ChatUIPrimitives.Components.ChatInputBar.getTextLengthIfValidUtf8)
local ModerationTimeout = require(script.Parent.ModerationTimeout)
local FFlagExpChatMessageComposerDictation = require(ChatUIPrimitives.Flags.FFlagExpChatMessageComposerDictation)
local useChatInputBarDictation = require(ChatUIPrimitives.Components.ChatInputBar.Dictation.useChatInputBarDictation)
local Components = require(ChatUIPrimitivesParent.DictationCore.Components)
local _Constants = require(ChatUIPrimitivesParent.DictationCore.Constants)
local getDictationInputMode = require(ChatUIPrimitives.Components.ChatInputBar.Dictation.getDictationInputMode)
local DictationWaveformOverlay = require(ChatUIPrimitives.Components.ChatInputBar.Dictation.DictationWaveformOverlay)

local function useMessageComposerViewModel(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local selectionImageObject = Foundation.Hooks.useCursor(Foundation.Enums.CursorType.RoundedRect)
    local moderationTimeout = tbl1.moderationTimeout
    local transparency = tbl1.transparency
    local bool1 = not (moderationTimeout == nil) and moderationTimeout.status ~= "none"
    local bool2 = not (moderationTimeout == nil) and moderationTimeout.status == "active"
    local canLocalUserChat = tbl1.chatAvailability.canSend and not bool1
    local sendMessageDraft = tbl1.messageDelivery.sendMessageDraft
    local onFocusChanged = tbl1.onFocusChanged
    local expressionTray = tbl1.expressionTray
    local destinationSubtitle = tbl1.destinationSubtitle

    local canSend = (if expressionTray and expressionTray.canSend ~= nil then expressionTray.canSend else tbl1.chatAvailability.canSend)
        and not bool1

    local var5 = React.useRef(sendMessageDraft)
    var5.current = sendMessageDraft

    local onSend = React.useCallback(function(str1: string)
        var5.current(MessageDraftModel.fromPlainText(str1))
    end, {})

    local sendExpression = React.useCallback(function(arg1): boolean
        local var7 = messageDraftFromExpressionContent(arg1)
        if var7 == nil then
            return false
        end
        var5.current(var7)
        return true
    end, {})

    local autocomplete = tbl1.autocomplete
    local autocompleteOptions = React.useMemo(function(): {onAction: (any) -> boolean, sources: any}?
        return if autocomplete == nil then nil else {
            sources = autocomplete.sources,
            onAction = function(arg1): boolean
                if arg1.kind ~= "sendDraft" then
                    return false
                end
                var5.current(arg1.draft)
                return true
            end
        }
    end, { autocomplete })

    local var9 = React.useCallback(function()
        if onFocusChanged then
            onFocusChanged(true)
        end
    end, { onFocusChanged })

    local var10 = React.useCallback(function()
        if onFocusChanged then
            onFocusChanged(false)
        end
    end, { onFocusChanged })

    local catalogResource = if expressionTray then expressionTray.catalogResource else nil
    local onKeyboardActivated = if expressionTray then expressionTray.onKeyboardActivated else nil
    local cooldownDurationSeconds = if expressionTray then expressionTray.cooldownDurationSeconds else nil
    local cooldownScope = if expressionTray then expressionTray.cooldownScope else nil
    local onOpenChanged = if expressionTray then expressionTray.onOpenChanged else nil
    local bool3 = expressionTray ~= nil
    local var2 = React.useMemo(function(): {canLocalUserChat: any, canSend: any, catalogResource: any, cooldownDurationSeconds: any, cooldownScope: any, focusNavEnabled: boolean, onKeyboardActivated: any, onOpenChanged: any, sendExpression: any}?
        return if bool3 then {
            sendExpression = sendExpression,
            canLocalUserChat = canLocalUserChat,
            canSend = canSend,
            catalogResource = catalogResource,
            onKeyboardActivated = onKeyboardActivated,
            cooldownDurationSeconds = cooldownDurationSeconds,
            cooldownScope = cooldownScope,
            focusNavEnabled = true,
            onOpenChanged = onOpenChanged
        } else nil
    end, {
        bool3,
        sendExpression,
        canLocalUserChat,
        canSend,
        catalogResource,
        onKeyboardActivated,
        cooldownDurationSeconds,
        cooldownScope,
        onOpenChanged
    })

    local var12 = React.useMemo(function()
        if not bool1 then
            return nil
        end
        return React.createElement(ModerationTimeout, { state = moderationTimeout, transparency = transparency })
    end, { bool1, moderationTimeout, transparency })

    local textBoxRef = tbl1.textBoxRef
    local navigationTargetRef = tbl1.navigationTargetRef

    local var13 = React.useRef(nil)
    local var3 = textBoxRef or var13

    React.useLayoutEffect(function()
        if not canLocalUserChat or navigationTargetRef == nil then
            return
        end
        local current = var3.current
        if current == nil then
            return
        end
        navigationTargetRef.current = current
        return function()
            if navigationTargetRef.current == current then
                navigationTargetRef.current = nil
            end
        end
    end, { navigationTargetRef, var3, canLocalUserChat })

    if not var12 then
        if canLocalUserChat then
            var12 = nil
        else
            var12 = tbl1.chatAvailability.upsell
        end
    end

    local var15, var16, element, isAudioActive, var17

    if FFlagExpChatMessageComposerDictation then
        local isDisabled, var19 = React.useState(true)
        var15 = React.useCallback(function(str1: string)
            var19(str1 == "")
        end, {})

        React.useEffect(function()
            if not canLocalUserChat then
                var19(true)
            end
        end, { canLocalUserChat })

        local maximumCharacterLimit = tbl1.maximumCharacterLimit

        local var20 = React.useCallback(function(str1: string)
            if str1 == "" then
                return
            end
            local textLengthIfValidUtf8 = getTextLengthIfValidUtf8(str1)
            if maximumCharacterLimit ~= nil and textLengthIfValidUtf8 ~= nil and maximumCharacterLimit < textLengthIfValidUtf8 then
                return
            end
            onSend(str1)
            local current = var3.current
            if current then
                current.Text = ""
            end
            var19(true)
        end, { onSend, var3, maximumCharacterLimit })

        local var21, var22, var23 = useChatInputBarDictation(tbl1.dictation, var3, var20, isDisabled, canLocalUserChat)
        local var24 = var21 and canLocalUserChat

        local onActivated = React.useCallback(function()
            local current = var3.current
            var20(if current then current.Text else "")
        end, { var20, var3 })

        local dictation = var22.dictation
        local isMicVisible = var22.isMicVisible
        local isSubmitVisible = var22.isSubmitVisible

        local inputMode = getDictationInputMode(if tbl1.dictation then tbl1.dictation.handsFreeEnabled else nil)

        var16 = React.useMemo(function()
            if not var24 then
                return nil
            end
            local createElement = React.createElement
            local fragment = React.Fragment
            local var26 = nil
            local tbl2 = { SendButton = 0, DictationMic = 0 }
            local createElement2 = React.createElement
            local view = Foundation.View
            local tbl3 = { tag = "auto-xy", Visible = isSubmitVisible }
            local tbl4 = {
                Content = React.createElement(Foundation.IconButton, {
                    testId = "--social-exp-chat-iconbutton-dictation-send",
                    icon = Foundation.Enums.IconName.ArrowMediumUp,
                    variant = if isDisabled then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
                    size = Foundation.Enums.InputSize.Small,
                    isCircular = true,
                    isDisabled = isDisabled,
                    onActivated = onActivated
                })
            }
            tbl2.SendButton = createElement2(view, tbl3, tbl4)

            tbl2.DictationMic = React.createElement(Foundation.View, {
                tag = "auto-xy",
                Visible = isMicVisible
            }, {
                Content = React.createElement(Components.MicButton, {
                    getDictationState = dictation.getDictationState,
                    getIsMicInUseElsewhere = dictation.getIsMicInUseElsewhere,
                    onStart = dictation.startDictation,
                    onStop = dictation.stopDictation,
                    countdownProgress = dictation.bindings.countdownProgress,
                    inputMode = inputMode
                })
            })
            return createElement(fragment, var26, tbl2)
        end, {
            var24,
            isMicVisible,
            isSubmitVisible,
            dictation.getDictationState,
            dictation.getIsMicInUseElsewhere,
            dictation.startDictation,
            dictation.stopDictation,
            dictation.bindings.countdownProgress,
            inputMode,
            isDisabled,
            onActivated
        })

        if var24 then
            element = React.createElement(DictationWaveformOverlay, {
                isAudioActive = var22.isAudioActive,
                isAudioActiveBinding = dictation.bindings.isAudioActive,
                audioDeviceInput = dictation.audioDeviceInput,
                onWaveformSample = var22.onWaveformSample,
                transcribedSamplesBinding = var22.transcribedSamplesBinding,
                lineHeight = var1.Typography.BodyMedium.FontSize,
                transparencyValue = transparency or 0
            })
        else
            element = nil
        end

        if var24 then
            isAudioActive = var22.isAudioActive
        else
            isAudioActive = nil
        end

        if var24 then
            var17 = not var23
        else
            var17 = nil
        end
    else
        var17 = nil
        var15 = nil
        var16 = nil
        element = nil
        isAudioActive = nil
    end

    local tbl2 = {
        composerLayout = true,
        themedColors = true,
        onSend = onSend,
        canLocalUserChat = canLocalUserChat,
        disabledOverlay = var12,
        pillStrokeStyle = if bool2 then var1.Color.System.Alert else nil,
        expressionTray = var2,
        sideChipText = if destinationSubtitle then destinationSubtitle.text else nil,
        showSideChip = destinationSubtitle ~= nil,
        onSideChipActivated = if destinationSubtitle then destinationSubtitle.onActivated else nil,
        placeholderText = tbl1.placeholderText,
        maximumCharacterLimit = tbl1.maximumCharacterLimit,
        autocompleteOptions = autocompleteOptions,
        textBoxRef = var3,
        selectionImageObject = selectionImageObject,
        fontFace = tbl1.fontFace,
        transparencyValue = transparency,
        onFocusGained = 0,
        onFocusLost = 0,
        enableFocusedWrite = 0,
        onChange = 0,
        primary = 0,
        centerOverlay = 0,
        centerOverlayTextHidden = 0
    }

    if not onFocusChanged then
        var9 = nil
    end

    tbl2.onFocusGained = var9
    if not onFocusChanged then
        var10 = nil
    end

    tbl2.onFocusLost = var10
    tbl2.enableFocusedWrite = var17
    tbl2.onChange = var15
    tbl2.primary = var16
    tbl2.centerOverlay = element
    tbl2.centerOverlayTextHidden = isAudioActive
    return tbl2
end

return useMessageComposerViewModel
