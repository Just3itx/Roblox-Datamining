-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local _AppComposition = require(ShareSheetParent.AppComposition)
local CollectionViews = require(ShareSheetParent.CollectionViews)

local function getShareSheetRowLayout(num1: number, arg1, displaySize, num2: number)
    local margin = arg1.margin
    local gutter = arg1.gutter
    local var1 = if displaySize ~= Enum.DisplaySize.Small then 0 else arg1.carouselPeek
    local num3 = if var1 > 0 then 1 else 0

    local numColumns = CollectionViews.calculateNumColumns(num2, gutter, 1, math.huge, num1 - 2 * margin - var1)
    local itemWidth = CollectionViews.calculateItemWidth(numColumns, gutter, margin, num1, 0, var1)
    local num4 = math.floor(itemWidth)
    local num5 = math.round((itemWidth - num4) * numColumns)

    return {
        margin = margin,
        gap = gutter,
        visibleTileCount = numColumns + num3,
        maxTileCount = var1 > 0 and math.huge or numColumns,
        getTileWidth = function(num6: number): number
            return if num6 <= num5 then num4 + 1 else num4
        end,
        isScrollingEnabled = function(num6: number): boolean
            return numColumns < num6
        end
    }
end

return getShareSheetRowLayout
