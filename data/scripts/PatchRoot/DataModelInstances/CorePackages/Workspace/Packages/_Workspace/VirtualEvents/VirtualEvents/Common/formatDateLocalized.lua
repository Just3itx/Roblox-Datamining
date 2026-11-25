-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local function formatDate(str1: string, dateTime)
    local dateTime2 = DateTime.now()
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    return str1:gsub(
        "{date}",
        dateTime:FormatLocalTime(
            if dateTime:ToLocalTime().Year > dateTime2:ToLocalTime().Year then "ll" else "ddd, MMM DD",
            robloxLocaleId
        )
    ):gsub(
        "{time}",
        dateTime:FormatLocalTime("LT", robloxLocaleId)
    )
end
return formatDate
