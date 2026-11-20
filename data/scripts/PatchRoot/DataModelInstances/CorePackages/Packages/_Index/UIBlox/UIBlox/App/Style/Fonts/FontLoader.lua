-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParent.Parent.Parent.Parent
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace
local Constants = require(scriptParentParent.Constants)
local _StyleTypes = require(scriptParentParent.StyleTypes)

local function getOverrideFontFace(font, fontFace): Font -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(font) == "Font" then
        return font
    elseif font == Enum.Font.Cartoon then
        return Font.new(Constants.ComicNeueFontFamily, fontFace.Weight, fontFace.Style)
    end
    return Font.fromEnum(font)
end

local module = {}
module.__index = module

function module.new(_tokens)
    local tbl1 = { _tokens = _tokens }

    setmetatable(tbl1, module)
    return tbl1
end

function module:loadFont(font)
    local _tokens = self._tokens

    local tbl1 = {
        BaseSize = 20.16,
        HeadingLarge = {
            Font = Enum.Font.BuilderSansBold,
            FontFace = normalizeFontFace(_tokens.Typography.HeadingLarge.Font),
            RelativeSize = _tokens.Size.Size_700 / 16,
            RelativeMinSize = _tokens.Size.Size_600 / 16
        },
        HeadingSmall = {
            Font = Enum.Font.BuilderSansBold,
            FontFace = normalizeFontFace(_tokens.Typography.HeadingSmall.Font),
            RelativeSize = _tokens.Size.Size_500 / 16,
            RelativeMinSize = _tokens.Size.Size_400 / 16
        },
        TitleLarge = {
            Font = Enum.Font.BuilderSansBold,
            FontFace = normalizeFontFace(_tokens.Typography.TitleLarge.Font),
            RelativeSize = _tokens.Size.Size_400 / 16,
            RelativeMinSize = _tokens.Size.Size_300 / 16
        },
        BodyLarge = {
            Font = Enum.Font.BuilderSans,
            FontFace = normalizeFontFace(_tokens.Typography.BodyLarge.Font),
            RelativeSize = _tokens.Size.Size_400 / 16,
            RelativeMinSize = _tokens.Size.Size_300 / 16
        },
        CaptionLarge = {
            Font = Enum.Font.BuilderSansMedium,
            FontFace = normalizeFontFace(_tokens.Typography.CaptionLarge.Font),
            RelativeSize = _tokens.Size.Size_300 / 16,
            RelativeMinSize = _tokens.Size.Size_200 / 16
        },
        BodySmall = {
            Font = Enum.Font.BuilderSans,
            FontFace = normalizeFontFace(_tokens.Typography.BodySmall.Font),
            RelativeSize = _tokens.Size.Size_300 / 16,
            RelativeMinSize = _tokens.Size.Size_200 / 16
        },
        CaptionSmall = {
            Font = Enum.Font.BuilderSansMedium,
            FontFace = normalizeFontFace(_tokens.Typography.CaptionSmall.Font),
            RelativeSize = _tokens.Size.Size_250 / 16,
            RelativeMinSize = _tokens.Size.Size_200 / 16
        }
    }

    if font ~= nil then
        for _, value in tbl1 do
            if type(value) == "table" and value.Font ~= nil then
                value.Font = font
                value.FontFace = getOverrideFontFace(font, value.FontFace)
            end
        end
    end

    local var1 = self:mapLegacyFont(tbl1, 16)
    return Cryo.Dictionary.join(var1, tbl1)
end

function module:mapLegacyFont(arg1, _)
    return {
        Title = arg1.HeadingLarge,
        Header1 = arg1.HeadingSmall,
        Header2 = arg1.TitleLarge,
        SubHeader1 = arg1.TitleLarge,
        Body = arg1.BodyLarge,
        CaptionHeader = arg1.CaptionLarge,
        CaptionSubHeader = arg1.CaptionLarge,
        CaptionBody = arg1.BodySmall,
        Footer = arg1.CaptionSmall
    }
end

return module
