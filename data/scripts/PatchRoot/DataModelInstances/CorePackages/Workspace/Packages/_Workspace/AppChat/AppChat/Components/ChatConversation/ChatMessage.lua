-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
if not require(AppChat.Flags.FFlagAppChatRefactorChatMessage) then
    return require(script.Parent.ChatMessageDeprecated)
end

local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local _MomentsTypes = require(AppChatParent.MomentsTypes)
local React = require(AppChatParent.React)
local GetTextSize = require(AppChatParent.Style).GetTextSize
local PlainText = require(script.Parent.PlainText)

local AssetCard = require(script.Parent.AssetCard)
local HiddenMessage = require(script.Parent.HiddenMessage)

local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)

local ChatMessageContainer = require(script.Parent.ChatMessageContainer)
local Logger = require(script.Parent.Logger)

local pruneConsecutiveNewLines = require(AppChat.SocialLibraries).Utils.pruneConsecutiveNewLines
local getModeratedMaskText = require(AppChat.Utils.getModeratedMaskText)
local FFlagAppChatEnableAutotranslation = require(AppChat.Flags.FFlagAppChatEnableAutotranslation)
local MessageModel = require(AppChat.Models.MessageModel)

local Foundation = require(AppChatParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image

local ChatMessageContainerConstants = require(script.Parent.ChatMessageContainerConstants)

local BUBBLE_PADDING = ChatMessageContainerConstants.BUBBLE_PADDING
local TEXT_BUBBLE_X_PADDING = ChatMessageContainerConstants.TEXT_BUBBLE_X_PADDING
local TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING = ChatMessageContainerConstants.TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING
local tbl1 = {
    [EnumMessageTypes.PlainText] = { component = PlainText, name = "PlainText", paddingOffset = 0 },
    [EnumMessageTypes.Link] = { component = AssetCard, name = "AssetCard", paddingOffset = 0 }
}

local tbl2 = { component = HiddenMessage, name = "Hidden", paddingOffset = 0 }

local function getMessageComponent(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 and arg1.visibility == MessageModel.VisibilityTypes.Hidden then tbl2 else tbl1[arg1.messageType]
end

local useTokens = require(AppChatParent.Foundation).Hooks.useTokens

local tbl3 = {
    additionalProps = {
        shareLink = nil,
        placeId = nil,
        universeId = nil,
        senderUserId = nil,
        onDetailsOpened = function() end,
        openGameDetailsPage = function() end
    },
    conversationId = nil,
    BackgroundColor3 = nil,
    content = "",
    debugElement = nil,
    displayName = nil,
    failed = false,
    filteredForReceivers = false,
    isIncoming = false,
    isNewSender = false,
    isSending = false,
    isUnfiltered = false,
    isLastMessageInMessageGroup = false,
    isLastIncomingChatMessage = false,
    visibility = nil,
    messageType = nil,
    moderated = false,
    parentWidth = 0,
    senderUserId = nil,
    sent = nil,
    showDateTime = false,
    thumbnail = nil,
    Transparency = nil,
    wideMode = false,
    viewProfileOnAvatarPressed = true,
    closeKeyboard = function() end,
    inputBoxRef = nil,
    repliesTo = nil,
    translatedText = nil,
    autotranslationOriginalTextFontSize = 16,
    messageDefaultNoticeText = "PLACEHOLDER Not everyone in this chat can see your message.",
    messageModeratedNoticeText = "PLACEHOLDER Your message was moderated and not sent.",
    messageHiddenNoticeText = "PLACEHOLDER This message is not available",
    unknownUserText = "PLACEHOLDER unknown user"
}

return function(tbl4)
    local var1 = Cryo.Dictionary.union(tbl3, tbl4)

    local function getModeratedText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return getModeratedMaskText(var1.messageId or arg1)
    end

    local function messageMaxWidth(bool1: boolean, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = (TEXT_BUBBLE_X_PADDING + BUBBLE_PADDING) * 2

        if bool1 then
            var2 += TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING
        end

        return num1 - var2
    end

    local var2 = useTokens()

    local var3 = if FFlagAppChatEnableAutotranslation then React.useCallback(function(x: number, str1: string, num1: number, arg1, str2: string?)
        if not str2 then
            return GetTextSize(str1, num1, arg1, Vector2.new(x, 10000)).X + BUBBLE_PADDING * 2
        end

        local textSize = GetTextSize(str1, var2.Typography.BodySmall.FontSize, arg1, Vector2.new(x, 10000))

        local textSize2 = GetTextSize(str2, num1, arg1, Vector2.new(x, 10000))
        return math.max(textSize.X, textSize2.X) + BUBBLE_PADDING * 2
    end) else React.useCallback(function(x: number, str1: string, num1: number, arg1, _: string?)
        return GetTextSize(str1, num1, arg1, Vector2.new(x, 10000)).X + BUBBLE_PADDING * 2
    end)

    local messageComponent = getMessageComponent(var1)

    local var4 = React.useMemo(function()
        return messageMaxWidth(var1.wideMode, var1.parentWidth)
    end, { messageMaxWidth, var1.wideMode, var1.parentWidth })

    local content = var1.content
    local var5 = pruneConsecutiveNewLines(content)

    if var1.moderated then
        var5 = getModeratedText(var5) or var5
    end
    local content2 = var1.repliesTo and var1.repliesTo.messageType and var1.repliesTo.content

    local bodyLarge = var2.Typography.BodyLarge
    local fontSize = bodyLarge.FontSize

    local fontSize2 = var2.Typography.BodySmall.FontSize

    if not messageComponent then
        Logger:warning("ChatMessage doesn't support messageType: {}", var1.messageType)
        return React.createElement(View, {})
    end

    return React.createElement(
        ChatMessageContainer,
        Cryo.Dictionary.union(var1, {
            messageMaxWidth = var4,
            messageTypePaddingOffset = messageComponent.paddingOffset,
            messageId = var1.messageId,
            isPending = var1.isSending or var1.moderated or var1.failed,
            visibility = var1.visibility,
            renderMessage = function(arg1, arg2)
                local createElement = React.createElement
                local var6 = Image
                local var7 = Cryo.Dictionary.union({
                    tag = {
                        ["auto-xy gui-object-defaults col align-y-center"] = true,
                        ["align-x-left"] = var1.isIncoming,
                        ["align-x-right"] = not var1.isIncoming
                    },
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, 10)
                    }
                }, arg1 or {})
                local tbl5 = { repliesTo = 0, mainMessage = 0 }
                local element

                if content2 then
                    element = React.createElement(getMessageComponent(var1.repliesTo).component, {
                        additionalProps = var1.additionalProps,
                        font = bodyLarge.Font,
                        hasTail = false,
                        innerPadding = BUBBLE_PADDING,
                        isIncoming = var1.isIncoming,
                        isPending = false,
                        isUnfiltered = var1.isUnfiltered,
                        isRepliedTo = true,
                        isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
                        maxWidth = var4,
                        messageDefaultNoticeText = var1.messageDefaultNoticeText,
                        messageModeratedNoticeText = var1.messageModeratedNoticeText,
                        parentWidth = var1.parentWidth,
                        text = var1.repliesTo.content,
                        textSize = fontSize2,
                        wideMode = var1.wideMode,
                        LayoutOrder = 1
                    })
                else
                    element = nil
                end

                tbl5.repliesTo = element

                local createElement2 = React.createElement
                local var8 = View
                local tbl6 = {
                    tag = "row auto-xy align-y-center gap-xxsmall",
                    LayoutOrder = 2,
                    ref = if arg2 then arg2.ref else nil
                }
                local tbl7 = {
                    Icons = if arg2 then arg2.Icons else nil,
                    [messageComponent.name] = React.createElement(messageComponent.component, {
                        additionalProps = var1.additionalProps,
                        font = bodyLarge.Font,
                        hasTail = var1.isNewSender == true,
                        innerPadding = BUBBLE_PADDING,
                        isIncoming = var1.isIncoming,
                        isPending = var1.isSending or var1.moderated or var1.failed,
                        isUnfiltered = var1.isUnfiltered,
                        isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
                        isLastIncomingChatMessage = var1.isLastIncomingChatMessage,
                        isPressed = if arg2 then arg2.isPressed else nil,
                        bubbleRef = if arg2 then arg2.bubbleRef else nil,
                        maxWidth = if FFlagAppChatEnableAutotranslation then var3(var4, var5, fontSize, bodyLarge.Font, var1.translatedText) else var3(var4, var5, fontSize, bodyLarge.Font),
                        messageDefaultNoticeText = var1.messageDefaultNoticeText,
                        messageModeratedNoticeText = var1.messageModeratedNoticeText,
                        parentWidth = var1.parentWidth,
                        text = var5,
                        textSize = fontSize,
                        wideMode = var1.wideMode,
                        LayoutOrder = if var1.isIncoming then 1 else 2,
                        translatedText = if FFlagAppChatEnableAutotranslation then var1.translatedText else nil
                    })
                }
                tbl5.mainMessage = createElement2(var8, tbl6, tbl7)
                return createElement(var6, var7, tbl5)
            end
        })
    )
end
