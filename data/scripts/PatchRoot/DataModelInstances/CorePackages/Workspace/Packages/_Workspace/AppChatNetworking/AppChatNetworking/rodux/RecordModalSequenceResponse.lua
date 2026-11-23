-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local Packages = script:FindFirstAncestor("Packages")
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local _SharedTypes = require(AppChatNetworking.responses.SharedTypes)
local var1 = require(Packages.Loggers).Logger:new(script.Name)

return require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, actionType, modalSequence: string, modalId: string, modalVariant: string, conversationId, friendId)
    if conversationId and friendId then
        var1:warn("Both conversation ID and friend ID provided to RecordModalSequenceResponse.")
    end

    return arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("record-modal-sequence-response"):body({
        action_type = actionType,
        modal_sequence = modalSequence,
        modal_id = modalId,
        modal_variant = modalVariant,
        conversation_id = conversationId,
        friend_id = friendId
    })
end)
