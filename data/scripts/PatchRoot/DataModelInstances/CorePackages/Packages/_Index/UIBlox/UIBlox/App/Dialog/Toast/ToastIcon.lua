-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)

local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("ToastIcon")

var1.validateProps = t.interface({
    Image = t.union(t.table, t.string, t.callback),
    Size = t.UDim2,
    AnchorPoint = t.optional(t.Vector2),
    colorStyle = t.optional(validateColorInfo),
    LayoutOrder = t.optional(t.integer),
    Position = t.optional(t.UDim2)
})

var1.defaultProps = { BackgroundTransparency = 1 }

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local colorStyle = arg1.props.colorStyle
        if colorStyle == nil then
            colorStyle = theme.IconEmphasis
        end

        local colorStyleColor = colorStyle.Color
        local colorStyleTransparency = colorStyle.Transparency

        local var2 = Cryo.Dictionary.join(
            arg1.props,
            {
                colorStyle = Cryo.None,
                ImageColor3 = colorStyleColor,
                ImageTransparency = colorStyleTransparency
            }
        )
        return Roact.createElement(ImageSetComponent.Label, var2)
    end)
end

return var1
