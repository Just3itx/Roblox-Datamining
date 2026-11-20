-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)
local Roact = require(scriptParentParentParentParent.Roact)
local enumerate = require(scriptParentParentParentParent.enumerate)
local bindingValidator = require(Core.Utility.bindingValidator)

local withStyle = require(Core.Style.withStyle)
local withSelectionCursorProvider = require(scriptParentParent.SelectionImage.withSelectionCursorProvider)
local useCursorByType = require(scriptParentParent.SelectionCursor.useCursorByType)
local Interactable = require(Core.Control.Interactable)
local ControlState = require(Core.Control.Enum.ControlState)
local CursorType = require(scriptParentParent.SelectionCursor.CursorType)

local var1 = Roact.PureComponent:extend("Cell")
var1.debugProps = enumerate("debugProps", { "controlState" })

local strictInterface = t.strictInterface
local tbl1 = {
    head = t.table,
    tail = t.optional(t.table),
    background = t.optional(t.table),
    layoutOrder = t.optional(t.union(t.integer, bindingValidator(t.number))),
    size = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    horizontalPadding = t.optional(t.number),
    selectable = t.optional(t.boolean),
    layoutWraps = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    userInteractionEnabled = t.optional(t.boolean),
    onStateChanged = t.optional(t.callback),
    onActivated = t.optional(t.callback),
    onTouchTapped = t.optional(t.callback),
    [var1.debugProps.controlState] = t.optional(ControlState.isEnumValue),
    [Roact.Change.AbsolutePosition] = t.optional(t.callback),
    [Roact.Ref] = t.optional(t.union(t.callback, t.table)),
    forwardRef = t.optional(t.union(t.callback, t.table)),
    selectionCursor = t.optional(t.any)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = { isDisabled = false, userInteractionEnabled = true, horizontalPadding = 24 }

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    arg1.stateStyleMap = {
        [ControlState.Default] = "BackgroundDefault",
        [ControlState.Hover] = "BackgroundOnHover",
        [ControlState.Pressed] = "BackgroundOnPress"
    }

    function arg1.getBackgroundStyle(disabled, arg2)
        local var2 = arg1.stateStyleMap[disabled] or arg1.stateStyleMap[ControlState.Default]

        local tbl2 = {
            Color = arg2.Theme[var2].Color,
            Transparency = arg2.Theme[var2].Transparency
        }

        if disabled == ControlState.Disabled then
            tbl2.Transparency = 1
        end
        return tbl2
    end

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return withSelectionCursorProvider(function(arg3)
            return arg1:renderWithProviders(arg2, arg3)
        end)
    end)
end

function var1.renderWithProviders(arg1, arg2, _)
    local anchorPoint = arg1.props.anchorPoint
    local layoutOrder = arg1.props.layoutOrder
    local position = arg1.props.position
    local var2 = arg1.props.size or UDim2.fromScale(1, 1)

    local head = arg1.props.head
    local tail = arg1.props.tail
    local background = arg1.props.background

    local isDisabled = arg1.props.isDisabled
    local var3 = arg1.props.onActivated and function(...)
        if arg1.props.tail and arg1.props.userInteractionEnabled and arg1.props.onActivated then
            arg1.props.onActivated(...)
        end
    end or arg1.props.onActivated
    local onTouchTapped = arg1.props.onTouchTapped

    local var4 = arg1.props[var1.debugProps.controlState] or arg1.state.controlState
    local backgroundStyle = arg1.getBackgroundStyle(var4, arg2)

    return Roact.createElement(Interactable, {
        AnchorPoint = anchorPoint,
        LayoutOrder = layoutOrder,
        Position = position,
        Size = var2,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Selectable = arg1.props.selectable,
        SelectionImageObject = arg1.props.selectionCursor,
        isDisabled = isDisabled,
        onStateChanged = arg1.onStateChanged,
        [Roact.Event.Activated] = var3,
        [Roact.Event.TouchTap] = onTouchTapped,
        [Roact.Change.AbsolutePosition] = arg1.props[Roact.Change.AbsolutePosition],
        [Roact.Ref] = arg1.props.forwardRef
    }, {
        CellBackground = Roact.createElement(
            "Frame",
            {
                Size = var2,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ZIndex = -1
            },
            {
                Background = background
                    or Roact.createElement("Frame", {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundColor3 = backgroundStyle.Color,
                        BackgroundTransparency = backgroundStyle.Transparency,
                        BorderSizePixel = 0
                    }),
                CellContent = Roact.createElement("Frame", {
                    Size = UDim2.fromScale(1, 1),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2
                }, {
                    Layout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
                        Wraps = arg1.props.layoutWraps
                    }),
                    Padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, arg1.props.horizontalPadding),
                            PaddingRight = UDim.new(0, arg1.props.horizontalPadding)
                        }
                    ),
                    CellHead = Roact.createElement("Frame", {
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.fromScale(0, 0.5),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        LayoutOrder = 1
                    }, { Head = head }),
                    CellTail = tail
                        and Roact.createElement("Frame", {
                            AnchorPoint = Vector2.new(1, 0.5),
                            Position = UDim2.fromScale(1, 0.5),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            LayoutOrder = 2
                        }, { Tail = tail })
                        or nil
                })
            }
        ),
        DisabledMask = var4 == ControlState.Disabled
            and Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = backgroundStyle.Color,
                BackgroundTransparency = 0.5,
                ZIndex = 100
            })
            or nil
    })
end

return Roact.forwardRef(function(arg1, forwardRef)
    local selectionCursor = useCursorByType(CursorType.RoundedRectNoInset)
    arg1 = Cryo.Dictionary.join({ selectionCursor = selectionCursor }, arg1)

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
