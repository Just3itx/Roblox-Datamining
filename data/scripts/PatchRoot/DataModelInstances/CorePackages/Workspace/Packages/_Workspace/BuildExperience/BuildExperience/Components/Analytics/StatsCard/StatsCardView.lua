-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconPosition = Foundation.Enums.IconPosition
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local Radius = Foundation.Enums.Radius

local function StatsCardView(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "StatsCardView"
    local style = if tbl1.isDeltaPositive then var1.Color.System.Success else var1.Color.Content.Default
    local name = if tbl1.isDeltaPositive then IconName.ArrowWideShortUp else IconName.ArrowWideShortDown
    local bool1 = (tbl1.statIconPosition or IconPosition.Left) == IconPosition.Left
    local bool2 = (tbl1.deltaIconPosition or IconPosition.Left) == IconPosition.Left

    local backgroundStyle = tbl1.isDeltaPositive
        and {
            Color3 = var1.Color.System.Success.Color3,
            Transparency = var1.Color.Shift.Shift_300.Transparency
        }
        or nil

    local bool3 = tbl1.isSelected == true
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["col gap-xsmall size-full-0 auto-y padding-large stroke-standard radius-large clip"] = true,
            ["stroke-emphasis bg-surface-100"] = bool3,
            ["stroke-default"] = not bool3
        },
        testId = testId,
        onActivated = tbl1.onActivated
    }
    local tbl3 = {
        Header = React.createElement(View, { LayoutOrder = 1, tag = "row size-full-0 auto-y" }, {
            Title = React.createElement(FoundationText, {
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end content-default",
                testId = `{testId}-title`
            })
        }),
        StatRow = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { LayoutOrder = 2, tag = "row align-y-center gap-small size-full-0 auto-y" }
    local tbl5

    if tbl1.isLoading then
        tbl5 = {
            Loading = React.createElement(Skeleton, {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, var1.Size.Size_500),
                radius = Radius.Small,
                testId = `{testId}-loading`
            })
        }
    else
        tbl5 = { Stat = 0, Delta = 0 }
        local createElement3 = React.createElement
        local var7 = View
        local tbl6 = { LayoutOrder = 1, tag = "row align-y-center gap-xsmall auto-xy" }

        local tbl7 = {
            Icon = if tbl1.statIcon then React.createElement(Icon, {
                LayoutOrder = if bool1 then 1 else 2,
                name = tbl1.statIcon,
                size = IconSize.Small,
                tag = "content-emphasis",
                testId = `{testId}-stat-icon`
            }) else nil,
            Value = React.createElement(FoundationText, {
                LayoutOrder = if bool1 then 2 else 1,
                Text = tbl1.statText,
                tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
                testId = `{testId}-stat`
            })
        }
        tbl5.Stat = createElement3(var7, tbl6, tbl7)
        local element

        if tbl1.deltaText == nil then
            element = nil
        else
            element = React.createElement(View, {
                LayoutOrder = 2,
                tag = {
                    ["row align-y-center gap-xxsmall auto-xy padding-y-xxsmall padding-left-xsmall padding-right-small radius-small"] = true,
                    ["bg-shift-200"] = not tbl1.isDeltaPositive
                },
                backgroundStyle = backgroundStyle,
                testId = `{testId}-delta`
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
                Icon = if tbl1.deltaIcon then React.createElement(Icon, {
                    LayoutOrder = if bool2 then 2 else 3,
                    name = tbl1.deltaIcon,
                    size = IconSize.XSmall,
                    tag = "content-default",
                    testId = `{testId}-delta-icon`
                }) else nil,
                Value = React.createElement(FoundationText, {
                    LayoutOrder = if bool2 then 3 else 2,
                    Text = tbl1.deltaText,
                    tag = "auto-xy text-caption-small text-align-x-left content-default"
                })
            })
        end

        tbl5.Delta = element
    end

    tbl3.StatRow = createElement2(var6, tbl4, tbl5)
    return createElement(var5, tbl2, tbl3)
end

return StatsCardView
