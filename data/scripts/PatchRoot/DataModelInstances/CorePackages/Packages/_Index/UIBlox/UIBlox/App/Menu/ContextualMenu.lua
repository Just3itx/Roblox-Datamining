-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Otter = require(scriptParentParentParentParent.Otter)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)

local BaseMenu = require(script.Parent.BaseMenu)
local MenuDirection = require(script.Parent.MenuDirection)
local validateButtonProps = require(script.Parent.validateButtonProps)
local validateMotorOptionProps = require(script.Parent.validateMotorOptionProps)

local motorOptions = {
    open = {
        targetValue = 1,
        springParams = { frequency = 4, dampingRatio = 1 }
    },
    close = {
        targetValue = 0,
        springParams = { frequency = 2.6, dampingRatio = 1 }
    }
}

local var1 = Roact.PureComponent:extend("ContextualMenu")

var1.validateProps = t.strictInterface({
    buttonProps = validateButtonProps,
    zIndex = t.optional(t.integer),
    open = t.boolean,
    menuDirection = t.optional(MenuDirection.isEnumValue),
    openPositionY = t.UDim,
    closeBackgroundVisible = t.optional(t.boolean),
    screenSize = t.Vector2,
    stayOnActivated = t.optional(t.boolean),
    onDismiss = t.optional(t.callback),
    setFrameRef = t.optional(t.union(t.callback, t.table)),
    setFirstItemRef = t.optional(t.union(t.callback, t.table)),
    motorOverrideOptions = t.optional(
        t.strictInterface({ motorCallback = t.callback, open = validateMotorOptionProps, close = validateMotorOptionProps })
    ),
    horizontalAlignment = t.optional(t.enum(Enum.HorizontalAlignment)),
    openPositionX = t.optional(t.UDim),
    contextMenuWidthOverride = t.optional(t.UDim),
    anchorPointOverride = t.optional(t.Vector2),
    topElementRounded = t.optional(t.boolean),
    bottomElementRounded = t.optional(t.boolean),
    isElementBackgroundVisible = t.optional(t.boolean),
    isElementDividerVisible = t.optional(t.boolean),
    elementHeight = t.optional(t.number),
    borderCornerRadius = t.optional(t.integer),
    background = t.optional(validateColorInfo),
    enableTokenOverride = t.optional(t.boolean),
    renderHeader = t.optional(t.callback),
    headerHeight = t.optional(t.number),
    showDropShadow = t.optional(t.boolean),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    menuDirection = MenuDirection.Up,
    zIndex = 2,
    closeBackgroundVisible = true,
    horizontalAlignment = Enum.HorizontalAlignment.Center,
    openPositionX = UDim.new(0, 0)
}

function var1.init(arg1)
    arg1.wasDismissed = false

    local positionPercentBinding, positionPercentBindingUpdate = Roact.createBinding(0)
    arg1.positionPercentBinding = positionPercentBinding
    arg1.positionPercentBindingUpdate = positionPercentBindingUpdate

    arg1.motor = Otter.createSingleMotor(0)
    arg1.motor:onStep(arg1.positionPercentBindingUpdate)
    arg1.motor:onComplete(function()
        if not arg1.wasDismissed then
            return
        end

        arg1.wasDismissed = false
        if arg1.props.onDismiss then
            arg1.props.onDismiss()
        end
    end)

    arg1.motorType = Otter.spring
    arg1.motorOptions = motorOptions
    if arg1.props.motorOverrideOptions then
        arg1.motorType = arg1.props.motorOverrideOptions.motorCallback
        arg1.motorOptions = arg1.props.motorOverrideOptions
    end

    arg1.state = {
        absoluteSize = Vector2.new(0, 0),
        absolutePosition = Vector2.new(0, 0)
    }

    arg1.visibleBinding = arg1.positionPercentBinding:map(function(arg2): boolean
        return arg2 ~= 0
    end)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local x = 0.5
        local uDim = UDim.new(1, -24)
        local uDim2 = UDim.new(0, 0)
        local bool1 = arg1.state.absoluteSize.X > 640
        if bool1 then
            uDim = UDim.new(0, 300)
            uDim2 = arg1.props.openPositionX

            if arg1.props.horizontalAlignment == Enum.HorizontalAlignment.Left then
                x = 0
            elseif arg1.props.horizontalAlignment == Enum.HorizontalAlignment.Right then
                x = 1
            end
        end

        local y = if arg1.props.menuDirection == MenuDirection.Up then 1 else 0

        local overlayTransparency = arg2.Theme.Overlay.Transparency
        local backgroundTransparency = if arg1.props.closeBackgroundVisible then overlayTransparency else 1

        local width = arg1.props.contextMenuWidthOverride or uDim
        local anchorPoint = arg1.props.anchorPointOverride or Vector2.new(x, y)

        local vector2, _vector2 = GuiService:GetGuiInset()
        local var5 = arg1.state.absolutePosition + vector2

        local createElement = Roact.createElement
        local tbl2 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Visible = arg1.visibleBinding,
            ZIndex = arg1.props.zIndex
        }
        tbl2[Roact.Change.AbsoluteSize] = function(arg3)
            arg1:setState({ absoluteSize = arg3.AbsoluteSize })
        end

        tbl2[Roact.Change.AbsolutePosition] = function(arg3)
            arg1:setState({ absolutePosition = arg3.AbsolutePosition })
        end

        local tbl3 = { Background = 0, PositionFrame = 0 }
        local createElement2 = Roact.createElement
        local tbl4 = {
            ZIndex = 1,
            Text = "",
            BorderSizePixel = 0,
            BackgroundColor3 = arg2.Theme.Overlay.Color,
            BackgroundTransparency = backgroundTransparency,
            AutoButtonColor = false,
            Selectable = false,
            Position = UDim2.fromOffset(-var5.X, -var5.Y),
            Size = UDim2.fromOffset(arg1.props.screenSize.X, arg1.props.screenSize.Y)
        }
        tbl4[Roact.Event.Activated] = function()
            if not arg1.wasDismissed then
                arg1.wasDismissed = true
                arg1.motor:setGoal(arg1.motorType(arg1.motorOptions.close.targetValue, arg1.motorOptions.close.springParams))
            end
        end

        tbl3.Background = createElement2("TextButton", tbl4)

        tbl3.PositionFrame = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.new(uDim2.Scale, uDim2.Offset, arg1.props.openPositionY.Scale, arg1.props.openPositionY.Offset),
            ZIndex = 2
        }, {
            BaseMenu = Roact.createElement(BaseMenu, {
                buttonProps = arg1.props.buttonProps,
                setFirstItemRef = arg1.props.setFirstItemRef,
                setFrameRef = arg1.props.setFrameRef,
                width = width,
                position = arg1.positionPercentBinding:map(function(arg3): UDim2
                    local xScale = 0.5
                    if bool1 or arg1.props.anchorPointOverride then
                        if arg1.props.horizontalAlignment == Enum.HorizontalAlignment.Left then
                            xScale = 0
                        elseif arg1.props.horizontalAlignment == Enum.HorizontalAlignment.Right then
                            xScale = 1
                        end
                    end

                    if arg1.props.menuDirection == MenuDirection.Down then
                        return UDim2.fromScale(xScale, arg3 - 1)
                    end
                    return UDim2.fromScale(xScale, 1 - arg3)
                end),
                anchorPoint = anchorPoint,
                topElementRounded = arg1.props.topElementRounded,
                bottomElementRounded = arg1.props.bottomElementRounded,
                isElementBackgroundVisible = arg1.props.isElementBackgroundVisible,
                isElementDividerVisible = arg1.props.isElementDividerVisible,
                elementHeight = arg1.props.elementHeight,
                borderCornerRadius = arg1.props.borderCornerRadius,
                background = arg1.props.background,
                enableTokenOverride = arg1.props.enableTokenOverride,
                renderHeader = arg1.props.renderHeader,
                headerHeight = arg1.props.headerHeight,
                showDropShadow = arg1.props.showDropShadow,
                isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
            })
        })

        return createElement("Frame", tbl2, tbl3)
    end)
end

function var1.didMount(arg1)
    if arg1.props.open then
        arg1.wasDismissed = false
        arg1.motor:setGoal(arg1.motorType(arg1.motorOptions.open.targetValue, arg1.motorOptions.open.springParams))
    end
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.open == arg2.open then
        return
    end

    if arg1.props.open then
        arg1.wasDismissed = false
        arg1.motor:setGoal(arg1.motorType(arg1.motorOptions.open.targetValue, arg1.motorOptions.open.springParams))
        return
    end
    arg1.motor:setGoal(arg1.motorType(arg1.motorOptions.close.targetValue, arg1.motorOptions.close.springParams))
end

function var1.willUnmount(arg1)
    arg1.motor:destroy()
end

return var1
