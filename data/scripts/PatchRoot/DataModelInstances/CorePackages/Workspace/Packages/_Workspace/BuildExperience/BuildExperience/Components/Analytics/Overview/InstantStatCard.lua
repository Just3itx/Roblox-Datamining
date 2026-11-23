-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function InstantStatCard(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "InstantStatCard"
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-none size-full-0 auto-y",
        testId = testId
    }
    local tbl3 = {
        Label = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.label,
            tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end content-default",
            testId = `{testId}-label`
        }),
        Value = 0
    }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = 2,
        tag = "row align-y-center gap-xsmall auto-xy padding-y-xxsmall"
    }

    local tbl5 = {
        Icon = React.createElement(Icon, {
            LayoutOrder = 1,
            name = tbl1.icon,
            size = IconSize.Large,
            tag = "content-emphasis",
            testId = `{testId}-icon`
        }),
        Number = 0
    }
    local element

    if tbl1.isLoading then
        element = React.createElement(Skeleton, {
            LayoutOrder = 2,
            Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_500),
            radius = Radius.Small,
            testId = `{testId}-loading`
        })
    else
        element = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.valueText,
            tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
            testId = `{testId}-value`
        })
    end

    tbl5.Number = element
    tbl3.Value = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end

return InstantStatCard
