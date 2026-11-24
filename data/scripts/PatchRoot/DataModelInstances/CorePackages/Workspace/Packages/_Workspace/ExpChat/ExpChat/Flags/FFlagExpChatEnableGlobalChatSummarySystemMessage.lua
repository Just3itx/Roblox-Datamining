-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local bool1 = game:DefineFastFlag("ExpChatEnableGlobalChatSummarySystemMessage", false)
local engineFeature = game:GetEngineFeature("EnableGlobalChat3pSummary")
local FFlagEnableInExpChatSummaryOnLua = require(script.Parent.FFlagEnableInExpChatSummaryOnLua)

return engineFeature and bool1 and FFlagEnableInExpChatSummaryOnLua
