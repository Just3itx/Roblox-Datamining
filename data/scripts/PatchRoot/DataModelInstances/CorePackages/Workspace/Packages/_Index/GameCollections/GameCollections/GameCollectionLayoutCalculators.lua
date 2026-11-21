-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local CollectionViews = require(GameCollectionsParent.CollectionViews)
local GameTileViewConfig = require(GameCollectionsParent.GameTile).GameTileViewConfig
local CollectionLayoutCalculators = CollectionViews.CollectionLayoutCalculators
local _Style = require(GameCollectionsParent.Style)

return {
    calculateNumColumns = CollectionLayoutCalculators.calculateNumColumns,
    calculateTileHeightFromWidth = function(num1: number, _: boolean?, arg1, arg2, bool1: boolean?, bool2: boolean?, bool3: boolean?, num2: number?, num3: number?, num4: number?, num5: number?)
        return GameTileViewConfig.getTileHeight(arg2, num1, arg1, bool1, bool2, bool3, num2, num3, num4, num5)
    end,
    calculateSideMargin = CollectionLayoutCalculators.calculateSideMargin,
    calculateColumnGap = CollectionLayoutCalculators.calculateColumnGap,
    calculateVerticalPadding = CollectionLayoutCalculators.calculateVerticalPadding,
    calculateFractionalItemAmount = CollectionLayoutCalculators.calculateFractionalItemAmount,
    calculateMaxTilesToShow = CollectionLayoutCalculators.calculateMaxTilesToShow,
    calculateLoadMoreThreshold = CollectionLayoutCalculators.calculateLoadMoreThreshold
}
