-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

return {
    snakeToCamel = function(str1: string)
        return str1:gsub("_(%l)", function(arg1)
            return arg1:upper()
        end)
    end,
    protobufTimestampToLocalTimeString = function(tbl1)
        if tbl1 == nil then
            return nil
        elseif tbl1.seconds then
            return DateTime.fromUnixTimestamp(tbl1.seconds):FormatLocalTime("ll", LocalizationService.RobloxLocaleId)
        end

        return tostring(tbl1)
    end
}
