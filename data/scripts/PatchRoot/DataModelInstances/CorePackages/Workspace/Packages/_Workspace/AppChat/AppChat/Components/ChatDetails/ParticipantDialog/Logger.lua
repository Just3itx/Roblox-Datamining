-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local var1 = require(AppChat.Logger):new(script:GetFullName() .. ":ParticipantDialogScreen")
var1:setContext({ screen = "ParticipantDialogScreen" })

return var1
