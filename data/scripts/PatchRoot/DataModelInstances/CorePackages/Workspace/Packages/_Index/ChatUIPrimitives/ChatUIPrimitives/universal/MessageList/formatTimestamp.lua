-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatTimestamp(unixTimestampMillis: number, num1: number?, str1: string?): string
    local num2 = math.abs(unixTimestampMillis - (num1 or DateTime.now().UnixTimestampMillis))

    local format = "LT"
    if num2 >= 31536000000 then
        format = "MMM D, YYYY, LT"
    elseif num2 >= 432000000 then
        format = "MMM D, LT"
    elseif num2 >= 86400000 then
        format = "dddd LT"
    end

    return DateTime.fromUnixTimestampMillis(unixTimestampMillis):FormatLocalTime(format, str1 or "en-us")
end

return formatTimestamp
