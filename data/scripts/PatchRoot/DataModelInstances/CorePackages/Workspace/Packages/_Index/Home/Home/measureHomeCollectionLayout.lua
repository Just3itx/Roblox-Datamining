-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HomeParent = script:FindFirstAncestor("Home").Parent

local CollectionViews = require(HomeParent.CollectionViews)
local buildSduiCollectionInfo = require(HomeParent.SduiSharedUtilities).buildSduiCollectionInfo
local FFlagSduiPreferredTextSizeLineBudgets = require(HomeParent.SharedFlags).FFlagSduiPreferredTextSizeLineBudgets

local uDim = UDim.new(1, 72)

local function measureHomeCollectionLayout()
    if not CollectionViews.getMainCollectionLayoutStore(false).getIsContainerMeasured(false) then
        return nil
    end

    return buildSduiCollectionInfo("Small", uDim, if FFlagSduiPreferredTextSizeLineBudgets then 3 else nil)
end

return measureHomeCollectionLayout
