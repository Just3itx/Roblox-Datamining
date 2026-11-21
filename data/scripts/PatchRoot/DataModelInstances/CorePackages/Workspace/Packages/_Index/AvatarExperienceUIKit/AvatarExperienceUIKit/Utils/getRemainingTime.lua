-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function convertSecondsToTimeFrames(secondsRemaining: number)
    if secondsRemaining >= 86400 then
        return {
            value = math.floor(secondsRemaining / 86400),
            unit = "days",
            secondsRemaining = secondsRemaining
        }
    end

    if secondsRemaining >= 3600 then
        return {
            value = math.floor(secondsRemaining / 3600),
            unit = "hours",
            secondsRemaining = secondsRemaining
        }
    end

    if not (secondsRemaining >= 60) then
        return {
            value = math.floor(secondsRemaining),
            unit = "seconds",
            secondsRemaining = secondsRemaining
        }
    end

    return {
        value = math.floor(secondsRemaining / 60),
        unit = "minutes",
        secondsRemaining = secondsRemaining
    }
end

local function getRemainingTime(isoDate: string?, arg1)
    if not isoDate then
        return nil
    end

    local dateTime = DateTime.fromIsoDate(isoDate)
    if not dateTime then
        return nil
    end

    local var1 = arg1 or DateTime.now()
    local secondsRemaining = dateTime.UnixTimestamp - var1.UnixTimestamp

    if not (secondsRemaining <= 0) then
        return (convertSecondsToTimeFrames(secondsRemaining))
    end

    return { value = -1, unit = "seconds", secondsRemaining = secondsRemaining }
end

return getRemainingTime
