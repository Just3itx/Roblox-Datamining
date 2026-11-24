-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Foundation = require(FriendsChatParent.Foundation)
local getModeratedMaskText = require(FriendsChatParent.AppChat.getModeratedMaskText)
local getReplyLabelDescriptor = require(FriendsChatParent.AppChat.getReplyLabelDescriptor)

local NameInfo = require(script.Parent.NameInfo)
local _classifyMessage = require(script.Parent.classifyMessage)
local _useLocalize = require(script.Parent.Parent.Parent.Utils.useLocalize)

local IconName = Foundation.Enums.IconName

return {
    MODERATED_ICON = IconName.TriangleExclamation,
    HIDDEN_ICON = IconName.LockClosed,
    REPLY_ICON = IconName.ArrowCurlToLeft,
    systemIcon = function(arg1)
        return if arg1 == "party" then IconName.TwoPeopleSpeechBubble else IconName.CircleI
    end,
    moderatedNoticeText = function(arg1)
        if arg1 then
            return (arg1("Feature.Chat.Message.MessageContentModerated"))
        end

        return ""
    end,
    hiddenNoticeText = function(displayName: string?, arg1)
        if arg1 then
            return (arg1({ "Feature.Chat.Message.CannotBeDisplayedThirdPerson", displayName = displayName }))
        end

        return ""
    end,
    maskedBody = function(tbl1)
        return getModeratedMaskText(tbl1.messageId or tbl1.body)
    end,
    replyLabelText = function(tbl1)
        local localUserId = tbl1.localUserId
        local namesByUserId = tbl1.namesByUserId
        local senderIsLocalUser = not (localUserId == nil) and tbl1.senderUserId == localUserId
        local senderRepliedToLocalUser = not (localUserId == nil) and tbl1.repliedToUserId == localUserId

        if NameInfo.isNameLoading(namesByUserId[tbl1.senderUserId]) and not senderIsLocalUser
            or NameInfo.isNameLoading(namesByUserId[tbl1.repliedToUserId]) and not senderRepliedToLocalUser
        then
            return nil
        end
        local var1 = namesByUserId[tbl1.senderUserId]
        local var2 = namesByUserId[tbl1.repliedToUserId]
        local replyLabelDescriptor = getReplyLabelDescriptor({
            senderIsLocalUser = senderIsLocalUser,
            senderRepliedToSelf = tbl1.senderUserId == tbl1.repliedToUserId,
            senderRepliedToLocalUser = senderRepliedToLocalUser,
            isGroup = tbl1.isGroup,
            senderName = if var1 and var1.name then var1.name else "",
            repliedToName = if var2 and var2.name then var2.name else ""
        })
        if tbl1.localize then
            return (tbl1.localize(replyLabelDescriptor))
        end

        return ""
    end
}
