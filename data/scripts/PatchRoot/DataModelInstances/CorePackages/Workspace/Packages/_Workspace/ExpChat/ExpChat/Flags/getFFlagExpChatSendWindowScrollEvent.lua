-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local getFFlagExpChatTelemetryEventTrigger = require(ExpChat.Flags.getFFlagExpChatTelemetryEventTrigger)
game:DefineFastFlag("ExpChatSendWindowScrollEvent", false)

return function()
    return game:GetFastFlag("ExpChatSendWindowScrollEvent") and getFFlagExpChatTelemetryEventTrigger()
end
