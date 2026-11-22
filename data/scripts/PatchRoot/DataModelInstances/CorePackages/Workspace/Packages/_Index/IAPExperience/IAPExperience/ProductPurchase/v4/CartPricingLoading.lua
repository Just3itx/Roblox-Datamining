-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local Radius = Foundation.Enums.Radius

local function CartPricingLoading(tbl1)
    if not tbl1.isLoading then
        return nil
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder or 2,
        tag = "size-full-0 auto-y padding-xxsmall"
    }, {
        LoadingSkeleton = React.createElement(
            Skeleton,
            {
                Name = "CartPricingLoadingSkeleton",
                Size = UDim2.new(1, 0, 0, 44),
                radius = Radius.Circle
            }
        )
    })
end
return CartPricingLoading
