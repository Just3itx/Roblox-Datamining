-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local React = require(InterventionSharedParent.React)

local Foundation = require(InterventionSharedParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local FFlagUFRImprovements = require(InterventionShared.Flags.FFlagUFRImprovements)

return React.memo(function() -- name: InterventionDialogLoadingSkeleton
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = View
    local tbl1 = {
        tag = "col gap-medium size-full-0 auto-y margin-top-small",
        testId = "intervention-dialog-loading-skeleton"
    }

    local tbl2 = {
        Heading = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0.6, 0, 0, var1.Size.Size_1100),
                radius = Radius.Medium,
                LayoutOrder = 1
            }
        ),
        Body = React.createElement(Skeleton, {
            Size = UDim2.new(1, 0, 0, if FFlagUFRImprovements then var1.Size.Size_3000 else var1.Size.Size_2000),
            radius = Radius.Medium,
            LayoutOrder = 2
        }),
        Actions = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(1, 0, 0, var1.Size.Size_800),
                radius = Radius.Medium,
                LayoutOrder = 3
            }
        )
    }
    return createElement(var2, tbl1, tbl2)
end)
