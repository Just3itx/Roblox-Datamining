-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local getThumbnailsForUserIds = require(AppChat.Users.getThumbnailsForUserIds)
local Conversation = require(AppChat.Models.Conversation)
local MessageModel = require(AppChat.Models.MessageModel)

local Cryo = require(AppChatParent.Cryo)

local var1 = require(AppChat.Logger):new(script.Name)

return function(arg1, arg2, messageId, arg3, arg4, isSending, arg5)
    local isIncoming = arg2.senderTargetId ~= tostring(arg1.LocalUserId)
    local bool2 = arg2.repliesTo ~= nil

    local function timeDiffExceeds(arg6, arg7, num1: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        if not (arg6 and arg7 and arg6.sent and arg7.sent) then
            return false
        end
        return num1 < math.abs(arg6.sent:GetUnixTimestamp() - arg7.sent:GetUnixTimestamp())
    end
    local function isSystemMessage(arg6) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg6 and arg6.messageType == "System"
    end

    local function isModerated(arg6) -- Luacid: Inlined by compiler; 6 call sites recovered
        return arg6 and arg6.moderated == true
    end

    local function isHiddenMessage(arg6) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg6 and arg6.visibility == MessageModel.VisibilityTypes.Hidden
    end

    local function isReplyMessage(arg6) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg6 and arg6.repliesTo ~= nil
    end

    local function hasSenderChange(arg6, arg7) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg6 and arg7 and arg6.senderTargetId ~= arg7.senderTargetId
    end

    local function hasModeratedBreak(arg6, arg7) -- Luacid: Inlined by compiler; 2 call sites recovered
        return isModerated(arg6) or isModerated(arg7)
    end

    local showDateTime = if not arg4 and arg3.fetchedOldestMessage then true else timeDiffExceeds(arg2, arg4, 300)
    local isNewSender = showDateTime
        or not arg4
        or hasSenderChange(arg4, arg2)
        or isSystemMessage(arg4)
        or isReplyMessage(arg2)
        or isHiddenMessage(arg4)
        or hasModeratedBreak(arg4, arg2)
    local isLastMessageInMessageGroup = not arg5
        or isSystemMessage(arg5)
        or hasSenderChange(arg5, arg2)
        or timeDiffExceeds(arg5, arg2, 300)
        or isReplyMessage(arg5)
        or isHiddenMessage(arg5)
        or hasModeratedBreak(arg2, arg5)

    local users = arg1.Users
    local senderTargetId = (isIncoming and isNewSender or bool2) and arg2.senderTargetId
    local tbl1 = {}

    if senderTargetId or isLastMessageInMessageGroup then
        local user = users[arg2.senderTargetId]

        tbl1 = {
            id = if senderTargetId or isIncoming and isLastMessageInMessageGroup then arg2.senderTargetId else nil,
            thumbnail = if isIncoming and isLastMessageInMessageGroup and isIncoming and user then getThumbnailsForUserIds({ arg2.senderTargetId })[1] else nil,
            shouldShowName = if senderTargetId then arg3.conversationType == Conversation.Type.MULTI_USER_CONVERSATION or bool2 else nil
        }
    elseif arg2.senderType == MessageModel.SenderTypes.User and not arg2.senderTargetId then
        var1:warning(`User message with no senderTargetId: {arg2.id}`)
    end

    local additionalProps = {
        placeId = arg2.placeId,
        universeId = arg2.gameLink and arg2.gameLink.universeId,
        senderUserId = if isIncoming then arg2.senderTargetId or nil else nil,
        isEarlyTesting = arg2.isEarlyTesting
    }

    return Cryo.Dictionary.join(arg2, {
        conversationId = arg3.id,
        messageId = messageId,
        position = arg4 and arg4.position + 1 or 1,
        isIncoming = isIncoming,
        isLastMessageInMessageGroup = isLastMessageInMessageGroup,
        isNewSender = isNewSender,
        sender = tbl1,
        isSending = isSending or false,
        showDateTime = showDateTime,
        additionalProps = additionalProps
    })
end
