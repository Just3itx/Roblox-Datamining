-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DateTime = require(AppChatParent.Time).DateTime
local GenerateStringId = require(AppChatParent.AppCommonLib).GenerateStringId
local SharedFlags = require(AppChatParent.SharedFlags)
local Logger = require(script.Parent.Logger)

local GetFFlagEnableSocialCards = SharedFlags.GetFFlagEnableSocialCards

local FFlagAppChatEnableAutotranslation = require(AppChat.Flags.FFlagAppChatEnableAutotranslation)

local module = {
    SenderTypes = { User = "user", System = "system", UnknownType = "unknown_type" },
    MessageTypes = { PlainText = "PlainText", Link = "Link", System = "System" },
    LinkTypes = { Game = "Game" },
    ModerationTypes = {
        TrustedComms = "trusted_comms",
        Moderated = "moderated",
        Invalid = "invalid",
        UnknownType = "unknown_type"
    },
    VisibilityTypes = { Visible = "visible", Hidden = "hidden", Invalid = "invalid" }
}

function module.new(arg1)
    module.__index = module

    local var1 = arg1 or {}

    setmetatable(var1, module)

    return var1
end

function module.newSendingId()
    return "sending-message-" .. GenerateStringId()
end

function module.newSending(arg1)
    assert(arg1, "props argument is missing")
    assert(arg1.id, "props.id argument is missing")
    assert(arg1.messageType, "props.messageType argument is missing")
    assert(arg1.order, "props.order argument is missing")
    assert(arg1.conversationId, "props.conversationId argument is missing")
    assert(arg1.sent, "props.sent argument is missing")

    local module2 = module.new(arg1)

    module2.senderTargetId = tostring(Players.LocalPlayer.UserId)
    module2.senderType = module.SenderTypes.User
    module2.moderated = false
    module2.failed = false

    module2.stableKey = module2.id

    return module2
end

function module.fromChannelsApi(arg1, arg2, previousMessageId, _)
    if not module.DoRequiredFieldsPresentFromChannelsApi(arg1) then
        return nil
    end

    local module2 = module.new()

    module2.id = arg1.id
    module2.read = true
    module2.sent = DateTime.fromIsoDate(arg1.created_at)
    module2.conversationId = tostring(arg2)
    module2.previousMessageId = previousMessageId
    module2.filteredForReceivers = false
    module2.content = arg1.content
    module2.previewContent = arg1.preview_content
    if arg1.type == module.SenderTypes.User then
        module2:serializeForUserMessage(arg1)
    elseif arg1.type == module.SenderTypes.System then
        module2:serializeForSystemMessage(arg1)
    end
    module2.cards = if GetFFlagEnableSocialCards() then arg1.cards else nil
    if GetFFlagEnableSocialCards() then
        module2.senderTargetId = tostring(arg1.sender_user_id)
    end

    module2.stableKey = module2.id

    module2.isBadgeable = arg1.is_badgeable
    module2.isPreviewable = arg1.is_previewable

    if FFlagAppChatEnableAutotranslation then
        module2.contentToDisplay = arg1.content_to_display
    end

    return module2
end

function module.serializeForUserMessage(arg1, arg2)
    arg1.senderTargetId = tostring(arg2.sender_user_id)
    arg1.senderType = module.SenderTypes.User
    arg1.moderationType = arg2.moderation_type
    arg1.repliesTo = module.fromChannelsApi(arg2.replies_to, nil, nil, true)

    if arg2.visibility
        and (arg2.visibility == module.VisibilityTypes.Visible or arg2.visibility == module.VisibilityTypes.Hidden)
    then
        arg1.visibility = arg2.visibility
    else
        arg1.visibility = module.VisibilityTypes.Invalid
        Logger:debug("Message visibility type is invalid for message id: " .. arg1.id)
    end
    arg1.messageType = module.MessageTypes.PlainText
end

function module.serializeForSystemMessage(arg1, _)
    arg1.senderType = module.SenderTypes.System
    arg1.messageType = module.MessageTypes.System
end

function module.DoRequiredFieldsPresentFromChannelsApi(arg1)
    return if arg1 then if arg1.type == module.SenderTypes.User then arg1.id and arg1.sender_user_id and arg1.created_at else arg1.type == module.SenderTypes.System and arg1.id and arg1.created_at else false
end

function module.parseContentFromChannelsApi(arg1, arg2)
    arg1.messageType = module.MessageTypes.PlainText
    arg1.content = arg2.content
end

function module.fromSentChannelsApi(arg1, arg2, stableKey)
    if not module.DoRequiredFieldsPresentForSentFromChannelsApi(arg1) then
        return nil
    end

    local module2 = module.new()
    module2.id = arg1.messages[1].id
    module2.senderTargetId = tostring(arg1.messages[1].sender_user_id)
    module2.senderType = module.SenderTypes.User
    module2.read = true
    module2.sent = DateTime.fromIsoDate(arg1.messages[1].created_at)
    module2.conversationId = tostring(arg2)
    module2.previousMessageId = ""
    module2.moderationType = arg1.messages[1].moderation_type

    module2.stableKey = stableKey or module2.id
    module2.isBadgeable = arg1.messages[1].is_badgeable
    module2.isPreviewable = arg1.messages[1].is_previewable

    module2.filteredForReceivers = false

    module2.messageType = module.MessageTypes.PlainText
    module2.content = arg1.messages[1].content
    module2.repliesTo = module.fromChannelsApi(arg1.messages[1].replies_to, nil, nil, true)

    if arg1.visibility
        and (arg1.visibility == module.VisibilityTypes.Visible or arg1.visibility == module.VisibilityTypes.Hidden)
    then
        module2.visibility = arg1.visibility
    else
        module2.visibility = module.VisibilityTypes.Visible
        Logger:debug("Message visibility type is invalid for message id: " .. module2.id)
    end

    return module2
end

function module.DoRequiredFieldsPresentForSentFromChannelsApi(arg1)
    local messages = arg1 and arg1.messages
    return messages and #arg1.messages > 0 and arg1.messages[1].id and arg1.messages[1].created_at
end

return module
