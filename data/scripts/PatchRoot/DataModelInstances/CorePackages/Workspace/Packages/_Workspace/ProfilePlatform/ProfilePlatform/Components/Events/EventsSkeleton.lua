-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Foundation = require(ProfilePlatformParent.Foundation)
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local View = Foundation.View
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset
local GameCollections = require(ProfilePlatformParent.GameCollections)
local CollectionCarousel = require(ProfilePlatformParent.CollectionViews).CollectionCarousel
local useGetGameTileHeight = GameCollections.useGetGameTileHeight
local useDesignTokens = require(ProfilePlatformParent.Style).useDesignTokens

local function EventsSkeleton(tbl1)
    local var1 = useLocalization({ events = TextKeys.EventsListTitle })

    local var2 = useTextSizeOffset()
    local var3 = useDesignTokens()
    local getItemHeight = useGetGameTileHeight(false, "Event", true, false, false, var2, var3.Size.Size_700 + var3.Size.Size_200)

    local renderItem = React.useCallback(function(_, layoutOrder: number, size)
        return React.createElement(View, {
            tag = "col gap-medium radius-medium",
            LayoutOrder = layoutOrder,
            Size = size
        }, {
            ThumbnailSkeleton = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromScale(1, 0.6), radius = Radius.Medium }),
            NameSkeleton = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromScale(0.8, 0.15), radius = Radius.Medium }),
            ButtonSkeleton = React.createElement(Skeleton, { LayoutOrder = 3, Size = UDim2.fromScale(1, 0.1), radius = Radius.Medium })
        }), "Skeleton_" .. layoutOrder
    end, {})

    local items = React.useMemo(function(): {number}
        local result = {}
        for i = 1, tbl1.numSkeletons do
            table.insert(result, i)
        end
        return result
    end, { tbl1.numSkeletons })

    return React.createElement(CollectionCarousel, {
        scrollingFrameRef = nil,
        title = var1.events,
        hideHeaderButton = true,
        items = items,
        renderItem = renderItem,
        getItemHeight = getItemHeight,
        numColumns = 1,
        columnGap = var3.Size.Size_300,
        fractionalItemAmount = 0.33,
        sideMargin = 0
    })
end

return EventsSkeleton
