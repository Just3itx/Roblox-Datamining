-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace

local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)

local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateTypographyInfo)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local validateColorToken = require(scriptParentParentParentParent.Core.Style.Validator.validateColorToken)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local var1 = Roact.PureComponent:extend("GenericTextLabel")

var1.validateProps = t.interface({
    maxSize = t.optional(t.Vector2),
    fontStyle = t.union(validateFontInfo, validateTypographyInfo),
    colorStyle = t.union(validateColorInfo, validateColorToken),
    fluidSizing = t.optional(t.boolean),
    openTypeFeatures = t.optional(t.string)
})

var1.defaultProps = {
    maxSize = Vector2.new(10000, 10000),
    fluidSizing = false,
    openTypeFeatures = nil
}

function var1.render(arg1)
    local propsText = arg1.props.Text
    local fluidSizing = arg1.props.fluidSizing

    return withStyle(function(arg2)
        local fontStyle = arg1.props.fontStyle
        local colorStyle = arg1.props.colorStyle
        local textColor3 = colorStyle.Color or colorStyle.Color3
        local colorStyleTransparency = colorStyle.Transparency
        local richText = arg1.props.RichText

        local baseSize = arg2.Font.BaseSize
        local minTextSize = if fontStyle.RelativeMinSize then baseSize * fontStyle.RelativeMinSize else fontStyle.FontSize
        local maxTextSize = if fontStyle.RelativeSize then baseSize * fontStyle.RelativeSize else fontStyle.FontSize
        local fontFromFontStyle = GetFontFromFontStyle(fontStyle)

        local propsSize = arg1.props.Size
        if propsSize == nil then
            local var5 = propsText
            if arg1.props.TextTruncate == Enum.TextTruncate.AtEnd then
                var5 ..= "..."
            end
            local maxSize = arg1.props.maxSize
            local var6 = if arg1.props.LineHeight then maxTextSize * arg1.props.LineHeight else maxTextSize
            local textSize = GetTextSize(var5, var6, fontFromFontStyle, maxSize)
            propsSize = UDim2.new(0, textSize.X, 0, textSize.Y)
        end

        if arg1.props.AutomaticSize ~= nil and arg1.props.AutomaticSize ~= Enum.AutomaticSize.None then
            propsSize = nil
        end

        local textSize = arg1.props.TextSize or maxTextSize
        local automaticSize = arg1.props.AutomaticSize or nil

        local var6 = Cryo.Dictionary.join(arg1.props, {
            [Roact.Children] = Cryo.None,
            fluidSizing = Cryo.None,
            fontStyle = Cryo.None,
            openTypeFeatures = Cryo.None,
            colorStyle = Cryo.None,
            maxSize = Cryo.None,
            Size = propsSize,
            Text = propsText,
            Font = Cryo.None,
            FontFace = normalizeFontFace(fontFromFontStyle),
            TextSize = textSize,
            AutomaticSize = automaticSize,
            TextColor3 = textColor3,
            TextTransparency = colorStyleTransparency,
            TextWrapped = arg1.props.TextWrapped == nil or arg1.props.TextWrapped,
            TextScaled = fluidSizing,
            BackgroundTransparency = 1,
            RichText = richText
        })

        if UIBloxConfig.enableOpenTypeSupport and arg1.props.openTypeFeatures then
            var6 = Cryo.Dictionary.join(var6, { OpenTypeFeatures = arg1.props.openTypeFeatures })
        end

        return Roact.createElement(
            "TextLabel",
            var6,
            Cryo.Dictionary.join({
                UITextSizeConstraint = fluidSizing
                    and Roact.createElement("UITextSizeConstraint", { MaxTextSize = maxTextSize, MinTextSize = minTextSize } or nil)
            }, arg1.props[Roact.Children] or {})
        )
    end)
end

return var1
