-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local SquareCollectionGridView = require(ProfilePlatform.BaseComponents.CollectionGridViews.SquareCollectionGridView)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Foundation = require(ProfilePlatformParent.Foundation)
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local View = Foundation.View

local function getItemHeight(num1: number): number
    return num1 + 49
end

local function StoreGridSkeleton(tbl1)
    local var1 = useLocalization({ store = TextKeys.Store })

    local renderItem = React.useCallback(function(_, layoutOrder: number, size)
        return React.createElement(View, {
            tag = "col gap-small radius-medium",
            LayoutOrder = layoutOrder,
            Size = size
        }, {
            ThumbnailSkeleton = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromScale(1, 0.7), radius = Radius.Medium }),
            NameSkeleton = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromScale(0.8, 0.09), radius = Radius.Medium }),
            ButtonSkeleton = React.createElement(Skeleton, { LayoutOrder = 3, Size = UDim2.fromScale(0.6, 0.09), radius = Radius.Medium })
        }), "Skeleton_" .. layoutOrder
    end, {})

    local items = React.useMemo(function(): {number}
        local result = {}
        for i = 1, tbl1.numSkeletons do
            table.insert(result, i)
        end
        return result
    end, { tbl1.numSkeletons })

    return React.createElement(SquareCollectionGridView, {
        layoutOrder = tbl1.layoutOrder,
        items = items,
        renderItem = renderItem,
        getItemHeight = getItemHeight,
        title = var1.store,
        overrides = {
            numColumns = tbl1.numColumns or 3
        }
    })
end

return StoreGridSkeleton
