-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)

local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function GroupListItemSkeleton(tbl1)
    local var1 = useTokens()

    return React.createElement(View, {
        tag = "row gap-large align-y-center padding-small radius-medium",
        Size = UDim2.new(1, 0, 0, 54),
        LayoutOrder = tbl1.layoutOrder
    }, {
        ThumbnailContainer = React.createElement(
            View,
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(38, 38)
            },
            {
                ThumbnailSkeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Medium })
            }
        ),
        Details = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col size-full-0 auto-y fill gap-small"
        }, {
            NameSkeleton = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(0.7, 0, 0, var1.Size.Size_350),
                    radius = Radius.Small,
                    LayoutOrder = 1
                }
            ),
            MetaSkeleton = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(0.5, 0, 0, var1.Size.Size_250),
                    radius = Radius.Small,
                    LayoutOrder = 2
                }
            )
        })
    })
end

return GroupListItemSkeleton
