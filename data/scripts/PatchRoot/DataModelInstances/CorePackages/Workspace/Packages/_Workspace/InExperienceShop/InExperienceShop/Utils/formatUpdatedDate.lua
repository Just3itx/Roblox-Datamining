-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local function formatUpdatedDate(isoDate: string?)
    if isoDate == nil or isoDate == "" then
        return nil
    end

    local dateTime = DateTime.fromIsoDate(isoDate)
    if dateTime == nil then
        return isoDate
    end

    return dateTime:FormatLocalTime("ll", LocalizationService.RobloxLocaleId)
end

return formatUpdatedDate
