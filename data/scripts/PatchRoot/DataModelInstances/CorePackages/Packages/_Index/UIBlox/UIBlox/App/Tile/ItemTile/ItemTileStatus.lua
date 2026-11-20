-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local ItemTileEnums = require(scriptParentParent.Enum.ItemTileEnums)

local var1 = Roact.PureComponent:extend("ItemTileStatus")

local vector2 = Vector2.new(50, 20)
local vector2_2 = Vector2.new(10, 6)

var1.validateProps = t.strictInterface({ statusText = t.string, statusStyle = ItemTileEnums.StatusStyle.isEnumValue })

local function getStyle(theme, statusStyle)
    if statusStyle == ItemTileEnums.StatusStyle.Info then
        return {
            Background = theme.SystemPrimaryDefault,
            Text = theme.SystemPrimaryContent
        }
    end

    if statusStyle == ItemTileEnums.StatusStyle.Alert then
        return {
            Background = theme.Alert,
            Text = theme.TextEmphasis
        }
    end

    return {
        Background = theme.SystemPrimaryDefault,
        Text = theme.SystemPrimaryContent
    }
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local tokens = arg2.Tokens

        local statusText = arg1.props.statusText
        local statusStyle = arg1.props.statusStyle

        local fontFromFontStyle = GetFontFromFontStyle(font.CaptionHeader)
        local var2 = font.BaseSize * font.CaptionHeader.RelativeSize
        local textSize = GetTextSize(statusText, var2, fontFromFontStyle, vector2)

        local style = getStyle(theme, statusStyle)

        return Roact.createElement(ImageSetComponent.Label, {
            BackgroundTransparency = 1,
            Image = Images["component_assets/circle_17"],
            ImageColor3 = style.Background.Color,
            ImageTransparency = style.Background.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Position = UDim2.new(0, tokens.Size.Size_200, 0, tokens.Size.Size_200),
            Size = UDim2.new(0, textSize.X + vector2_2.X, 0, textSize.Y + vector2_2.Y)
        }, {
            Text = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(fontFromFontStyle),
                TextSize = var2,
                Text = statusText,
                TextColor3 = style.Text.Color,
                TextTransparency = style.Text.TextTransparency,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Size = UDim2.new(1, 0, 1, 0)
            })
        })
    end)
end

return var1
