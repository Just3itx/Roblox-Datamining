-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getTextLengthIfValidUtf8(str1: string)
    if utf8.len(str1) == nil then
        return nil
    end
    return utf8.len(utf8.nfcnormalize(str1))
end

return getTextLengthIfValidUtf8
