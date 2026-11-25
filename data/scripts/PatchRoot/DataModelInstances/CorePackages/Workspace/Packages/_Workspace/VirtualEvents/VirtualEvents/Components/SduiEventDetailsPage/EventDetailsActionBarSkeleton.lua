-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local React = require(VirtualEventsParent.React)
local Foundation = require(VirtualEventsParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

return React.memo(function() -- name: EventDetailsActionBarSkeleton
    local size1000 = useTokens().Size.Size_1000

    return React.createElement(
        View,
        {
            tag = "row align-y-center gap-small size-full-0 auto-y",
            testId = "--event-details-action-bar-skeleton"
        },
        {
            JoinButton = React.createElement(
                View,
                { tag = "grow auto-y", LayoutOrder = 1 },
                {
                    Skeleton = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, size1000), radius = Radius.Medium })
                }
            ),
            ShareButton = React.createElement(Skeleton, { Size = UDim2.fromOffset(size1000, size1000), radius = Radius.Medium, LayoutOrder = 2 })
        }
    )
end)
