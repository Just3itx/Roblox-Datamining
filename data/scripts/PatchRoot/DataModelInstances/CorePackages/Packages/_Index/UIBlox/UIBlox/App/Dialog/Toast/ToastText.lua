-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)

local var1 = Roact.PureComponent:extend("ToastText")

var1.validateProps = t.interface({
    colorStyle = validateColorInfo,
    fontStyle = validateFontInfo,
    Size = t.UDim2,
    Text = t.string,
    AnchorPoint = t.optional(t.Vector2),
    fluidSizing = t.optional(t.boolean),
    LayoutOrder = t.optional(t.integer),
    maxSize = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    TextTruncate = t.optional(t.EnumItem),
    TextXAlignment = t.optional(t.EnumItem),
    TextYAlignment = t.optional(t.EnumItem)
})

var1.defaultProps = {
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
}

function var1.render(arg1)
    return Roact.createElement(GenericTextLabel, arg1.props)
end

return var1
