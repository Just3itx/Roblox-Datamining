-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatDate(dateTime, bool1: boolean?): string
    local dateTime2 = DateTime.now()

    local str1 = if dateTime:ToLocalTime().Year > dateTime2:ToLocalTime().Year then "ll" else "ddd, MMM DD"

    if bool1 then
        return ("%s at %s"):format(dateTime:FormatLocalTime(str1, "en-us"), dateTime:FormatLocalTime("LT", "en-us"))
    end
    return ("%s AT %s"):format(dateTime:FormatLocalTime(str1, "en-us"), dateTime:FormatLocalTime("LT", "en-us")):upper()
end

return formatDate
