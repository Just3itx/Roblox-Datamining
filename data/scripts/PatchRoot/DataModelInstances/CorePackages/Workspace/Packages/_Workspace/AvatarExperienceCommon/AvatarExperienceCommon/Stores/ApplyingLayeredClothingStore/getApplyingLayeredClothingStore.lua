-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local Signals = require(AvatarExperienceCommonParent.Signals)

local createApplyingLayeredClothingStore = require(AvatarExperienceCommon.Stores.ApplyingLayeredClothingStore.createApplyingLayeredClothingStore)

return Signals.createComputed(createApplyingLayeredClothingStore)
