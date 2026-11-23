-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local ChatMessage = require(AppChat.Components.ChatConversation.ChatMessage)
local CustomMessageEntryContainer = require(AppChat.Components.ChatConversation.CustomMessageEntryContainer)
local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)
local MessageListContext = require(script.Parent.MessageListContext)
local MessageModel = require(AppChat.Models.MessageModel)
local SystemMessage = require(AppChat.Components.ChatConversation.SystemMessage)
local SystemMessageContainer = require(AppChat.Components.ChatConversation.SystemMessageContainer)

local GetFFlagEnableSocialCards = require(AppChatParent.SharedFlags).GetFFlagEnableSocialCards

local function isValidMessageAndSenderType(messageType: string?, senderType: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if senderType == MessageModel.SenderTypes.System then
        return messageType == EnumMessageTypes.System
    end

    if senderType == MessageModel.SenderTypes.User then
        return messageType == EnumMessageTypes.PlainText or messageType == EnumMessageTypes.Link
    end

    return messageType == EnumMessageTypes.Custom
end

local function MessageRow(tbl1)
    local var1 = React.useContext(MessageListContext)
    assert(var1 ~= nil, "MessageRow must be rendered inside a MessageListContext provider")
    local item = tbl1.item

    if not isValidMessageAndSenderType(item.messageType, item.senderType) then
        return React.createElement(SystemMessage, { Text = var1.invalidMessageTypeText })
    end

    local element = if var1.isDebugEnabled then React.createElement("StringValue", { Value = tostring(item.messageId) }) else nil

    if item.messageType == EnumMessageTypes.Custom then
        return React.createElement(
            CustomMessageEntryContainer,
            {
                openViewProfile = var1.openViewProfile,
                customEntryType = item.customEntryType,
                conversationId = var1.conversationId
            }
        )
    end
    if item.messageType == EnumMessageTypes.System then
        return React.createElement(SystemMessageContainer, {
            cards = if GetFFlagEnableSocialCards() then item.cards else nil,
            text = item.content,
            parentWidth = var1.width,
            sent = item.sent,
            showDateTime = item.showDateTime,
            messageId = item.messageId,
            senderTargetId = if GetFFlagEnableSocialCards() then item.senderTargetId else nil,
            conversationId = var1.conversationId,
            debugElement = element
        })
    end

    local additionalProps = Cryo.Dictionary.join(item.additionalProps or {}, {
        onDetailsOpened = if item.additionalProps == nil then nil else var1.onDetailsOpened,
        openGameDetailsPage = var1.openGameDetailsPage,
        openMomentsDeepLink = var1.openMomentsDeepLink,
        shareLink = item.shareLink
    })

    return React.createElement(ChatMessage, {
        additionalProps = additionalProps,
        content = item.content,
        debugElement = element,
        failed = item.failed,
        filteredForReceivers = item.filteredForReceivers,
        isIncoming = item.isIncoming,
        isNewSender = item.isNewSender,
        isSending = item.isSending,
        isUnfiltered = item.moderationType == MessageModel.ModerationTypes.TrustedComms,
        isLastMessageInMessageGroup = item.isLastMessageInMessageGroup,
        isLastIncomingChatMessage = item.messageId == var1.lastIncomingChatMessageId,
        messageDefaultNoticeText = var1.messageDefaultNoticeText,
        conversationId = var1.conversationId,
        messageId = item.messageId,
        messageModeratedNoticeText = var1.messageModeratedNoticeText,
        messageHiddenNoticeText = var1.messageHiddenNoticeText,
        messageType = item.messageType,
        moderated = item.moderated,
        openViewProfile = var1.openViewProfile,
        parentWidth = var1.width,
        readingMessagesIsEnabled = true,
        senderUserId = item.senderTargetId,
        sent = item.sent,
        showDateTime = item.showDateTime,
        showDisplayName = item.showDisplayName,
        shouldShowName = item.sender.shouldShowName,
        thumbnail = item.sender.thumbnail,
        wideMode = var1.wideMode,
        unknownUserText = var1.unknownUserText,
        viewProfileOnAvatarPressed = var1.viewProfileOnAvatarPressed,
        closeKeyboard = var1.closeKeyboard,
        inputBoxRef = var1.inputBoxRef,
        repliesTo = item.repliesTo,
        visibility = item.visibility
    })
end

return MessageRow
