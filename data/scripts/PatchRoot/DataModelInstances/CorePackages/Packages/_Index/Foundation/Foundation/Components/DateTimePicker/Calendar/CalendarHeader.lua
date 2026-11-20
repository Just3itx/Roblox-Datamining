-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = BuilderIcons.Icon

local _DateTimeCalendarViewUtilities = require(script.Parent.Parent.Utilities.DateTimeCalendarViewUtilities)
local DateTimeUtilities = require(script.Parent.Parent.DateTimeUtilities)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local Dropdown = require(Foundation.Components.Dropdown)
local IconButton = require(Foundation.Components.IconButton)
local InputSize = require(Foundation.Enums.InputSize)
local InputVariant = require(Foundation.Enums.InputVariant)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useScrollToSelectedRef = require(script.Parent.useScrollToSelectedRef)
local useTextSize = require(Foundation.Utility.useTextSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function CalendarHeader(tbl1)
    local viewDate = tbl1.viewDate
    local var1 = useTokens()

    local var2 = DateTimeUtilities.monthMap[viewDate.month]
    local str1 = tostring(viewDate.year)
    local var3 = useTextSize(var2, var1.Typography.BodySmall)
    local var4 = useTextSize(str1, var1.Typography.BodySmall)
    local var5 = useScaledValue(44)
    local maxHeight = useScaledValue(200)
    local offset = if var3 then math.ceil(var3.X) + var5 else 110
    local offset2 = if var4 then math.ceil(var4.X) + var5 else 70

    local items = React.useMemo(function()
        local result = {}
        for id, text in DateTimeUtilities.monthMap do
            table.insert(result, { id = id, text = text })
        end

        return result
    end, {})

    local var6 = React.useMemo(function()
        local year, year2

        if tbl1.selectableDateRange then
            local var8 = DateTimeUtilities.toLocalTime(tbl1.selectableDateRange.startDate)
            local var9 = DateTimeUtilities.toLocalTime(tbl1.selectableDateRange.endDate)
            year = var8.Year
            year2 = var9.Year
        else
            year = viewDate.year - 50
            year2 = viewDate.year + 50
        end

        local result = {}
        for id = year, year2 do
            table.insert(result, { id = id, text = tostring(id) })
        end

        return result
    end, { tbl1.selectableDateRange, viewDate.year })

    local onItemChanged = React.useCallback(function(arg1)
        local month = tonumber(arg1)
        if month then
            tbl1.onViewDateChanged({ month = month, year = viewDate.year })
        end
    end, { tbl1.onViewDateChanged, viewDate.year })

    local var7 = React.useCallback(function(arg1)
        local year = tonumber(arg1)
        if year then
            tbl1.onViewDateChanged({ month = viewDate.month, year = year })
        end
    end, { tbl1.onViewDateChanged, viewDate.month })

    local scrollingFrameRef = useScrollToSelectedRef(items, viewDate.month)
    local var8 = useScrollToSelectedRef(var6, viewDate.year)

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row align-y-center gap-small size-full-0 auto-y padding-y-small"
        },
        {
            PreviousMonthButton = React.createElement(IconButton, {
                icon = Icon.ChevronSmallLeft,
                LayoutOrder = 1,
                onActivated = tbl1.onPreviousMonth,
                size = InputSize.Small,
                testId = `{tbl1.testId}--previous-month-button`,
                variant = ButtonVariant.Utility
            }),
            MonthYearDropdowns = React.createElement(
                View,
                { LayoutOrder = 2, tag = "row align-x-center align-y-center grow gap-small auto-y" },
                {
                    MonthDropdown = React.createElement(Dropdown.Root, {
                        items = items,
                        label = "",
                        LayoutOrder = 1,
                        maxHeight = maxHeight,
                        onItemChanged = onItemChanged,
                        scrollingFrameRef = scrollingFrameRef,
                        size = InputSize.XSmall,
                        testId = `{tbl1.testId}--month-dropdown`,
                        value = viewDate.month,
                        variant = InputVariant.Utility,
                        width = UDim.new(0, offset)
                    }),
                    YearDropdown = React.createElement(Dropdown.Root, {
                        items = var6,
                        label = "",
                        LayoutOrder = 2,
                        maxHeight = maxHeight,
                        onItemChanged = var7,
                        scrollingFrameRef = var8,
                        size = InputSize.XSmall,
                        testId = `{tbl1.testId}--year-dropdown`,
                        value = viewDate.year,
                        variant = InputVariant.Utility,
                        width = UDim.new(0, offset2)
                    })
                }
            ),
            NextMonthButton = React.createElement(IconButton, {
                icon = Icon.ChevronSmallRight,
                LayoutOrder = 3,
                onActivated = tbl1.onNextMonth,
                size = InputSize.Small,
                testId = `{tbl1.testId}--next-month-button`,
                variant = ButtonVariant.Utility
            })
        }
    )
end
return CalendarHeader
