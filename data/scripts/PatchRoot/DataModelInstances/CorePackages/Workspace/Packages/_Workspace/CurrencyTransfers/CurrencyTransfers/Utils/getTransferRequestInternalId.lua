-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getTransferRequestInternalId(str1: string?): string
    if str1 == nil or str1 == "" then
        return ""
    elseif #str1 >= 4 and string.lower(string.sub(str1, 1, 4)) == "rxt-" then
        return string.sub(str1, 5)
    end

    return str1
end

return getTransferRequestInternalId
