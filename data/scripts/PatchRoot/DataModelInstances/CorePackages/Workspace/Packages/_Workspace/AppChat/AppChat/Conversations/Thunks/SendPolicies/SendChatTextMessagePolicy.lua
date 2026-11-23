-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local var1 = require(AppChat.Logger):new(script.Name)

local MessageModel = require(AppChat.Models.MessageModel)
local SendChatMessagePolicy = require(script.Parent.SendChatMessagePolicy)

local var2 = setmetatable({}, SendChatMessagePolicy)
var2.__index = var2

function var2.new(arg1, arg2, messageText, arg3, decorators)
    var1:info(
        "New policy constructed for conversationId: {} messageText: {}, replyingToId: {}",
        arg2,
        messageText,
        if arg3 then arg3.id else nil
    )

    local var3 = SendChatMessagePolicy:new(arg2, arg3)
    setmetatable(var3, arg1)

    var3.messageText = messageText
    var3.decorators = decorators

    return var3
end

function var2.sendMessage(arg1, _)
    var1:info(
        "sendMessage - conversationId: {} messageText: {}, replyingToId: {}",
        arg1.conversationId,
        arg1.messageText,
        if arg1.replyingToMessage then arg1.replyingToMessage.id else nil
    )

    return AppChatNetworking.http.SendChatTextMessage(
        nil,
        arg1.conversationId,
        arg1.messageText,
        if arg1.replyingToMessage then arg1.replyingToMessage.id else nil
    )
end

function var2.sendingMessagePayload(arg1)
    return {
        messageType = MessageModel.MessageTypes.PlainText,
        content = arg1.messageText
    }
end

return var2
