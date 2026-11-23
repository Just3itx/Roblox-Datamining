-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local Signals = require(AvatarExperienceCommonParent.Signals)

local createAXTooltipStore = require(script.createAXTooltipStore)

return Signals.createComputed(createAXTooltipStore)
