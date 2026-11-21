-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isLoggedOutUserId(str1: string?): boolean
    return str1 == nil or str1 == "" or str1 == "-1" or str1 == "0"
end

return isLoggedOutUserId
