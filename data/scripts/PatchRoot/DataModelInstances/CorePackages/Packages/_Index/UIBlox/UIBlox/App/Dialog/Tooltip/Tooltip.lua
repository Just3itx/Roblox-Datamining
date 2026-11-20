-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local TooltipContainer = require(scriptParent.TooltipContainer)

local TooltipOrientation = require(scriptParent.Enum.TooltipOrientation)

local var1 = Roact.PureComponent:extend("Tooltip")

var1.validateProps = t.strictInterface({
    triggerPosition = t.Vector2,
    triggerSize = t.Vector2,
    bodyText = t.string,
    headerText = t.optional(t.string),
    backgroundColor = t.optional(t.Color3),
    backgroundTransparency = t.optional(t.number),
    onDismiss = t.optional(t.callback),
    onClose = t.optional(t.callback),
    screenSize = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    orientation = t.optional(TooltipOrientation.isEnumValue),
    triggerOnHover = t.optional(t.boolean),
    forceClickTriggerPoint = t.optional(t.boolean),
    isDirectChild = t.optional(t.boolean),
    minContentWidth = t.optional(t.number)
})

var1.defaultProps = {
    screenSize = Vector2.new(10000, 10000),
    orientation = TooltipOrientation.Bottom,
    triggerOnHover = false,
    forceClickTriggerPoint = false,
    isDirectChild = false
}

function var1.init(arg1)
    function arg1.onDismissDefault()
        if arg1.props.forceClickTriggerPoint or arg1.props.triggerOnHover then
            return
        end
        if arg1.props.onDismiss then
            arg1.props.onDismiss()
        end
    end
end

function var1.render(arg1)
    local var2 = arg1.props.forceClickTriggerPoint or arg1.props.triggerOnHover
    local isDirectChild = arg1.props.isDirectChild
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local tbl1 = { Background = 0, TriggerPointMask = 0, TooltipContainer = 0 }

        local bool1 = not arg1.props.forceClickTriggerPoint

        if bool1 then
            bool1 = Roact.createElement("TextButton", {
                ZIndex = 0,
                AutoButtonColor = false,
                BackgroundColor3 = theme.Overlay.Color,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = isDirectChild and UDim2.fromOffset(-arg1.props.triggerPosition.X, -arg1.props.triggerPosition.Y)
                    or UDim2.fromOffset(0, 0),
                Size = UDim2.fromOffset(arg1.props.screenSize.X, arg1.props.screenSize.Y),
                Text = "",
                [Roact.Event.Activated] = arg1.onDismissDefault,
                [Roact.Event.TouchSwipe] = arg1.onDismissDefault,
                [Roact.Event.MouseWheelForward] = arg1.onDismissDefault,
                [Roact.Event.MouseWheelBackward] = arg1.onDismissDefault
            })
        end

        tbl1.Background = bool1

        local var3 = var2

        if var3 then
            var3 = Roact.createElement("TextButton", {
                Text = "",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Selectable = false,
                Size = UDim2.fromOffset(arg1.props.triggerSize.X, arg1.props.triggerSize.Y),
                Position = isDirectChild and UDim2.fromOffset(0, 0)
                    or UDim2.fromOffset(arg1.props.triggerPosition.X, arg1.props.triggerPosition.Y),
                [Roact.Event.Activated] = arg1.props.onDismiss
            })
        end

        tbl1.TriggerPointMask = var3

        tbl1.TooltipContainer = Roact.createElement(TooltipContainer, {
            triggerPosition = arg1.props.triggerPosition,
            triggerSize = arg1.props.triggerSize,
            bodyText = arg1.props.bodyText,
            headerText = arg1.props.headerText,
            screenSize = arg1.props.screenSize,
            position = arg1.props.position,
            orientation = arg1.props.orientation,
            isDirectChild = isDirectChild
        })

        return isDirectChild
            and Roact.createElement("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0 }, tbl1)
            or Roact.createFragment(tbl1)
    end)
end

return var1
