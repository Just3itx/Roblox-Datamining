-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getTimeoutEndTime(str1: string?, str2: string?): string?
    local var1 = str1 or str2
    return if var1 == "" then nil else var1
end

return getTimeoutEndTime
