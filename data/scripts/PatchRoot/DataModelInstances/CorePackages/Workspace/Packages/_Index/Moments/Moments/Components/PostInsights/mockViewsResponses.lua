-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local mockViewsDailyQuarterResponse = require(script.Parent.mockViewsDailyQuarterResponse)
local mockViewsDailyWeekResponse = require(script.Parent.mockViewsDailyWeekResponse)
local mockViewsHourlyResponse = require(script.Parent.mockViewsHourlyResponse)

return table.freeze({
    hourly = mockViewsHourlyResponse,
    dailyWeek = mockViewsDailyWeekResponse,
    dailyQuarter = mockViewsDailyQuarterResponse,
    all = table.freeze({ mockViewsHourlyResponse, mockViewsDailyWeekResponse, mockViewsDailyQuarterResponse })
})
