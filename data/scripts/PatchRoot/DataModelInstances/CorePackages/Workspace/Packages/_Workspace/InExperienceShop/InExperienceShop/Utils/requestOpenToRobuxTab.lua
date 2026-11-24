-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local isSideSheetEnabled = require(InExperienceShopParent.InExperienceSideSheetUtils.isSideSheetEnabled)

local function requestOpenToRobuxTab()
    if isSideSheetEnabled then
        getInExperienceShopStore(false).setShouldOpenToRobuxTab(true)
    end
end

return requestOpenToRobuxTab
