-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)
local Images = require(scriptParentParentParent.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Interactable = require(scriptParentParentParentParent.Core.Control.Interactable)
local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local var1 = Roact.Component:extend("BaseKnob")

local tbl1 = {
    [ControlState.Default] = {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 0.7
    },
    [ControlState.Hover] = {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 0.5
    }
}

local tbl2 = {
    [ControlState.Default] = UDim2.fromOffset(48, 48),
    [ControlState.Hover] = UDim2.fromOffset(48, 48),
    [ControlState.Pressed] = UDim2.fromOffset(0, 0),
    [ControlState.Disabled] = UDim2.fromOffset(0, 0),
    [ControlState.Selected] = UDim2.fromOffset(52, 52),
    [ControlState.SelectedPressed] = UDim2.fromOffset(42, 42)
}

local tbl3 = {
    [ControlState.Default] = "component_assets/dropshadow_28",
    [ControlState.Hover] = "component_assets/dropshadow_28",
    [ControlState.Selected] = "component_assets/circle_52_stroke_3",
    [ControlState.SelectedPressed] = "component_assets/circle_42_stroke_3"
}

var1.validateProps = t.interface({
    onStateChanged = t.optional(t.callback),
    isDisabled = t.optional(t.boolean),
    userInteractionEnabled = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.number),
    position = t.optional(t.UDim2),
    colorMap = t.strictInterface({
        [ControlState.Default] = validateColorInfo,
        [ControlState.Hover] = validateColorInfo,
        [ControlState.Pressed] = validateColorInfo,
        [ControlState.Disabled] = validateColorInfo,
        [ControlState.Selected] = validateColorInfo,
        [ControlState.SelectedPressed] = validateColorInfo
    }),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    controlRef = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    userInteractionEnabled = true,
    isDisabled = false,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local var2 = arg1.props.colorMap[arg1.state.controlState] or arg1.props.colorMap[ControlState.Default]
        local var3 = tbl2[arg1.state.controlState] or tbl2[ControlState.Default]
        local var4 = tbl3[arg1.state.controlState] or tbl3[ControlState.Default]
        local bool1 = arg1.state.controlState == ControlState.Selected or arg1.state.controlState == ControlState.SelectedPressed
        local var5 = tbl1[arg1.state.controlState] or tbl1[ControlState.Default]
        if bool1 then
            var5 = arg2.Theme.SelectionCursor
        end

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl4 = {
            AnchorPoint = arg1.props.anchorPoint,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(28, 28)
        }
        local tbl5 = {
            KnobShadow = Roact.createElement(ImageSetComponent.Label, {
                Size = var3,
                Position = UDim2.new(0.5, 0, 0.5, if bool1 then 0 else 2),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = Images[var4],
                ImageColor3 = var5.Color,
                ImageTransparency = var5.Transparency,
                Active = true,
                BackgroundTransparency = 1
            }),
            KnobButton = Roact.createElement(
                if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable[Interactable] else Interactable,
                {
                    Size = UDim2.fromScale(1, 1),
                    isDisabled = arg1.props.isDisabled,
                    onStateChanged = arg1.onStateChanged,
                    userInteractionEnabled = arg1.props.userInteractionEnabled,
                    BackgroundTransparency = 1,
                    Image = Images["component_assets/circle_29"],
                    ImageColor3 = var2.Color,
                    ImageTransparency = var2.Transparency,
                    [Roact.Ref] = arg1.props.forwardedRef,
                    [Roact.Event.Activated] = arg1.props.onActivated,
                    NextSelectionLeft = arg1.props.NextSelectionLeft,
                    NextSelectionRight = arg1.props.NextSelectionRight,
                    NextSelectionUp = arg1.props.NextSelectionUp,
                    NextSelectionDown = arg1.props.NextSelectionDown
                }
            )
        }
        return createElement(str1, tbl4, tbl5)
    end)
end

return var1
