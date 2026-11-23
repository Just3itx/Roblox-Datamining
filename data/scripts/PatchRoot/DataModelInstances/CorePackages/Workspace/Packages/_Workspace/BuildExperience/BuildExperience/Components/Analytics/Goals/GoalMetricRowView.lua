-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local GoalMetricDeltaPill = require(script.Parent.GoalMetricDeltaPill)

local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function GoalMetricRowView(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "GoalMetricRowView"

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-xsmall size-full-0 auto-y",
        testId = testId
    }
    local tbl3 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title,
            tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end content-default",
            testId = `{testId}-title`
        }),
        Value = 0
    }
    local element

    if tbl1.isLoading then
        element = React.createElement(Skeleton, {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, var1.Size.Size_500),
            radius = Radius.Small,
            testId = `{testId}-loading`
        })
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-small size-full-0 auto-y"
        }, {
            Icon = if tbl1.icon then React.createElement(Icon, {
                LayoutOrder = 1,
                name = tbl1.icon,
                size = IconSize.Medium,
                tag = "content-emphasis",
                testId = `{testId}-icon`
            }) else nil,
            Value = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.valueText,
                tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
                testId = `{testId}-value`
            }),
            Delta = if tbl1.deltaText == nil then nil else React.createElement(GoalMetricDeltaPill, {
                layoutOrder = 3,
                text = tbl1.deltaText,
                isPositive = tbl1.isDeltaPositive == true,
                testId = `{testId}-delta`
            })
        })
    end

    tbl3.Value = element
    return createElement(var2, tbl2, tbl3)
end

return GoalMetricRowView
