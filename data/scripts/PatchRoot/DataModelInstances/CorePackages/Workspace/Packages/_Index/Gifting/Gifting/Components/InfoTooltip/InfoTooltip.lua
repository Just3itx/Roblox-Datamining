-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Coachmark = Foundation.Coachmark
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

return React.memo(function(tbl1) -- name: InfoTooltip
    local isOpen, var2 = React.useState(false)
    local var3 = React.useRef(nil)

    local onPressedOutside = React.useCallback(function()
        var2(false)
    end, {})

    local onActivated = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    return React.createElement(
        View,
        {
            tag = "row align-y-center gap-none auto-xy padding-y-xxsmall",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            Label = React.createElement(FoundationText, {
                tag = "auto-xy text-caption-small text-no-wrap content-default",
                Text = tbl1.text,
                testId = `{tbl1.testId}-note`,
                LayoutOrder = 1
            }),
            Info = React.createElement(IconButton, {
                icon = IconName.CircleI,
                size = InputSize.XSmall,
                onActivated = onActivated,
                ref = var3,
                testId = `{tbl1.testId}-info`,
                LayoutOrder = 2
            }),
            Tooltip = React.createElement(Coachmark, {
                title = tbl1.tooltipTitle or "",
                text = tbl1.tooltipText,
                isOpen = isOpen,
                anchorRef = var3,
                onPressedOutside = onPressedOutside,
                side = PopoverSide.Top,
                align = PopoverAlign.Center,
                testId = `{tbl1.testId}-tooltip`
            })
        }
    )
end)
