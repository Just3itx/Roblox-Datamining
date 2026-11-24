-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isCanonicalNonzeroUuid(arg1): boolean
    return type(arg1) == "string"
        and arg1 ~= "00000000-0000-0000-0000-000000000000"
        and arg1 == string.lower(arg1)
        and string.match(arg1, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
end

return isCanonicalNonzeroUuid
