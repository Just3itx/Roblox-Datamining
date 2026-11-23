-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function ExperienceResultsLoadingSkeleton(tbl1)
    local var1 = useTokens()
    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(1, 0, 0, var1.Size.Size_2000),
        tag = "row align-y-center gap-medium",
        testId = `{tbl1.testIdPrefix}.LoadingSkeleton.{tbl1.index}`
    }, {
        ThumbnailContainer = React.createElement(
            View,
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(var1.Size.Size_1400, var1.Size.Size_1400)
            },
            {
                Thumbnail = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Medium })
            }
        ),
        Details = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col fill gap-small size-full-0 auto-y"
        }, {
            Title = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 1,
                    Size = UDim2.new(0.72, 0, 0, var1.Size.Size_400),
                    radius = Radius.Small
                }
            ),
            Description = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 2,
                    Size = UDim2.new(0.44, 0, 0, var1.Size.Size_250),
                    radius = Radius.Small
                }
            )
        })
    })
end
return ExperienceResultsLoadingSkeleton
