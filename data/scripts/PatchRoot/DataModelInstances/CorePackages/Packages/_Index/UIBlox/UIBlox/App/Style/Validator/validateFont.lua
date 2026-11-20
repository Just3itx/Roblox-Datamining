-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local t = require(scriptParentParentParentParentParent.t)

local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)

local var1 = t.strictInterface({
    BaseSize = t.numberMinExclusive(0),
    Title = validateFontInfo,
    Header1 = validateFontInfo,
    Header2 = validateFontInfo,
    SubHeader1 = validateFontInfo,
    Body = validateFontInfo,
    CaptionHeader = validateFontInfo,
    CaptionSubHeader = validateFontInfo,
    CaptionBody = validateFontInfo,
    Footer = validateFontInfo
})

local var2 = t.strictInterface({
    BaseSize = t.numberMinExclusive(0),
    Title = validateFontInfo,
    Header1 = validateFontInfo,
    Header2 = validateFontInfo,
    SubHeader1 = validateFontInfo,
    Body = validateFontInfo,
    CaptionHeader = validateFontInfo,
    CaptionSubHeader = validateFontInfo,
    CaptionBody = validateFontInfo,
    Footer = validateFontInfo,
    HeadingLarge = validateFontInfo,
    HeadingSmall = validateFontInfo,
    TitleLarge = validateFontInfo,
    BodyLarge = validateFontInfo,
    CaptionLarge = validateFontInfo,
    BodySmall = validateFontInfo,
    CaptionSmall = validateFontInfo
})

return t.union(var1, var2)
