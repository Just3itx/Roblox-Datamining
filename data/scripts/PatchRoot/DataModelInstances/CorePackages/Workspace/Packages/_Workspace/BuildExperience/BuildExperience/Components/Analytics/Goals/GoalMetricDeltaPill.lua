-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconPosition = Foundation.Enums.IconPosition
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local function GoalMetricDeltaPill(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "GoalMetricDeltaPill"
    local style = if tbl1.isPositive then var1.Color.System.Success else var1.Color.Content.Default
    local name = if tbl1.isPositive then IconName.ArrowWideShortUp else IconName.ArrowWideShortDown
    local bool1 = (tbl1.iconPosition or IconPosition.Left) == IconPosition.Left
    local backgroundStyle = tbl1.isPositive
        and {
            Color3 = var1.Color.System.Success.Color3,
            Transparency = var1.Color.Shift.Shift_300.Transparency
        }
        or nil

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["row align-y-center gap-xxsmall auto-xy padding-y-xxsmall padding-left-xsmall padding-right-small radius-small"] = true,
            ["bg-shift-200"] = not tbl1.isPositive
        },
        backgroundStyle = backgroundStyle,
        testId = testId
    }, {
        Arrow = React.createElement(
            Icon,
            {
                LayoutOrder = 1,
                name = name,
                size = IconSize.XSmall,
                variant = IconVariant.Filled,
                style = style
            }
        ),
        Icon = if tbl1.icon then React.createElement(Icon, {
            LayoutOrder = if bool1 then 2 else 3,
            name = tbl1.icon,
            size = IconSize.XSmall,
            tag = "content-default",
            testId = `{testId}-icon`
        }) else nil,
        Value = React.createElement(FoundationText, {
            LayoutOrder = if bool1 then 3 else 2,
            Text = tbl1.text,
            tag = "auto-xy text-caption-small text-align-x-left content-default"
        })
    })
end

return GoalMetricDeltaPill
