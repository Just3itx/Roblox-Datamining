-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceModel = script:FindFirstAncestor("AvatarExperienceModel")
local AvatarExperienceModelParent = AvatarExperienceModel.Parent

local Signals = require(AvatarExperienceModelParent.Signals)

local createLayeredClothingLastSavedSortStore = require(AvatarExperienceModel.Stores.LayeredClothingLastSavedSortStore.createLayeredClothingLastSavedSortStore)

return Signals.createComputed(createLayeredClothingLastSavedSortStore)
