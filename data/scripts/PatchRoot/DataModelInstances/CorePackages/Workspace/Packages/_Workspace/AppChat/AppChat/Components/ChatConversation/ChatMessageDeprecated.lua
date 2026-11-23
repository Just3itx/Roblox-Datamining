-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local memoize = require(AppChatParent.AppCommonLib).memoize
local GetTextSize = require(AppChatParent.Style).GetTextSize
local PlainText = require(script.Parent.PlainText)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle

local AssetCard = require(script.Parent.AssetCard)
local HiddenMessage = require(script.Parent.HiddenMessage)

local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)

local ChatMessageContainer = require(script.Parent.ChatMessageContainer)
local Logger = require(script.Parent.Logger)

local pruneConsecutiveNewLines = require(AppChat.SocialLibraries).Utils.pruneConsecutiveNewLines
local getModeratedMaskText = require(AppChat.Utils.getModeratedMaskText)
local FFlagAppChatEnableAutotranslation = require(AppChat.Flags.FFlagAppChatEnableAutotranslation)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local MessageModel = require(AppChat.Models.MessageModel)
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

local var1 = Roact.PureComponent:extend("ChatMessage")

var1.defaultProps = {
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

function var1.init(arg1)
    function arg1.getModeratedText(arg2)
        return getModeratedMaskText(arg1.props.messageId or arg2)
    end

    function arg1.messageMaxWidth(bool1: boolean, num1: number)
        local var2 = (TEXT_BUBBLE_X_PADDING + BUBBLE_PADDING) * 2

        if bool1 then
            var2 += TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING
        end

        return num1 - var2
    end

    if not FFlagAppChatEnableAutotranslation then
        arg1.getBubbleMaxWidth = memoize(function(x: number?, arg2, arg3, arg4)
            return GetTextSize(arg2, arg3, arg4, Vector2.new(x, 10000)).X + BUBBLE_PADDING * 2
        end)

        return
    end

    arg1.getBubbleMaxWidth = memoize(function(x: number?, arg2, arg3, arg4, arg5)
        if not arg5 then
            return GetTextSize(arg2, arg3, arg4, Vector2.new(x, 10000)).X + BUBBLE_PADDING * 2
        end

        local textSize = GetTextSize(arg2, arg1.props.autotranslationOriginalTextFontSize, arg4, Vector2.new(x, 10000))

        local textSize2 = GetTextSize(arg5, arg3, arg4, Vector2.new(x, 10000))
        return math.max(textSize.X, textSize2.X) + BUBBLE_PADDING * 2
    end)
end

function var1.render(arg1)
    local messageComponent = getMessageComponent(arg1.props)
    local var2 = arg1.messageMaxWidth(arg1.props.wideMode, arg1.props.parentWidth)

    if not messageComponent then
        Logger:warning("ChatMessage doesn't support messageType: {}", arg1.props.messageType)
        return nil
    end

    local content = arg1.props.content
    local var3 = pruneConsecutiveNewLines(content)

    if arg1.props.moderated then
        var3 = arg1.getModeratedText(var3) or var3
    end
    local content2 = arg1.props.repliesTo and arg1.props.repliesTo.messageType and arg1.props.repliesTo.content

    return withStyle(function(arg2)
        local body = arg2.Font.Body
        local textSize = arg2.Font.BaseSize * body.RelativeSize

        local bodySmall = arg2.Font.BodySmall
        local var4 = arg2.Font.BaseSize * bodySmall.RelativeSize

        return Roact.createElement(
            ChatMessageContainer,
            Cryo.Dictionary.join(arg1.props, {
                messageMaxWidth = var2,
                messageTypePaddingOffset = messageComponent.paddingOffset,
                messageId = arg1.props.messageId,
                isPending = arg1.props.isSending or arg1.props.moderated or arg1.props.failed,
                visibility = arg1.props.visibility,
                renderMessage = function(arg3, arg4)
                    local createElement = React.createElement
                    local str1 = "ImageButton"
                    local var6 = Cryo.Dictionary.join({
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        Selectable = not FFlagAppChatConsoleFocusFixes and nil
                    }, arg3 or {})
                    local tbl3 = {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = if arg1.props.isIncoming then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Right,
                            Padding = UDim.new(0, 10)
                        })
                    }
                    local element

                    if content2 then
                        element = Roact.createElement(getMessageComponent(arg1.props.repliesTo).component, {
                            additionalProps = arg1.props.additionalProps,
                            font = arg2.Tokens.Typography.BodyLarge.Font,
                            hasTail = false,
                            innerPadding = BUBBLE_PADDING,
                            isIncoming = arg1.props.isIncoming,
                            isPending = false,
                            isUnfiltered = arg1.props.isUnfiltered,
                            isRepliedTo = true,
                            isLastMessageInMessageGroup = arg1.props.isLastMessageInMessageGroup,
                            maxWidth = var2,
                            messageDefaultNoticeText = arg1.props.messageDefaultNoticeText,
                            messageModeratedNoticeText = arg1.props.messageModeratedNoticeText,
                            parentWidth = arg1.props.parentWidth,
                            text = arg1.props.repliesTo.content,
                            textSize = var4,
                            wideMode = arg1.props.wideMode,
                            [Roact.Change.AbsoluteSize] = arg1.messageSizeChanged,
                            LayoutOrder = 1
                        })
                    else
                        element = nil
                    end

                    tbl3.repliesTo = element

                    local createElement2 = React.createElement
                    local str2 = "Frame"
                    local tbl4 = {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        [React.Change.AbsoluteSize] = arg1.messageSizeChanged,
                        LayoutOrder = 2,
                        ref = if arg4 then arg4.ref else nil
                    }
                    local tbl5 = {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            Padding = UDim.new(0, arg2.Tokens.Size.Size_100)
                        }),
                        Icons = if arg4 then arg4.Icons else nil,
                        [messageComponent.name] = Roact.createElement(messageComponent.component, {
                            additionalProps = arg1.props.additionalProps,
                            font = arg2.Tokens.Typography.BodyLarge.Font,
                            hasTail = arg1.props.isNewSender,
                            innerPadding = BUBBLE_PADDING,
                            isIncoming = arg1.props.isIncoming,
                            isPending = arg1.props.isSending or arg1.props.moderated or arg1.props.failed,
                            isUnfiltered = arg1.props.isUnfiltered,
                            isLastMessageInMessageGroup = arg1.props.isLastMessageInMessageGroup,
                            isLastIncomingChatMessage = arg1.props.isLastIncomingChatMessage,
                            isPressed = if arg4 then arg4.isPressed else nil,
                            bubbleRef = if arg4 then arg4.bubbleRef else nil,
                            maxWidth = if FFlagAppChatEnableAutotranslation then arg1.getBubbleMaxWidth(var2, var3, textSize, arg2.Tokens.Typography.BodyLarge.Font, arg1.props.translatedText) else arg1.getBubbleMaxWidth(var2, var3, textSize, arg2.Tokens.Typography.BodyLarge.Font),
                            messageDefaultNoticeText = arg1.props.messageDefaultNoticeText,
                            messageModeratedNoticeText = arg1.props.messageModeratedNoticeText,
                            parentWidth = arg1.props.parentWidth,
                            text = var3,
                            textSize = textSize,
                            wideMode = arg1.props.wideMode,
                            [Roact.Change.AbsoluteSize] = arg1.messageSizeChanged,
                            LayoutOrder = if arg1.props.isIncoming then 1 else 2,
                            translatedText = if FFlagAppChatEnableAutotranslation then arg1.props.translatedText else nil
                        })
                    }
                    tbl3.mainMessage = createElement2(str2, tbl4, tbl5)
                    return createElement(str1, var6, tbl3)
                end
            })
        )
    end)
end

return if FFlagAppChatEnableAutotranslation then function(arg1)
    local var2 = useTokens()
    return React.createElement(
        var1,
        Cryo.Dictionary.union(arg1, { autotranslationOriginalTextFontSize = var2.Typography.BodySmall.FontSize })
    )
end else var1
