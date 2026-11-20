-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local withStyle = require(scriptParentParentParentParent.UIBlox.Core.Style.withStyle)
local Images = require(scriptParentParentParentParent.UIBlox.App.ImageSet.Images)
local InputButton = require(scriptParentParentParentParent.UIBlox.Core.InputButton.InputButton)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)

local var1 = Roact.PureComponent:extend("RadioButton")

var1.validateProps = t.strictInterface({
    text = t.string,
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    onActivated = t.callback,
    size = t.UDim2,
    layoutOrder = t.optional(t.number),
    id = t.number,
    NextSelectionDown = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    SelectionImageObject = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean),
    forwardRef = t.optional(t.table)
})

var1.defaultProps = {
    text = "RadioButton Text",
    isSelected = false,
    isDisabled = false,
    layoutOrder = 0,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    function arg1.onSetValue()
        if not arg1.props.isDisabled then
            arg1.props.onActivated(arg1.props.id)
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local componentAssetsCircle24Stroke1 = Images["component_assets/circle_24_stroke_1"]
        local textDefaultColor = theme.TextDefault.Color

        local componentAssetsCircle16 = Images["component_assets/circle_16"]
        local textDefaultColor2 = theme.TextDefault.Color

        local isSelected = arg1.props.isSelected

        local textDefaultColor3 = theme.TextDefault.Color
        local textDefaultTransparency = theme.TextDefault.Transparency

        local transparency = if arg1.props.isDisabled then 0.5 else textDefaultTransparency
        local var3

        if isSelected then
            var3 = UDim2.new(0, 18, 0, 18)
            textDefaultColor2 = theme.SystemPrimaryDefault.Color
            textDefaultColor = theme.SystemPrimaryDefault.Color
        else
            var3 = UDim2.new(0, 0, 0, 0)
        end

        local var4 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable[InputButton] else InputButton
        return Roact.createElement(var4, {
            text = arg1.props.text,
            onActivated = arg1.onSetValue,
            size = arg1.props.size,
            image = componentAssetsCircle24Stroke1,
            imageColor = textDefaultColor,
            fillImage = componentAssetsCircle16,
            fillImageSize = var3,
            fillImageColor = textDefaultColor2,
            selectedColor = theme.SystemPrimaryDefault.Color,
            textColor = textDefaultColor3,
            transparency = transparency,
            layoutOrder = arg1.props.layoutOrder,
            isDisabled = arg1.props.isDisabled,
            isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled,
            [Roact.Ref] = arg1.props.forwardRef,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            SelectionImageObject = arg1.props.SelectionImageObject
        })
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
