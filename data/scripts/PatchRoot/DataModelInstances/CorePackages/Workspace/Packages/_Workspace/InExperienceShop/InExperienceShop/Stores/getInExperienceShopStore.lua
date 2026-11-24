-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)

local createInExperienceShopStore = require(InExperienceShop.Stores.createInExperienceShopStore)

return Signals.createComputed(createInExperienceShopStore)
