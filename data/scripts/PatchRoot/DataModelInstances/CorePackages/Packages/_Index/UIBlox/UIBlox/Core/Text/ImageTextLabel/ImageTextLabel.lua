-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)

local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local GetWrappedTextWithIcon = require(scriptParentParentParentParent.Core.Text.GetWrappedTextWithIcon)
local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateTypographyInfo)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("ImageTextLabel")

var1.validateProps = t.interface({
    imageProps = t.optional(t.interface({ Size = t.UDim2 })),
    genericTextLabelProps = t.interface({
        Text = t.string,
        fontStyle = t.union(validateFontInfo, validateTypographyInfo),
        colorStyle = validateColorInfo,
        fluidSizing = t.optional(t.boolean),
        AnchorPoint = t.None,
        Position = t.None,
        Size = t.None,
        TextXAlignment = t.None,
        TextYAlignment = t.None,
        TextScaled = t.None,
        maxSize = t.None,
        richText = t.optional(t.boolean)
    }),
    frameProps = t.optional(t.interface({ Size = t.None })),
    maxSize = t.optional(t.Vector2),
    padding = t.optional(t.number)
})

var1.defaultProps = {
    maxSize = Vector2.new(10000, 10000),
    frameProps = {},
    padding = 0
}

function var1.render(arg1)
    local genericTextLabelProps = arg1.props.genericTextLabelProps
    local imageProps = arg1.props.imageProps
    local frameProps = arg1.props.frameProps
    local padding = arg1.props.padding
    local genericTextLabelPropsText = arg1.props.genericTextLabelProps.Text
    local maxSize = arg1.props.maxSize
    local useMaxHeight = arg1.props.useMaxHeight
    local richText = arg1.props.richText

    return withStyle(function(arg2)
        local fontStyle = genericTextLabelProps.fontStyle

        local baseSize = arg2.Font.BaseSize
        local var2 = if fontStyle.RelativeSize then baseSize * fontStyle.RelativeSize else fontStyle.FontSize
        local fontFromFontStyle = GetFontFromFontStyle(fontStyle)

        if imageProps then
            genericTextLabelPropsText = GetWrappedTextWithIcon(genericTextLabelPropsText, var2, fontFromFontStyle, imageProps.Size.X.Offset, padding)
        end

        local textSize = GetTextSize(genericTextLabelPropsText, var2, fontFromFontStyle, Vector2.new(maxSize.X, maxSize.Y))
        local y = useMaxHeight and maxSize.Y or textSize.Y

        local createElement = Roact.createElement
        local str1 = "Frame"
        local var3 = Cryo.Dictionary.join(frameProps, { Size = UDim2.new(0, textSize.X, 0, y) })

        local tbl1 = {
            Icon = if imageProps then Roact.createElement(ImageSetComponent.Label, imageProps) else nil,
            Name = Roact.createElement(
                GenericTextLabel,
                Cryo.Dictionary.join(genericTextLabelProps, {
                    Text = genericTextLabelPropsText,
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    TextXAlignment = genericTextLabelProps.TextXAlignment or Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    fluidSizing = not imageProps and arg1.props.fluidSizing,
                    maxSize = maxSize,
                    RichText = richText
                })
            )
        }
        return createElement(str1, var3, tbl1)
    end)
end

return var1
