-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local function formatTimeoutEndTime(isoDate: string?, str1: string?)
    if not isoDate or isoDate == "" then
        return nil
    end

    local success, result = pcall(function(): DateTime
        return DateTime.fromIsoDate(isoDate)
    end)

    if not (success and result) then
        return nil
    end

    return result:FormatLocalTime(str1 or "M/D, LT", LocalizationService.RobloxLocaleId)
end

return formatTimeoutEndTime
