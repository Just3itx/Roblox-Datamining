-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("DevConsoleFixTimestampDST", false)

local function numberWithZero(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (if arg1 < 10 then "0" else "") .. arg1
end

local function convertTimeStamp(arg1): string
    local hour, min, sec

    if bool1 then
        local var1 = os.date("*t", arg1)
        hour = var1.hour
        min = var1.min
        sec = var1.sec
    else
        local num1 = math.floor(arg1 - os.time() + tick()) % 86400

        hour = math.floor(num1 / 3600)
        local num2 = num1 - hour * 3600
        min = math.floor(num2 / 60)
        sec = num2 - min * 60
    end

    local var1 = numberWithZero(hour)
    local var2 = numberWithZero(min)
    local var3 = numberWithZero(sec)
    return string.format("%s:%s:%s", var1, var2, var3)
end

return convertTimeStamp
