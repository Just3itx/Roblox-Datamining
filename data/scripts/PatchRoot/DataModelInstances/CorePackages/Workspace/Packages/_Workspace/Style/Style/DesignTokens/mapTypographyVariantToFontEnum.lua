-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    Black = Enum.Font.GothamBlack,
    Bold = Enum.Font.GothamBold,
    Medium = Enum.Font.GothamMedium,
    Book = Enum.Font.Gotham
}

local function mapTypographyVariantToFontEnum(tbl2)
    if tbl2.Font then
        return tbl2.Font
    end

    if tbl2.FontWeight then
        return tbl1[tbl2.FontWeight] or tbl1.Book
    end

    return tbl1.Book
end

return mapTypographyVariantToFontEnum
