-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local CompositionTags = require(AvatarExperienceCatalogParent.AppComposition).CompositionTags

return React.memo(function(tbl1) -- name: MarketplaceFeedSkeleton
    local var1 = useTokens()

    local numCarousels = tbl1.numCarousels or 4
    local yOffset = tbl1.rowHeight or var1.Size.Size_3000 * 2
    local yOffset2 = tbl1.headerHeight or var1.Size.Size_400
    local headerWidthFraction = tbl1.headerWidthFraction or 0.4

    local tbl2 = ({})
    for layoutOrder = 1, numCarousels do
        local str1 = `Carousel-{layoutOrder}`
        local createElement = React.createElement
        local var2 = View

        local tbl3 = {
            Header = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(headerWidthFraction, 0, 0, yOffset2),
                    radius = Radius.Medium,
                    LayoutOrder = 1
                }
            ),
            Row = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, yOffset), radius = Radius.Medium, LayoutOrder = 2 })
        }
        tbl2[str1] = createElement(var2, { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = layoutOrder }, tbl3)
    end

    return React.createElement(View, {
        tag = {
            ["col gap-xlarge size-full auto-y padding-y-small"] = true,
            [CompositionTags.ContentRegion.Body] = true
        },
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId or "--marketplace-feed-skeleton"
    }, tbl2)
end)
