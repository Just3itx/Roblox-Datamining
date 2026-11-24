-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)

local function setOpenedFromBuyRobux(bool1: boolean)
    getInExperienceShopStore(false).setOpenedFromBuyRobux(bool1)
end

return setOpenedFromBuyRobux
