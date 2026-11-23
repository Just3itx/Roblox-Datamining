-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeScreenSizeForWire(str1: string): string
    if #str1 == 0 then
        return str1
    end

    return string.lower(string.sub(str1, 1, 1)) .. string.sub(str1, 2)
end

return normalizeScreenSizeForWire
