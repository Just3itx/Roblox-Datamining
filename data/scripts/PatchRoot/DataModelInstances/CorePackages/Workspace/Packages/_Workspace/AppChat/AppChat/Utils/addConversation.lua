-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Conversation = require(AppChat.Models.Conversation)
local Immutable = require(AppChatParent.AppCommonLib).Immutable

return function(arg1, arg2)
    if arg2.conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION then
        local var1 = Conversation.IdForFakeOneOnOne(arg2.participants)
        if arg1[var1] ~= nil then
            arg1 = Immutable.Set(arg1, var1, nil)
        end
    end

    if not arg1[arg2.id] then
        return Immutable.Set(arg1, arg2.id, arg2)
    end

    return arg1
end
