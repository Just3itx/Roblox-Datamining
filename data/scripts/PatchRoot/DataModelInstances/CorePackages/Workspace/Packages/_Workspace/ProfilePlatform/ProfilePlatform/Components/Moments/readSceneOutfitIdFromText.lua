-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readSceneOutfitIdFromText(str1: string): number?
    local var1 = tonumber((string.match(str1, "name=\"Name\">outfitId</string><int64 name=\"Value\">(%d+)</int64>")))
    return if type(var1) == "number" and not (var1 <= 0) and var1 % 1 == 0 then var1 else nil
end

return readSceneOutfitIdFromText
