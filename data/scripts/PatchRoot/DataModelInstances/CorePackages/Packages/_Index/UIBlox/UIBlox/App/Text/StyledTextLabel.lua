-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local validateFontInfo = require(scriptParentParentParent.Core.Style.Validator.validateFontInfo)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)
local validateColorToken = require(scriptParentParentParent.Core.Style.Validator.validateColorToken)
local validateTypographyInfo = require(scriptParentParentParent.Core.Style.Validator.validateTypographyInfo)

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local var1 = Roact.PureComponent:extend("StyledTextLabel")

var1.validateProps = t.strictInterface({
    text = t.string,
    fontStyle = t.union(validateFontInfo, validateTypographyInfo),
    colorStyle = t.union(validateColorInfo, validateColorToken),
    textTruncate = t.optional(t.EnumItem),
    textWrapped = t.optional(t.boolean),
    textXAlignment = t.optional(t.EnumItem),
    textYAlignment = t.optional(t.EnumItem),
    size = t.optional(t.UDim2),
    maxSize = t.optional(t.Vector2),
    richText = t.optional(t.boolean),
    layoutOrder = t.optional(t.number),
    fluidSizing = t.optional(t.boolean),
    automaticSize = t.optional(t.EnumItem),
    lineHeight = t.optional(t.number),
    clipsDescendants = t.optional(t.boolean),
    onAbsoluteSizeChange = t.optional(t.callback),
    openTypeFeatures = t.optional(t.string)
})

var1.defaultProps = {
    textXAlignment = Enum.TextXAlignment.Left,
    textYAlignment = Enum.TextYAlignment.Center,
    richText = true,
    fluidSizing = true,
    automaticSize = Enum.AutomaticSize.None,
    lineHeight = 1.4,
    clipsDescendants = false,
    openTypeFeatures = nil
}

function var1.render(arg1)
    return Roact.createElement(GenericTextLabel, {
        maxSize = arg1.props.maxSize,
        fontStyle = arg1.props.fontStyle,
        colorStyle = arg1.props.colorStyle,
        fluidSizing = arg1.props.fluidSizing,
        Size = arg1.props.size,
        Text = arg1.props.text,
        TextXAlignment = arg1.props.textXAlignment,
        TextYAlignment = arg1.props.textYAlignment,
        TextTruncate = arg1.props.textTruncate,
        TextWrapped = arg1.props.textWrapped,
        LayoutOrder = arg1.props.layoutOrder,
        RichText = arg1.props.richText,
        AutomaticSize = arg1.props.automaticSize,
        LineHeight = arg1.props.lineHeight,
        ClipsDescendants = arg1.props.clipsDescendants,
        openTypeFeatures = arg1.props.openTypeFeatures,
        [Roact.Change.AbsoluteSize] = arg1.props.onAbsoluteSizeChange
    })
end

return var1
