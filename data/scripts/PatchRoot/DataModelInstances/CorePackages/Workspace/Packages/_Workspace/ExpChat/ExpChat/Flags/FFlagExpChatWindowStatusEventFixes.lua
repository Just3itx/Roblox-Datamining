-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local getFFlagExpChatTriggerWindowStatusEvent = require(script.Parent.getFFlagExpChatTriggerWindowStatusEvent)

return game:DefineFastFlag("ExpChatWindowStatusEventFixes", false) and getFFlagExpChatTriggerWindowStatusEvent()
