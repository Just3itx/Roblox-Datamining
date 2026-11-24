-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local Radius = Foundation.Enums.Radius
local Sheet = Foundation.Sheet
local Skeleton = Foundation.Skeleton
local View = Foundation.View

return React.memo(function(_) -- name: DynamicReportV2Loading
    return React.createElement(React.Fragment, nil, {
        Header = React.createElement(
            Sheet.Header,
            { hasCloseAffordance = true },
            React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 24), radius = Radius.Medium })
        ),
        Content = React.createElement(
            Sheet.Content,
            nil,
            React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, {
                Title = React.createElement(Skeleton, { Size = UDim2.new(0.8, 0, 0, 40), radius = Radius.Medium, LayoutOrder = 1 }),
                Item1 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium, LayoutOrder = 2 }),
                Item2 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium, LayoutOrder = 3 }),
                Item3 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium, LayoutOrder = 4 }),
                Item4 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium, LayoutOrder = 5 }),
                Item5 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium, LayoutOrder = 6 })
            })
        )
    })
end)
