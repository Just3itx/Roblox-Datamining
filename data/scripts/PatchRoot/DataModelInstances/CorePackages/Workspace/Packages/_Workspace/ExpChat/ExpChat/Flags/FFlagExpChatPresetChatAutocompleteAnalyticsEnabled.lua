-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChat = script:FindFirstAncestor("ExpChat")

local FFlagExpChatPresetChatAutocompleteEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatAutocompleteEnabled)

return game:DefineFastFlag("ExpChatPresetChatAutocompleteAnalyticsEnabled", false)
    and FFlagExpChatPresetChatAutocompleteEnabled
