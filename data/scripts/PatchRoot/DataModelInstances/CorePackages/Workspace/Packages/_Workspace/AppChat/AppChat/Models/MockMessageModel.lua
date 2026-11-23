-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local DateTime = require(AppChatParent.Time).DateTime
local GenerateStringId = require(AppChatParent.AppCommonLib).GenerateStringId

local MessageModel = require(script.Parent.MessageModel)

local module = {}

function module.mock(arg1)
    local messageModel = MessageModel.new()

    messageModel.id = GenerateStringId()
    messageModel.senderTargetId = GenerateStringId()
    messageModel.conversationId = GenerateStringId()
    messageModel.senderType = MessageModel.SenderTypes.User
    messageModel.content = "MESSAGE CONTENT"
    messageModel.messageType = MessageModel.MessageTypes.PlainText

    messageModel.read = false
    messageModel.sent = DateTime.now()
    messageModel.previousMessageId = nil
    messageModel.filteredForReceivers = false

    if arg1 ~= nil then
        for k, value in pairs(arg1) do
            messageModel[k] = value
        end
    end

    return messageModel
end

setmetatable(module, { __index = MessageModel })

return module
