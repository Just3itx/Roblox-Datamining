-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAssetIdAsNumeric(arg1): number
    if typeof(arg1) == "number" then
        return arg1
    end

    return tonumber(arg1:match("(%d+)$")) or -1
end

return getAssetIdAsNumeric
