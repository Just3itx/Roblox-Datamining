-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function convertSecondsToTimeFrames(num1: number)
    if num1 >= 86400 then
        return {
            value = math.ceil(num1 / 86400),
            unit = "days"
        }
    elseif num1 >= 3600 then
        return {
            value = math.ceil(num1 / 3600),
            unit = "hours"
        }
    end

    return {
        value = math.ceil(num1 / 60),
        unit = "minutes"
    }
end

local function getRemainingTimeFromExpiration(isoDate: string?, arg1)
    if not isoDate then
        return nil
    end

    local dateTime = DateTime.fromIsoDate(isoDate)
    if not dateTime then
        return nil
    end

    local var1 = arg1 or DateTime.now()
    local num1 = math.max(dateTime.UnixTimestamp - var1.UnixTimestamp, 0)

    if num1 <= 0 then
        return nil
    end

    return (convertSecondsToTimeFrames(num1))
end

return getRemainingTimeFromExpiration
