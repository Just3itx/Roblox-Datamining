-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local Icon = Foundation.Icon
local Progress = Foundation.Progress
local FoundationText = Foundation.Text
local View = Foundation.View

local IconSize = Foundation.Enums.IconSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize

local function PostStatusRowView(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y padding-large radius-medium bg-shift-300",
        testId = "moments-post-status-row"
    }

    local tbl3 = {
        Media = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-x-center align-y-center size-1000-1000"
        }, {
            Indicator = if tbl1.variant == "posting" then React.createElement(Progress, {
                shape = ProgressShape.Circle,
                size = ProgressSize.Medium,
                value = tbl1.progress,
                testId = "moments-post-status-row-progress"
            }) else React.createElement(
                Icon,
                {
                    name = BuilderIcons.Icon.TriangleExclamation,
                    size = IconSize.Medium,
                    testId = "moments-post-status-row-warning"
                }
            )
        }),
        Text = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col align-x-left align-y-center grow auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis",
                Text = tbl1.title
            }),
            Body = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                Text = tbl1.body
            })
        })
    }
    return createElement(var1, tbl2, tbl3)
end

return PostStatusRowView
