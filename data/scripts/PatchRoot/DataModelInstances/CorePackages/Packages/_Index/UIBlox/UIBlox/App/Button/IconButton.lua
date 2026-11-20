-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)
local Cryo = require(AppParentParent.Cryo)

local Interactable = require(Core.Control.Interactable)

local ControlState = require(Core.Control.Enum.ControlState)
local getContentStyle = require(Core.Button.getContentStyle)
local getIconSize = require(App.ImageSet.getIconSize)
local bindingValidator = require(Core.Utility.bindingValidator)
local validateImage = require(Core.ImageSet.Validator.validateImage)
local validateColorInfo = require(Core.Style.Validator.validateColorInfo)

local withStyle = require(Core.Style.withStyle)
local HoverButtonBackground = require(Core.Button.HoverButtonBackground)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local IconSize = require(App.ImageSet.Enum.IconSize)

local Focusable = require(AppParentParent.RoactGamepad).Focusable
local isCallable = require(AppParent.Utility.isCallable)
local useCursor = require(AppParent.App.SelectionCursor.useCursor)

local uDim = UDim.new(0, 8)

local var1 = Roact.PureComponent:extend("IconButton")

local strictInterface = t.strictInterface
local tbl1 = {
    onStateChanged = t.optional(isCallable),
    isDisabled = t.optional(t.boolean),
    colorStyleDefault = t.optional(t.string),
    colorStyleHover = t.optional(t.string),
    colorDefault = t.optional(validateColorInfo),
    colorHover = t.optional(validateColorInfo),
    userInteractionEnabled = t.optional(t.boolean),
    onActivated = t.optional(isCallable),
    onAbsolutePositionChanged = t.optional(isCallable),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.number),
    position = t.optional(t.union(t.UDim2, t.table)),
    size = t.optional(t.union(t.UDim2, t.table)),
    icon = t.optional(validateImage),
    iconSize = t.optional(IconSize.isEnumValue),
    iconColor3 = t.optional(t.Color3),
    iconTransparency = t.optional(t.union(t.number, bindingValidator(t.number))),
    showBackground = t.optional(t.boolean),
    backgroundColor = t.optional(validateColorInfo),
    backgroundTransparency = t.optional(t.union(t.number, bindingValidator(t.number))),
    cursor = t.optional(t.table),
    [Roact.Children] = t.optional(t.table),
    debugControlState = t.optional(ControlState.isEnumValue),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    inputBindings = t.optional(t.table),
    buttonRef = t.optional(t.union(t.callback, t.table)),
    [Roact.Change.AbsoluteSize] = t.optional(t.callback),
    isRoactGamepadEnabled = t.optional(t.boolean)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    anchorPoint = Vector2.new(0, 0),
    layoutOrder = 0,
    position = UDim2.new(0, 0, 0, 0),
    size = nil,
    icon = "",
    iconSize = IconSize.Medium,
    colorStyleDefault = "IconEmphasis",
    colorStyleHover = "IconEmphasis",
    iconColor3 = nil,
    iconTransparency = nil,
    showBackground = false,
    backgroundColor = nil,
    backgroundTransparency = nil,
    isDisabled = false,
    userInteractionEnabled = true,
    debugControlState = nil,
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

    local tbl2 = {
        [IconSize.Small] = 1,
        [IconSize.Medium] = 2,
        [IconSize.Large] = 3,
        [IconSize.XLarge] = 4,
        [IconSize.XXLarge] = 5
    }
    function arg1.getSize(arg2)
        if arg1.props.size then
            return arg1.props.size
        end

        local iconSize = arg1.props.iconSize
        local var2 = arg2 + 4 * tbl2[iconSize]
        return UDim2.fromOffset(var2, var2)
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProviders(arg2, nil, nil)
    end)
end

function var1.renderWithProviders(arg1, arg2, _, _)
    local iconSize = getIconSize(arg1.props.iconSize, arg2)
    local size = arg1.getSize(iconSize)
    local showBackground = arg1.props.showBackground
    local var2 = arg1.props.debugControlState or arg1.state.controlState

    local tbl2 = {
        [ControlState.Default] = arg1.props.colorStyleDefault,
        [ControlState.Hover] = arg1.props.colorStyleHover
    }

    local contentStyle = getContentStyle(tbl2, var2, arg2)
    local var3 = if arg1.props.backgroundColor == nil then arg2.Theme.UIMuted else arg1.props.backgroundColor
    return Roact.createElement(if arg1.props.isRoactGamepadEnabled then Focusable[Interactable] else Interactable, {
        AnchorPoint = arg1.props.anchorPoint,
        LayoutOrder = arg1.props.layoutOrder,
        Position = arg1.props.position,
        Size = size,
        isDisabled = arg1.props.isDisabled,
        onStateChanged = arg1.onStateChanged,
        userInteractionEnabled = arg1.props.userInteractionEnabled,
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        [Roact.Change.AbsoluteSize] = arg1.props[Roact.Change.AbsoluteSize],
        [Roact.Change.AbsolutePosition] = arg1.props.onAbsolutePositionChanged,
        [Roact.Event.Activated] = arg1.props.onActivated,
        [Roact.Ref] = arg1.props.buttonRef,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionUp = arg1.props.NextSelectionUp,
        NextSelectionDown = arg1.props.NextSelectionDown,
        inputBindings = if arg1.props.isRoactGamepadEnabled then arg1.props.inputBindings else nil,
        SelectionImageObject = arg1.props.cursor
    }, {
        sizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(iconSize, iconSize) }),
        imageLabel = Roact.createElement(ImageSetComponent.Label, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(iconSize, iconSize),
            BackgroundTransparency = 1,
            Image = arg1.props.icon,
            ImageColor3 = arg1.props.iconColor3 or contentStyle.Color,
            ImageTransparency = arg1.props.iconTransparency or contentStyle.Transparency
        }, arg1.props[Roact.Children]),
        hoverBackground = var2 == ControlState.Hover and Roact.createElement(HoverButtonBackground) or nil,
        background = if showBackground then Roact.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = var3.Color,
                BackgroundTransparency = arg1.props.backgroundTransparency or var3.Transparency,
                ZIndex = 0
            },
            {
                corner = Roact.createElement("UICorner", { CornerRadius = uDim })
            }
        )
            or nil else nil
    })
end

local function IconButtonFunctionalWrapper(arg1)
    local cursor = useCursor(uDim)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { cursor = cursor }))
end

local var2 = Roact.PureComponent:extend("IconButtonOuterWrapper")

var2.validateProps = var1.validateProps

function var2.render(arg1)
    return Roact.createElement(IconButtonFunctionalWrapper, arg1.props)
end

return var2
