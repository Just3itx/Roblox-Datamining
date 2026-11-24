-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)

local Layout = LayoutSlots.inlineSlots.Layout
local OverlaidControlsProvider = LayoutSlots.OverlaidControlsProvider
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local View = Foundation.View

return React.memo(function(tbl1) -- name: DynamicReportV2InExpLoading
    return React.createElement(OverlaidControlsProvider, {
        value = tbl1.shouldUseOverlaidControls
    }, {
        Layout = React.createElement(Layout, {
            body = React.createElement(React.Fragment, nil, {
                Title = React.createElement(Skeleton, { Size = UDim2.new(0.8, 0, 0, 40), radius = Radius.Medium, LayoutOrder = 1 }),
                Items = React.createElement(View, {
                    tag = "col gap-medium size-full-0 auto-y",
                    LayoutOrder = 2
                }, {
                    Item1 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium }),
                    Item2 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium }),
                    Item3 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium }),
                    Item4 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium }),
                    Item5 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 50), radius = Radius.Medium })
                })
            })
        })
    })
end)
