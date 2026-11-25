-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:03Z
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
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset

local overrides = { numColumns = 3 }

local function getTextSizeAdjustedSquareExperienceTileHeight(num1: number): (number) -> number -- Luacid: Inlined by compiler; 1 call site recovered
    return function(num2: number): number
        return num2 + 80 + num1 * 3
    end
end

local function ExperiencesSkeleton(tbl2)
    local var1 = useLocalization({ experiences = TextKeys.Experiences })

    local var2 = useTextSizeOffset()
    local getItemHeight = React.useMemo(function(): (number) -> number
        return getTextSizeAdjustedSquareExperienceTileHeight(var2)
    end, { var2 })

    local renderItem = React.useCallback(function(_, layoutOrder: number, size)
        return React.createElement(View, {
            tag = "col gap-small radius-medium",
            LayoutOrder = layoutOrder,
            Size = size
        }, {
            ThumbnailSkeleton = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromScale(1, 0.6), radius = Radius.Medium }),
            NameSkeleton = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromScale(0.8, 0.18), radius = Radius.Medium }),
            ButtonSkeleton = React.createElement(Skeleton, { LayoutOrder = 3, Size = UDim2.fromScale(0.6, 0.08), radius = Radius.Medium })
        }), "Skeleton_" .. layoutOrder
    end, {})

    local items = React.useMemo(function(): {number}
        local result = {}
        for i = 1, tbl2.numSkeletons do
            table.insert(result, i)
        end
        return result
    end, { tbl2.numSkeletons })

    return React.createElement(SquareCollectionGridView, {
        layoutOrder = tbl2.layoutOrder,
        items = items,
        renderItem = renderItem,
        getItemHeight = getItemHeight,
        title = var1.experiences,
        overrides = overrides
    })
end

return ExperiencesSkeleton
