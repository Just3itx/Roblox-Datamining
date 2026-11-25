-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local React = require(VirtualEventsParent.React)
local Foundation = require(VirtualEventsParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local EventDetailsActionBarSkeleton = require(script.Parent.EventDetailsActionBarSkeleton)

local FFlagLuaAppSduiEventDetailsActionBarInFeed = require(VirtualEventsParent.SharedFlags).FFlagLuaAppSduiEventDetailsActionBarInFeed

return React.memo(function() -- name: EventDetailsFeedSkeleton
    local var1 = useTokens()

    local size1400 = var1.Size.Size_1400
    local yOffset = var1.Typography.CaptionLarge.LineHeight * var1.Typography.CaptionLarge.FontSize
    local yOffset2 = var1.Typography.HeadingSmall.LineHeight * var1.Typography.HeadingSmall.FontSize
    local yOffset3 = var1.Typography.CaptionMedium.LineHeight * var1.Typography.CaptionMedium.FontSize * 3

    return React.createElement(
        View,
        {
            tag = "col gap-large size-full auto-y padding-top-medium",
            testId = "--event-details-feed-skeleton"
        },
        {
            AttributionRow = React.createElement(
                View,
                { tag = "row align-y-center gap-medium size-full-0 auto-y", LayoutOrder = 1 },
                {
                    Icon = React.createElement(Skeleton, { Size = UDim2.fromOffset(size1400, size1400), radius = Radius.Medium, LayoutOrder = 1 }),
                    TextColumn = React.createElement(View, {
                        tag = "col fill gap-small auto-xy",
                        LayoutOrder = 2
                    }, {
                        Title = React.createElement(
                            Skeleton,
                            {
                                Size = UDim2.fromOffset(var1.Size.Size_2800 * 2, yOffset),
                                radius = Radius.Small,
                                LayoutOrder = 1
                            }
                        ),
                        Host = React.createElement(
                            Skeleton,
                            {
                                Size = UDim2.fromOffset(var1.Size.Size_2800, yOffset),
                                radius = Radius.Small,
                                LayoutOrder = 2
                            }
                        )
                    })
                }
            ),
            ActionBar = if FFlagLuaAppSduiEventDetailsActionBarInFeed then React.createElement(
                View,
                { tag = "size-full-0 auto-y", LayoutOrder = 2 },
                {
                    Skeleton = React.createElement(EventDetailsActionBarSkeleton)
                }
            ) else nil,
            Description = React.createElement(View, {
                tag = "col gap-medium size-full-0 auto-y",
                LayoutOrder = 3
            }, {
                Header = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800 * 2, yOffset2),
                        radius = Radius.Small,
                        LayoutOrder = 1
                    }
                ),
                Text = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, yOffset3), radius = Radius.Small, LayoutOrder = 2 })
            })
        }
    )
end)
