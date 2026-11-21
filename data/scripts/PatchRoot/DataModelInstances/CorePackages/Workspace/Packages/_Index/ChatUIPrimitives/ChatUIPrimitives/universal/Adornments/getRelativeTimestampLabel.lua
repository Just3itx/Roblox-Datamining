-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    {
        limitMs = 3600000,
        unitMs = 60000,
        oneKey = "TimestampOneMinuteAbbreviated",
        pluralKey = "TimestampMinutesAbbreviatedPlural",
        argName = "num_minutes"
    },
    {
        limitMs = 86400000,
        unitMs = 3600000,
        oneKey = "TimestampOneHourAbbreviated",
        pluralKey = "TimestampHoursAbbreviatedPlural",
        argName = "num_hours"
    },
    {
        limitMs = 604800000,
        unitMs = 86400000,
        oneKey = "TimestampOneDayAbbreviated",
        pluralKey = "TimestampDaysAbbreviatedPlural",
        argName = "num_days"
    },
    {
        limitMs = 2592000000,
        unitMs = 604800000,
        oneKey = "TimestampOneWeekAbbreviated",
        pluralKey = "TimestampWeeksAbbreviatedPlural",
        argName = "num_weeks"
    }
}

local function getRelativeTimestampLabel(num1: number, num2: number, func1: (...any) -> (...any), func2: (...any) -> (...any))
    local num3 = math.max(num2 - num1, 0)

    if num3 < 60000 then
        return func1("Feature.Chat.Label.TimestampNow")
    end

    for _, value in tbl1 do
        if not (num3 < value.limitMs) then
            continue
        end

        local num4 = num3 // value.unitMs
        if num4 == 1 then
            return func1("Feature.Chat.Label." .. value.oneKey)
        end
        return func1("Feature.Chat.Label." .. value.pluralKey, { [value.argName] = num4 })
    end

    return func2(num1, num2)
end

return getRelativeTimestampLabel
