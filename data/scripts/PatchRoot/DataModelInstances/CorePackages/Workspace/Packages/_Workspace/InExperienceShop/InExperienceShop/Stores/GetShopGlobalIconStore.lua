-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local Signals = require(InExperienceShopParent.Signals)
local createShopGlobalIconStore = require(script.createShopGlobalIconStore)

return Signals.createComputed(createShopGlobalIconStore)
