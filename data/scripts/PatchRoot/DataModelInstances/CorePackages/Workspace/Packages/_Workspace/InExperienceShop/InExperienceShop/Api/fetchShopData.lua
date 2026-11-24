-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local _Promise = require(InExperienceShopParent.Promise)
local MockShopData = require(InExperienceShop.Mocks.MockShopData)
local _Types = require(InExperienceShop.Types)

local function fetchShopData()
    return MockShopData.getShopData()
end

return fetchShopData
