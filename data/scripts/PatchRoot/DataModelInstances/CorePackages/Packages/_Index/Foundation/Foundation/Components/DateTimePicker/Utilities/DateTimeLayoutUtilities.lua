-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DateTimeCalendarConstants = require(script.Parent.DateTimeCalendarConstants)
local _Tokens = require(Foundation.Providers.Style.Tokens)

local DAYS_PER_WEEK = DateTimeCalendarConstants.DAYS_PER_WEEK

return {
    CALENDAR_WIDTH = 272,
    PANE_WIDTH = 280,
    TIME_LIST_WIDTH = 132,
    computeSingleWithTimeLayout = function(num1: number, num2: number, arg1, num3: number)
        local large = arg1.Padding.Large
        local gridHeight = num3 * (num1 / DAYS_PER_WEEK)
        local var2 = arg1.Size.Size_800 + 2 * arg1.Padding.Small
        local bodyHeight = 2 * large + var2 + arg1.Gap.Small + gridHeight

        local calendarColumnWidth = num1 + 2 * large
        local timeListColumnWidth = num2 + 2 * large

        return {
            bodyHeight = bodyHeight,
            calendarColumnWidth = calendarColumnWidth,
            contentWidth = calendarColumnWidth + arg1.Stroke.Standard + timeListColumnWidth,
            gridHeight = gridHeight,
            timeListColumnWidth = timeListColumnWidth,
            timeListHeight = bodyHeight - 2 * large
        }
    end
}
