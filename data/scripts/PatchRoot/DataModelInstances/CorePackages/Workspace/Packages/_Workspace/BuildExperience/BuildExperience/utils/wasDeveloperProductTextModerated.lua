-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function wasDeveloperProductTextModerated(str1: string?, str2: string?): boolean
    return not (str1 == nil) and (str2 or "") ~= str1
end

return wasDeveloperProductTextModerated
