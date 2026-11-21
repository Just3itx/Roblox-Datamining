-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local tbl1 = { minimumItemsPerRow = 4, minimumItemWidth = 140 }
local var1 = require(AvatarExperienceProfilePictureEditorParent.UIBlox).App.Grid.GridMetrics.makeCustomMetricsGetter(tbl1)

local function getGridMetrics(tbl2)
    local num1 = math.max(0, math.max(0, tbl2.containerWidth - tbl2.horizontalPadding * 2) - tbl2.strokeInset * 2)

    if num1 <= 0 then
        return {
            itemsPerRow = tbl1.minimumItemsPerRow,
            itemWidth = tbl2.minTileSize
        }
    end

    local var2 = var1(num1, tbl2.gap)
    return if var2.itemWidth < tbl1.minimumItemWidth then {
        itemsPerRow = var2.itemsPerRow,
        itemWidth = tbl1.minimumItemWidth
    } else var2
end

return getGridMetrics
