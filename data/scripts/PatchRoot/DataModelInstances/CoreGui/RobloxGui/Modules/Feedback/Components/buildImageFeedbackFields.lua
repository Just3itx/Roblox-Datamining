-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseAsset(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == nil then
        return nil, ""
    end
    local var1 = string.match(str1, "rbxassetid://(%d+)")
    if var1 == nil then
        return nil, ""
    end
    return var1, string.match(str1, "version=(%d+)") or ""
end

return function(num1: number, str1: string?, str2: string?)
    local var1, var2 = parseAsset(str1)

    if var1 == nil then
        return nil
    end

    local var3, var4 = parseAsset(str2)
    local translation = if var3 == nil then "" else var3 .. "#" .. var4

    return {
        identifier = num1 .. "#" .. var1 .. "#" .. var2,
        source = var1 .. "#" .. var2,
        translation = translation
    }
end
