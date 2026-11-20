-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.App.Style.Constants)

local tbl1 = {}
local Family = Font.fromEnum(Enum.Font.Cartoon).Family
local ComicNeueFontFamily = Constants.ComicNeueFontFamily

local function getFaceKey(font): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `{font.Family}|{font.Weight.Value}|{font.Style.Value}`
end

for _, enumItem in Enum.Font:GetEnumItems() do
    if enumItem == Enum.Font.Unknown then
        continue
    end

    local success, result = pcall(Font.fromEnum, enumItem)
    if success then
        tbl1[getFaceKey(result)] = enumItem
    end
end

local function getBuilderSansFallback(weight)
    if weight.Value >= Enum.FontWeight.ExtraBold.Value then
        return Enum.Font.BuilderSansExtraBold
    end

    if weight.Value >= Enum.FontWeight.SemiBold.Value then
        return Enum.Font.BuilderSansBold
    end

    if weight.Value >= Enum.FontWeight.Medium.Value then
        return Enum.Font.BuilderSansMedium
    end

    return Enum.Font.BuilderSans
end

local function getComicNeueFallback(font): Enum.Font? -- Luacid: Inlined by compiler; 1 call site recovered
    return if font.Family == ComicNeueFontFamily or font.Family == Family then Enum.Font.Cartoon else nil
end

local function getLegacyFont(font)
    if typeof(font) == "EnumItem" then
        if font == Enum.Font.Unknown then
            return nil, false
        end
        return font, false
    end

    local var1 = tbl1[getFaceKey(font)]
    if var1 then
        return var1, false
    end

    local comicNeueFallback = getComicNeueFallback(font)

    if comicNeueFallback then
        return comicNeueFallback, true
    end

    return getBuilderSansFallback(font.Weight), true
end

return getLegacyFont
