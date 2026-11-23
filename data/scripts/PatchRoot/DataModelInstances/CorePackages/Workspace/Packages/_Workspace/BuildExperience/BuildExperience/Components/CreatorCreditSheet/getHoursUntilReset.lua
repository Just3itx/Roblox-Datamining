-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getHoursUntilReset(isoDate: string, num1: number?)
    local dateTime = DateTime.fromIsoDate(isoDate)
    if dateTime == nil then
        return nil
    end
    local num2 = num1 or DateTime.now().UnixTimestamp
    return math.max(0, math.ceil((dateTime.UnixTimestamp - num2) / 3600))
end

return getHoursUntilReset
