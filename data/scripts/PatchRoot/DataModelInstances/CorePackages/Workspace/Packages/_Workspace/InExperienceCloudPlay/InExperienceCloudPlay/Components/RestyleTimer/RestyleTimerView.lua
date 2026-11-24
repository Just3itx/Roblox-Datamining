-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlayParent = script:FindFirstAncestor("InExperienceCloudPlay").Parent

local Foundation = require(InExperienceCloudPlayParent.Foundation)
local React = require(InExperienceCloudPlayParent.React)

local InputSize = Foundation.Enums.InputSize
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local FoundationText = Foundation.Text
local Toggle = Foundation.Toggle
local View = Foundation.View
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens

local function RestyleTimerView(tbl1)
    local var1 = useTokens()
    local xOffset = useScaledValue(233)

    local createElement = React.createElement
    local root = Popover.Root
    local tbl2 = {
        isOpen = tbl1.isPopoverOpen,
        testId = "restyle-timer-popover"
    }
    local tbl3 = { Anchor = 0, Content = 0 }
    local createElement2 = React.createElement
    local anchor = Popover.Anchor
    local tbl4 = {
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl5 = { Chip = 0 }
    local createElement3 = React.createElement
    local var2 = View
    local tbl6 = {
        tag = "row align-y-center gap-xsmall auto-x padding-x-medium radius-circle bg-over-media-0",
        Size = UDim2.fromOffset(0, tbl1.buttonSize),
        onActivated = tbl1.onChipActivated,
        onAbsoluteSizeChanged = tbl1.onAreaChanged,
        onAbsolutePositionChanged = tbl1.onAreaChanged,
        testId = "restyle-timer"
    }
    local tbl7 = {
        Label = React.createElement(
            FoundationText,
            { tag = "auto-xy text-label-small content-emphasis", Text = "Restyle", LayoutOrder = 1 }
        ),
        TimeLeft = 0
    }
    local element

    if tbl1.timeLeft then
        element = React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, {
            Sizer = React.createElement(FoundationText, {
                tag = "auto-xy text-label-small",
                Text = string.gsub(tbl1.timeLeft, "%d", "0"),
                textStyle = {
                    Color3 = var1.Color.Content.Muted.Color3,
                    Transparency = 1
                },
                testId = "restyle-timer--time-sizer"
            }),
            Value = React.createElement(FoundationText, {
                tag = "size-full text-label-small text-align-x-right content-muted",
                Text = tbl1.timeLeft,
                testId = "restyle-timer--time"
            })
        })
    else
        element = nil
    end

    tbl7.TimeLeft = element
    tbl5.Chip = createElement3(var2, tbl6, tbl7)
    tbl3.Anchor = createElement2(anchor, tbl4, tbl5)

    local createElement4 = React.createElement
    local content = Popover.Content
    local tbl8 = {
        side = {
            position = PopoverSide.Bottom,
            offset = var1.Size.Size_300
        },
        align = PopoverAlign.Start,
        hasArrow = false,
        backgroundStyle = var1.Color.Surface.Surface_200,
        onPressedOutside = tbl1.onPopoverClosed
    }
    local tbl9 = { Body = 0 }
    local createElement5 = React.createElement
    local var3 = View
    local tbl10 = {
        tag = "col gap-small auto-y padding-medium stroke-standard stroke-default radius-medium",
        Size = UDim2.fromOffset(xOffset, 0)
    }
    local tbl11 = {
        Description = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-caption-small text-wrap text-align-x-left content-muted",
            Text = "Restyle is an early preview. Things may look different from the original game.",
            LayoutOrder = 1
        }),
        TimeLeft = 0,
        Restyle = 0
    }
    local element2

    if tbl1.timeLeft then
        element2 = React.createElement(View, {
            tag = "row flex-x-between align-y-center size-full-0 auto-y padding-medium radius-medium bg-shift-100",
            LayoutOrder = 2
        }, {
            Label = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-label-small content-default",
                    Text = "Time left",
                    LayoutOrder = 1
                }
            ),
            Value = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-label-medium content-default",
                    Text = tbl1.timeLeft,
                    LayoutOrder = 2
                }
            )
        })
    else
        element2 = nil
    end

    tbl11.TimeLeft = element2

    tbl11.Restyle = React.createElement(View, {
        tag = "row flex-x-between align-y-center size-full-0 auto-y padding-medium radius-medium bg-shift-100",
        LayoutOrder = 3
    }, {
        Label = React.createElement(
            FoundationText,
            { tag = "auto-xy text-label-small content-default", Text = "Restyle", LayoutOrder = 1 }
        ),
        Toggle = React.createElement(Toggle, {
            label = "",
            size = InputSize.XSmall,
            isChecked = tbl1.isRestyleEnabled,
            onActivated = tbl1.onRestyleToggled,
            LayoutOrder = 2,
            testId = "restyle-timer-toggle"
        })
    })
    tbl9.Body = createElement5(var3, tbl10, tbl11)
    tbl3.Content = createElement4(content, tbl8, tbl9)
    return createElement(root, tbl2, tbl3)
end

return RestyleTimerView
