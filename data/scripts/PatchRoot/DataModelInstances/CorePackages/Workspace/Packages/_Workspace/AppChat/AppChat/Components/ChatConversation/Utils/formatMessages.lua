-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)
local ArgCheck = require(AppChatParent.ArgCheck)

return function(arg1, arg2)
    ArgCheck.isType(arg1, "table", "formatMessages.messages")
    ArgCheck.isType(arg2, "table", "formatMessages.messageData")

    return Cryo.List.map(arg1, function(arg3)
        if arg3.placeId or arg3.shareLink then
            return Cryo.Dictionary.join(arg2, arg3, { messageType = EnumMessageTypes.Link, content = Cryo.None })
        end

        return Cryo.Dictionary.join(arg2, arg3)
    end)
end
