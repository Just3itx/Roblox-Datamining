-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local React = require(scriptParentParentParentParent.React)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)

local Images = require(scriptParentParent.ImageSet.Images)
local useCursor = require(scriptParentParent.SelectionCursor.useCursor)

local ControlState = require(Core.Control.Enum.ControlState)
local GenericButton = require(Core.Button.GenericButton)
local validateImage = require(Core.ImageSet.Validator.validateImage)
local withStyle = require(Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("ComboButton")

local uDim = UDim.new(0, 8)

local buttonStateColorMap = {
    [ControlState.Default] = "ContextualPrimaryDefault",
    [ControlState.Hover] = "ContextualPrimaryOnHover"
}

local contentStateColorMap = {
    [ControlState.Default] = "ContextualPrimaryContent"
}
var1.validateProps = t.strictInterface({
    button = t.strictInterface({
        icon = t.optional(validateImage),
        text = t.optional(t.string),
        isDisabled = t.optional(t.boolean),
        onActivated = t.callback
    }),
    overflow = t.strictInterface({ icon = t.optional(validateImage), isDisabled = t.optional(t.boolean), onActivated = t.callback }),
    position = t.optional(t.UDim2),
    size = t.optional(t.UDim2),
    layoutOrder = t.optional(t.number),
    cursor = t.optional(t.table),
    testId = t.optional(t.string)
})

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    testId = "--uiblox-combo-button"
}

function var1.init(arg1)
    arg1:setState({ buttonControlState = ControlState.Initialize, overflowControlState = ControlState.Initialize })

    function arg1.onButtonStateChanged(_, buttonControlState)
        arg1:setState({ buttonControlState = buttonControlState })
    end

    function arg1.onOverflowStateChanged(_, overflowControlState)
        arg1:setState({ overflowControlState = overflowControlState })
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProviders(arg2, nil, nil)
    end)
end

function var1.renderWithProviders(arg1, _, _, _)
    local size = arg1.props.size
    local uDim2 = UDim2.new(1, -40, 1, 0)
    local uDim2_2 = UDim2.new(0, 39, 1, 0)

    return Roact.createElement("Frame", {
        LayoutOrder = arg1.props.layoutOrder,
        Position = arg1.props.position,
        Size = size,
        BackgroundTransparency = 1,
        [React.Tag] = if arg1.props.testId then `data-testid={arg1.props.testId}` else nil
    }, {
        Button = Roact.createElement(GenericButton, {
            Position = UDim2.fromScale(0, 0),
            Size = uDim2,
            buttonImage = Images["component_assets/bulletLeft_17"],
            buttonStateColorMap = buttonStateColorMap,
            contentStateColorMap = contentStateColorMap,
            hoverImage = Images["component_assets/bulletLeft_17"],
            icon = arg1.props.button.icon,
            isDisabled = arg1.props.button.isDisabled,
            isHoverBackgroundEnabled = true,
            onActivated = arg1.props.button.onActivated,
            onStateChanged = arg1.onButtonStateChanged,
            SelectionImageObject = arg1.props.cursor,
            text = arg1.props.button.text,
            ZIndex = 0
        }),
        Overflow = Roact.createElement(GenericButton, {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            Size = uDim2_2,
            ZIndex = 0,
            buttonImage = Images["component_assets/bulletRight_17"],
            buttonStateColorMap = buttonStateColorMap,
            contentStateColorMap = contentStateColorMap,
            hoverImage = Images["component_assets/bulletRight_17"],
            icon = arg1.props.overflow.icon or Images["icons/actions/truncationExpand"],
            isDisabled = arg1.props.overflow.isDisabled,
            isHoverBackgroundEnabled = true,
            onActivated = arg1.props.overflow.onActivated,
            onStateChanged = arg1.onOverflowStateChanged,
            SelectionImageObject = arg1.props.cursor
        })
    })
end

function ComboButtonFunctionalWrapper(arg1)
    local cursor = useCursor(uDim)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { cursor = cursor }))
end

local var2 = Roact.PureComponent:extend("ComboButtonOuterWrapper")

var2.validateProps = var1.validateProps

function var2.render(arg1)
    return Roact.createElement(ComboButtonFunctionalWrapper, arg1.props)
end

return var2
