-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local SendTextMessage = require(AppChat.Conversations.Thunks.SendTextMessage)
local var1 = require(AppChat.Logger):new(script.Name)

return function(...)
    var1:info("Sending text message")
    return SendTextMessage(...)
end
