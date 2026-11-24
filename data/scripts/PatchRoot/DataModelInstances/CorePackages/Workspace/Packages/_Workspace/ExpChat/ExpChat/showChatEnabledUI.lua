-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local isUserChatEnabled = require(ExpChat.isUserChatEnabled)

return function(str1: string)
    return isUserChatEnabled(str1) or str1 == "NoOne"
end
