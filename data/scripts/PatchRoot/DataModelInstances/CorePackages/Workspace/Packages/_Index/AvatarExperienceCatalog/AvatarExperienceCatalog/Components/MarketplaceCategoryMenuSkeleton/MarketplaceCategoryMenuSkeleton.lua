-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: MarketplaceCategoryMenuSkeleton
    local var1 = useTokens()

    local numCategoryChips = tbl1.numCategoryChips or 6
    local yOffset = tbl1.chipHeight or var1.Size.Size_800
    local xOffset = tbl1.chipWidth or var1.Size.Size_2800

    local tbl2 = ({})
    for layoutOrder = 1, numCategoryChips do
        local str1 = `Chip-{layoutOrder}`
        tbl2[str1] = React.createElement(
            Skeleton,
            {
                radius = Radius.Circle,
                Size = UDim2.fromOffset(xOffset, yOffset),
                LayoutOrder = layoutOrder
            }
        )
    end
    return React.createElement(View, {
        tag = "row gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId or "--marketplace-category-menu-skeleton"
    }, tbl2)
end)
