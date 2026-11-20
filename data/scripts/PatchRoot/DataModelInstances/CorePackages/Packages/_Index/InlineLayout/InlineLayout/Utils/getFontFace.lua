-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFontFace(tbl1)
    local font = tbl1 and tbl1.Font
    if typeof(font) == "EnumItem" and font:IsA("Font") then
        return Font.fromEnum(font)
    end
    return font
end

return getFontFace
