-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local Cryo = InGameMenuDependencies.Cryo
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local t = InGameMenuDependencies.t

local withStyle = UIBlox.Core.Style.withStyle
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local scriptParentParentParent = script.Parent.Parent.Parent
local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local tbl1 = {
    Title = "HeadingLarge",
    Header1 = "HeadingSmall",
    Header2 = "TitleLarge",
    SubHeader1 = "TitleLarge",
    Body = "BodyLarge",
    CaptionHeader = "CaptionMedium",
    CaptionSubHeader = "CaptionMedium",
    CaptionBody = "BodySmall",
    Footer = "CaptionSmall"
}

local var1 = t.strictInterface({
    themeKey = t.optional(t.string),
    fontKey = t.optional(t.string),
    AnchorPoint = t.optional(t.Vector2),
    LayoutOrder = t.optional(t.integer),
    Position = t.optional(t.UDim2),
    Size = t.optional(t.UDim2),
    Text = t.string,
    TextColor3 = t.optional(t.Color3),
    TextTransparency = t.optional(t.numberConstrained(0, 1)),
    TextWrapped = t.optional(t.boolean),
    TextXAlignment = t.optional(t.enum(Enum.TextXAlignment)),
    TextYAlignment = t.optional(t.enum(Enum.TextYAlignment)),
    TextTruncate = t.optional(t.enum(Enum.TextTruncate)),
    Visible = t.optional(t.boolean),
    ZIndex = t.optional(t.integer),
    AutomaticSize = t.optional(t.enum(Enum.AutomaticSize)),
    [Roact.Children] = t.optional(t.table)
})

local function ThemedTextLabel(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end
    return withStyle(function(arg2)
        local var2 = arg2.Theme[arg1.themeKey or "TextDefault"]
        local var3 = arg2.Font[arg1.fontKey or "Body"]

        local var4 = Cryo.Dictionary.join({
            TextColor3 = var2.Color,
            TextTransparency = var2.Transparency
        }, arg1, {
            fontKey = Cryo.None,
            themeKey = Cryo.None,
            BackgroundTransparency = 1,
            Font = Cryo.None,
            FontFace = normalizeFontFace(arg2.Tokens.Typography[tbl1[arg1.fontKey or "Body"]].Font),
            TextSize = var3.RelativeSize * arg2.Font.BaseSize
        })

        return Roact.createElement("TextLabel", var4)
    end)
end

return ThemedTextLabel
