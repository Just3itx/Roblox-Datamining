-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Divider = Foundation.Divider
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local function PriceLine(tbl1)
    local line = tbl1.line
    local tag = if tbl1.isTotal then "fill auto-y text-title-small text-align-x-left content-emphasis" else "fill auto-y text-body-small text-align-x-left content-emphasis"

    local str1 = if tbl1.isTotal then "auto-xy text-title-small content-emphasis" else "auto-xy text-body-small content-emphasis"

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "row align-y-center size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        Label = React.createElement(FoundationText, { tag = tag, Text = line.label, LayoutOrder = 1 }),
        Amount = React.createElement(View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            LayoutOrder = 2
        }, {
            Prefix = if line.amountPrefix then React.createElement(FoundationText, { tag = str1, Text = line.amountPrefix, LayoutOrder = 1 }) else nil,
            RobuxIcon = React.createElement(Icon, { name = IconName.Robux, size = IconSize.XSmall, LayoutOrder = 2 }),
            Value = React.createElement(FoundationText, { tag = str1, Text = line.amountText, LayoutOrder = 3 })
        })
    }
    return createElement(var1, tbl2, tbl3)
end

return React.memo(function(tbl1) -- name: GiftRobuxBreakdownView
    local tbl2 = ({})
    for k, line in tbl1.discounts do
        local str1 = `Discount-{k}`
        tbl2[str1] = React.createElement(PriceLine, { line = line, LayoutOrder = k + 1 })
    end

    local createElement = React.createElement
    local var1 = View
    local tbl3 = {
        tag = "col size-full-0 auto-y stroke-default radius-medium clip",
        testId = "GiftRobuxBreakdownView"
    }

    local tbl4 = {
        Header = React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y padding-x-medium padding-y-small radius-medium",
            onActivated = tbl1.onToggle,
            stateLayer = {
                affordance = StateLayerAffordance.Background
            },
            testId = "gift-robux-breakdown-toggle",
            LayoutOrder = 1
        }, {
            PlusIcon = React.createElement(Icon, { name = IconName.RobloxPlus, size = IconSize.Medium, LayoutOrder = 1 }),
            Summary = React.createElement(View, {
                tag = "row align-y-center fill gap-xxsmall auto-y",
                LayoutOrder = 2
            }, {
                Leading = React.createElement(FoundationText, {
                    tag = "auto-xy text-body-medium text-align-x-left content-emphasis",
                    Text = tbl1.summaryLeadingText,
                    testId = "gift-robux-breakdown-summary-leading",
                    LayoutOrder = 1
                }),
                Amount = React.createElement(View, {
                    tag = "row align-y-center gap-xxsmall auto-xy",
                    LayoutOrder = 2
                }, {
                    RobuxIcon = React.createElement(Icon, { name = IconName.Robux, size = IconSize.Small, LayoutOrder = 1 }),
                    Value = React.createElement(FoundationText, {
                        tag = "auto-xy text-title-medium text-no-wrap content-emphasis",
                        Text = tbl1.summaryAmountText,
                        testId = "gift-robux-breakdown-summary-amount",
                        LayoutOrder = 2
                    })
                }),
                Trailing = React.createElement(FoundationText, {
                    tag = "auto-xy text-body-medium text-align-x-left content-emphasis",
                    Text = tbl1.summaryTrailingText,
                    testId = "gift-robux-breakdown-summary-trailing",
                    LayoutOrder = 3
                })
            }),
            Chevron = React.createElement(Icon, {
                name = IconName.ChevronLargeDown,
                size = IconSize.Medium,
                Rotation = if tbl1.isExpanded then 180 else 0,
                testId = "gift-robux-breakdown-chevron",
                LayoutOrder = 3
            })
        }),
        Content = 0
    }
    local element

    if tbl1.isExpanded then
        element = React.createElement(View, {
            tag = "col gap-small size-full-0 auto-y padding-x-medium padding-bottom-medium padding-top-xsmall",
            testId = "gift-robux-breakdown-content",
            LayoutOrder = 2
        }, {
            Rows = React.createElement(View, {
                tag = "col gap-xxsmall size-full-0 auto-y",
                LayoutOrder = 1
            }, {
                Subtotal = React.createElement(PriceLine, { line = tbl1.subtotal, LayoutOrder = 1 }),
                Discounts = React.createElement(View, { tag = "col gap-xxsmall size-full-0 auto-y", LayoutOrder = 2 }, tbl2)
            }),
            Divider = React.createElement(Divider, { LayoutOrder = 2 }),
            Total = React.createElement(PriceLine, { line = tbl1.total, isTotal = true, LayoutOrder = 3 })
        })
    else
        element = nil
    end

    tbl4.Content = element
    return createElement(var1, tbl3, tbl4)
end)
