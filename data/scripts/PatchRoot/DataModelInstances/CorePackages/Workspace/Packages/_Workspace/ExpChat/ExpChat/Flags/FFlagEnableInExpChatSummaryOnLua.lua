-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local FFlagEnableClientSummarySystemMessageOnLua = require(ExpChatParent.SharedFlags).FFlagEnableClientSummarySystemMessageOnLua

local engineFeature = game:GetEngineFeature("EnableInExpChatSummary2")
local bool1 = game:DefineFastFlag("EnableInExpChatSummaryOnLua4", false)

return engineFeature and (bool1 or FFlagEnableClientSummarySystemMessageOnLua)
