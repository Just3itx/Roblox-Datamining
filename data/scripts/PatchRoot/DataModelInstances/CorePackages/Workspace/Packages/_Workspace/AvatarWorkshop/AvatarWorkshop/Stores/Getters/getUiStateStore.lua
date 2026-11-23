-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local Signals = require(AvatarWorkshopParent.Signals)

local createUiStateStore = require(AvatarWorkshop.Stores.Creators.createUiStateStore)

return Signals.createComputed(createUiStateStore)
