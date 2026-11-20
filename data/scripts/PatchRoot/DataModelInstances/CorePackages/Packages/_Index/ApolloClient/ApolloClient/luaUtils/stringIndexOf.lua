-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.stringIndexOf(str1: string, str2: string)
    local var1, _ = string.find(str1, str2)

    return if var1 == nil then -1 else var1
end
return module
