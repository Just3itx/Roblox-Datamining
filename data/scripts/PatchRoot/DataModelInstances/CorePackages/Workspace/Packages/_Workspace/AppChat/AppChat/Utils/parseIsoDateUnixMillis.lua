-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseIsoDateUnixMillis(str1: string?)
    if str1 == nil then
        return nil
    end
    local success, result = pcall(DateTime.fromIsoDate, str1)
    return if success and result ~= nil then result.UnixTimestampMillis else nil
end

return parseIsoDateUnixMillis
