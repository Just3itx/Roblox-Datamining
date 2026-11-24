-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnableInExpChatSummaryOnLua = require(script.Parent.FFlagEnableInExpChatSummaryOnLua)

local bool1 = game:DefineFastFlag("EnableInExpChatPolishSummaryOnLuaForTranslatedMessageV2", false)

return FFlagEnableInExpChatSummaryOnLua and bool1
