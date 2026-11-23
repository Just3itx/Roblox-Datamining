-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SendMessageUsingPolicy = require(script.Parent.SendMessageUsingPolicy)
local SendChatTextMessagePolicy = require(script.Parent.SendPolicies.SendChatTextMessagePolicy)

return function(arg1, arg2, arg3, arg4)
    local var1 = SendChatTextMessagePolicy:new(arg1, arg2, arg3, arg4)

    return SendMessageUsingPolicy(var1)
end
