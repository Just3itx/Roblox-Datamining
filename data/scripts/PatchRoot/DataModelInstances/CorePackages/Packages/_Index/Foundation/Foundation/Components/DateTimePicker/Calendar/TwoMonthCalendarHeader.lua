-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = BuilderIcons.Icon

local _DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local IconButton = require(Foundation.Components.IconButton)
local InputSize = require(Foundation.Enums.InputSize)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local function TwoMonthCalendarHeader(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = 1,
            tag = "row align-y-center gap-small size-full-0 auto-y padding-x-large padding-y-medium"
        },
        {
            PreviousMonthButton = React.createElement(IconButton, {
                icon = Icon.ChevronSmallLeft,
                isCircular = false,
                LayoutOrder = 1,
                onActivated = tbl1.onPreviousMonth,
                size = InputSize.Small,
                testId = `{tbl1.testId}--previous-month-button`,
                variant = ButtonVariant.Utility
            }),
            FirstMonthLabel = React.createElement(Text, {
                LayoutOrder = 2,
                tag = "grow auto-y text-title-small text-align-x-center",
                testId = `{tbl1.testId}--first-month-label`,
                Text = `{DateTimeUtilities.monthMap[tbl1.currViewDate.month]} {tbl1.currViewDate.year}`
            }),
            SecondMonthLabel = React.createElement(Text, {
                LayoutOrder = 3,
                tag = "grow auto-y text-title-small text-align-x-center",
                testId = `{tbl1.testId}--second-month-label`,
                Text = `{DateTimeUtilities.monthMap[tbl1.secondMonth]} {tbl1.secondYear}`
            }),
            NextMonthButton = React.createElement(IconButton, {
                icon = Icon.ChevronSmallRight,
                isCircular = false,
                LayoutOrder = 4,
                onActivated = tbl1.onNextMonth,
                size = InputSize.Small,
                testId = `{tbl1.testId}--next-month-button`,
                variant = ButtonVariant.Utility
            })
        }
    )
end
return TwoMonthCalendarHeader
