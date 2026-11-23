-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local getDeepValue = require(AppChat.Utils.getDeepValue)

return function(arg1, arg2)
    local deepValue = getDeepValue(arg1, string.format("ChatAppReducer.Conversations.%s", arg2 or ""))
    if not (deepValue and deepValue.usersTyping and arg1.Users) then
        return {}
    end

    local usersTyping = deepValue.usersTyping
    local users = arg1.Users

    local result = {}
    for k, value in pairs(usersTyping) do
        if k ~= arg1.LocalUserId and value then
            table.insert(result, users[k])
        end
    end

    return result
end
