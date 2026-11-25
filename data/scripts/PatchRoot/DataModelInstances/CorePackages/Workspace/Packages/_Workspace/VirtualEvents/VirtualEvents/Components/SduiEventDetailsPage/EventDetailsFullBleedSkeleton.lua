-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local React = require(VirtualEventsParent.React)
local Foundation = require(VirtualEventsParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

return React.memo(function() -- name: EventDetailsFullBleedSkeleton
    local var1 = useTokens()

    return React.createElement(
        View,
        {
            Size = UDim2.fromScale(1, 1),
            ClipsDescendants = true,
            BackgroundTransparency = 1
        },
        {
            Skeleton = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, var1.Radius.Large), radius = Radius.Large })
        }
    )
end)
