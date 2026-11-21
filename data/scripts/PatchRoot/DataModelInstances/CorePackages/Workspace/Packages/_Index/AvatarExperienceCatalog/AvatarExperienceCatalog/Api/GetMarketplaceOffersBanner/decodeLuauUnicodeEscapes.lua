-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function decodeLuauUnicodeEscapes(str1: string)
    return (str1:gsub("\\u{(%x+)}", function(arg1): string
        local var1 = tonumber(arg1, 16)
        if var1 == nil or var1 < 0 or var1 > 1114111 then
            return ""
        end
        return utf8.char(var1)
    end))
end

return decodeLuauUnicodeEscapes
