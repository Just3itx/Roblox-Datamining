-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local _StyleTypes = require(scriptParentParentParent.Style.StyleTypes)
local _Fonts = require(scriptParentParentParent.Style.Fonts)

local FooterFrame = require(scriptParent.FooterFrame)

local function getStyleProps(styleProps, arg1)
    local tbl1 = styleProps or {}
    return {
        cornerRadius = tbl1.cornerRadius,
        textColor = tbl1.textColor or arg1.Theme.TextMuted,
        backgroundColor = tbl1.backgroundColor,
        textXAlignment = tbl1.textXAlignment or Enum.TextXAlignment.Left,
        textFont = tbl1.textFont or arg1.Font.CaptionBody
    }
end

local function TextFooter(arg1)
    local var1 = useStyle()
    local font = var1.Font

    local styleProps = getStyleProps(arg1.styleProps, var1)
    local cornerRadius = styleProps.cornerRadius
    local textColor = styleProps.textColor
    local backgroundColor = styleProps.backgroundColor
    local textXAlignment = styleProps.textXAlignment
    local textFont = styleProps.textFont

    local createElement = React.createElement
    local var2 = FooterFrame
    local tbl1 = {
        Text = React.createElement("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = if backgroundColor then backgroundColor.Color else nil,
            BackgroundTransparency = if backgroundColor then backgroundColor.Transparency else 1,
            BorderSizePixel = 0,
            Text = arg1.text,
            TextXAlignment = textXAlignment,
            TextYAlignment = Enum.TextYAlignment.Center,
            FontFace = normalizeFontFace(textFont.Font),
            TextSize = font.BaseSize * textFont.RelativeSize,
            TextColor3 = textColor.Color,
            TextTransparency = textColor.Transparency,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, {
            UICorner = if cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, cornerRadius) }) else nil
        })
    }
    return createElement(var2, arg1, tbl1)
end

return TextFooter
