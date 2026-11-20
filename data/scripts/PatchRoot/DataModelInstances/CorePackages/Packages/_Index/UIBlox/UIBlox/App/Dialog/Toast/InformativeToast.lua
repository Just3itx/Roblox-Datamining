-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local ToastFrame = require(scriptParent.ToastFrame)
local ToastIcon = require(scriptParent.ToastIcon)
local ToastText = require(scriptParent.ToastText)

local var1 = Roact.PureComponent:extend("InformativeToast")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    iconProps = t.optional(ToastIcon.validateProps),
    iconChildren = t.optional(t.table),
    layoutOrder = t.optional(t.integer),
    padding = t.optional(t.numberMin(0)),
    position = t.optional(t.UDim2),
    size = t.UDim2,
    subtitleTextProps = t.optional(ToastText.validateProps),
    textFrameSize = t.optional(t.UDim2),
    titleTextProps = ToastText.validateProps
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    layoutOrder = 1,
    position = UDim2.new(0.5, 0, 0.5, 0),
    size = UDim2.new(1, 0, 1, 0)
}

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local settings = arg2.Settings

        return Roact.createElement("Frame", {
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundColor3 = theme.BackgroundUIContrast.Color,
            BackgroundTransparency = theme.BackgroundUIContrast.Transparency * settings.PreferredTransparency,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position,
            Size = arg1.props.size
        }, {
            ToastFrame = Roact.createElement(ToastFrame, {
                iconProps = arg1.props.iconProps,
                iconChildren = arg1.props.iconChildren,
                padding = arg1.props.padding,
                subtitleTextProps = arg1.props.subtitleTextProps,
                textFrameSize = arg1.props.textFrameSize,
                titleTextProps = arg1.props.titleTextProps
            })
        })
    end)
end

return var1
