-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local ExpChatPresetChatAutocompleteExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatAutocompleteExperimentation

local FFlagExpChatPresetChatSendEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatSendEnabled

return game:DefineFastFlag("ExpChatPresetChatAutocompleteEnabled3", false)
    and ExpChatPresetChatAutocompleteExperimentation.isEnabled()
    and FFlagExpChatPresetChatSendEnabled
