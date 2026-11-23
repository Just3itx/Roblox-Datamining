-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local MessageModel = require(script.Parent.MessageModel)
local DateTime = require(AppChatParent.Time).DateTime

local module = {}

function module.responseUser(tbl1)
    return {
        id = if tbl1.id then tbl1.id else "message-id",
        type = MessageModel.SenderTypes.User,
        sender_user_id = if tbl1.sender_user_id then tbl1.sender_user_id else 1,
        sent = if tbl1.sent then tbl1.sent else DateTime.fromIsoDate("2021-01-01T00:00:00Z"),
        content = if tbl1.content then tbl1.content else "message-content",
        created_at = if tbl1.created_at then tbl1.created_at else DateTime.fromIsoDate("2021-01-01T00:00:00Z"),
        moderation_type = if tbl1.moderation_type then tbl1.moderation_type else "trusted_comms",
        is_previewable = not (tbl1.is_previewable == nil) and tbl1.is_previewable,
        is_badgeable = not (tbl1.is_badgeable == nil) and tbl1.is_badgeable
    }
end

function module.responseSystem(tbl1)
    return {
        id = if tbl1.id then tbl1.id else "message-id",
        type = "system",
        sent = if tbl1.sent then tbl1.sent else "2021-01-01T00:00:00Z",
        content = if tbl1.content then tbl1.content else "message-content",
        created_at = if tbl1.created_at then tbl1.created_at else "2021-01-01T00:00:00Z"
    }
end

return module
