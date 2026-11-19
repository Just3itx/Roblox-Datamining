-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function getAssetIdAsNumeric(arg1): number
    if typeof(arg1) == "number" then
        return arg1
    end

    return tonumber(arg1:match("(%d+)$")) or -1
end

return getAssetIdAsNumeric
