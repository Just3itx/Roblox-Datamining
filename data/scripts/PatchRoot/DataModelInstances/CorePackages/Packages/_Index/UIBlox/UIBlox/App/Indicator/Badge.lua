-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParent.Core.Text.GetFontFromFontStyle)

local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)

local Images = require(scriptParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local BadgeStates = require(script.Parent.Enum.BadgeStates)
local BadgeVariant = require(script.Parent.Enum.BadgeVariant)

local divideTransparency = require(scriptParentParentParent.Utility.divideTransparency)

local component_assetsCircle_25 = Images["component_assets/circle_25"]
local component_assetsCircle_21 = Images["component_assets/circle_21"]

local var1 = Roact.PureComponent:extend("Badge")

var1.validateProps = t.strictInterface({
    position = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    disabled = t.optional(t.boolean),
    hasShadow = t.optional(t.boolean),
    value = t.union(t.string, t.integer, BadgeStates.isEnumValue),
    badgeVariant = t.optional(BadgeVariant.isEnumValue),
    layoutOrder = t.optional(t.integer)
})

var1.defaultProps = {
    position = UDim2.new(0, 0, 0, 0),
    anchorPoint = Vector2.new(0, 0),
    disabled = false,
    hasShadow = false,
    badgeVariant = BadgeVariant.Default
}

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local str1 = tostring(arg1.props.value)
        if t.number(arg1.props.value) and arg1.props.value > 99 then
            str1 = "99+"
        elseif t.string(arg1.props.value) and utf8.len(utf8.nfcnormalize(arg1.props.value)) > 4 then
            local num1 = utf8.offset(arg1.props.value, 4) - 1
            str1 = string.sub(arg1.props.value, 1, num1) .. "..."
        end
        local str2 = if arg1.props.value == BadgeStates.isEmpty then "" else str1

        local baseSize = arg2.Font.BaseSize
        local var2 = font.CaptionBody.RelativeSize * baseSize

        local fontFromFontStyle = GetFontFromFontStyle(font.CaptionBody)
        local var3 = GetTextSize(str2, var2, fontFromFontStyle, Vector2.new(10000, 10000)).X + 10 + 4
        local xOffset = if var3 < 24 then 24 else var3
        local yOffset

        if arg1.props.value == BadgeStates.isEmpty then
            xOffset = 12
            yOffset = 12
        else
            yOffset = 24
        end

        local contrast = arg2.Tokens.Color.System.Contrast
        local tbl1 = {
            Color = arg2.Tokens.Inverse.Content.Emphasis.Color3,
            Transparency = arg2.Tokens.Inverse.Content.Emphasis.Transparency
        }

        if arg1.props.badgeVariant == BadgeVariant.Alert then
            contrast = arg2.Tokens.Color.System.Alert
            tbl1 = {
                Color = arg2.Tokens.Color.Extended.White.White_100.Color3,
                Transparency = arg2.Tokens.Inverse.Content.Emphasis.Transparency
            }
        end

        return Roact.createElement("Frame", {
            Position = arg1.props.position,
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(xOffset, yOffset),
            LayoutOrder = arg1.props.layoutOrder
        }, {
            Shadow = arg1.props.hasShadow
                and Roact.createElement(ImageSetComponent.Label, {
                    ZIndex = 1,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 12, 1, 12),
                    Image = Images["component_assets/dropshadow_25"],
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(18, 18, 19, 19)
                }),
            Background = Roact.createElement(ImageSetComponent.Label, {
                ZIndex = 2,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ImageColor3 = theme.BackgroundDefault.Color,
                ImageTransparency = divideTransparency(theme.BackgroundDefault.Transparency, if arg1.props.disabled then 2 else 1),
                Image = component_assetsCircle_25,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(14, 14, 15, 15)
            }),
            Inner = Roact.createElement(ImageSetComponent.Label, {
                ZIndex = 3,
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(1, -4, 1, -4),
                ImageColor3 = contrast.Color3,
                ImageTransparency = divideTransparency(contrast.Transparency, if arg1.props.disabled then 2 else 1),
                Image = component_assetsCircle_21,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 13, 13)
            }, {
                TextLabel = Roact.createElement(GenericTextLabel, {
                    fontStyle = font.CaptionBody,
                    colorStyle = tbl1,
                    BackgroundTransparency = 1,
                    Text = str2,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.fromScale(1, 1),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                })
            })
        })
    end)
end

return var1
