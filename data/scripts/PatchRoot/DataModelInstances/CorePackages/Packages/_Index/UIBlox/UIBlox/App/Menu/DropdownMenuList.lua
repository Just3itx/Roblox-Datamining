-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local BaseMenu = require(script.Parent.BaseMenu)
local validateButtonProps = require(script.Parent.validateButtonProps)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)

local var1 = Roact.PureComponent:extend("DropdownMenuList")

var1.validateProps = t.strictInterface({
    buttonProps = validateButtonProps,
    zIndex = t.optional(t.integer),
    open = t.boolean,
    showDropShadow = t.boolean,
    fixedListHeight = t.optional(t.number),
    openPositionY = t.UDim,
    closeBackgroundVisible = t.optional(t.boolean),
    screenSize = t.Vector2,
    onDismiss = t.optional(t.callback),
    buttonSize = t.UDim2,
    menuListBackground = t.optional(validateColorInfo),
    enableTokenOverride = t.optional(t.boolean),
    selectionOrder = t.optional(t.number),
    menuPositionFixed = t.optional(t.boolean)
})

var1.defaultProps = {
    zIndex = 2,
    closeBackgroundVisible = false,
    showDropShadow = false,
    fixedListHeight = nil,
    menuListBackground = nil,
    enableTokenOverride = false,
    menuPositionFixed = false
}

function var1.init(arg1)
    arg1:setState({ absolutePosition = Vector2.new(0, 0), visible = false })

    function arg1.setAbsolutePosition(arg2)
        arg1:setState({ absolutePosition = arg2.AbsolutePosition })
    end

    function arg1.dismissMenu()
        if arg1.state.visible then
            arg1:setState({ visible = false })

            arg1.props.onDismiss()
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local vector2, vector2_2 = GuiService:GetGuiInset()
        local var2 = arg1.state.absolutePosition + vector2

        local buttonSizeY = arg1.props.buttonSize.Y
        local buttonSizeX = arg1.props.buttonSize.X
        local num1, y

        if arg1.state.absolutePosition.Y > arg1.props.screenSize.Y / 2 then
            buttonSizeY = UDim.new(0, 0)
            num1 = -1
            y = 1
        else
            num1 = 1
            y = 0
        end

        local var3 = if num1 == 1 then buttonSizeY + arg1.props.openPositionY else buttonSizeY - arg1.props.openPositionY
        local uDim2 = UDim2.new(0, 0, var3.Scale, var3.Offset)

        if arg1.props.screenSize.X < 640 and not arg1.props.menuPositionFixed then
            uDim2 = UDim2.new(
                -arg1.props.buttonSize.X.Scale / 2,
                -var2.X + arg1.props.screenSize.X / 2 - arg1.props.buttonSize.X.Offset / 2,
                0,
                arg1.props.screenSize.Y - var2.Y - vector2_2.Y - 24
            )
            y = 1
        end

        local overlayTransparency = arg2.Theme.Overlay.Transparency
        local backgroundTransparency = if arg1.props.closeBackgroundVisible then overlayTransparency else 1

        local createElement = Roact.createElement
        local tbl1 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Visible = arg1.state.visible,
            ZIndex = arg1.props.zIndex,
            [Roact.Change.AbsolutePosition] = arg1.setAbsolutePosition
        }
        local tbl2 = {
            Background = Roact.createElement("TextButton", {
                ZIndex = 1,
                Text = "",
                BorderSizePixel = 0,
                BackgroundColor3 = arg2.Theme.Overlay.Color,
                BackgroundTransparency = backgroundTransparency,
                AutoButtonColor = false,
                Selectable = false,
                Position = UDim2.fromOffset(-var2.X, -var2.Y),
                Size = UDim2.fromOffset(arg1.props.screenSize.X, arg1.props.screenSize.Y),
                [Roact.Event.Activated] = arg1.dismissMenu
            }),
            PositionFrame = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Position = uDim2,
                    ZIndex = 2
                },
                {
                    BaseMenu = Roact.createElement(BaseMenu, {
                        buttonProps = arg1.props.buttonProps,
                        showDropShadow = arg1.props.showDropShadow,
                        fixedListHeight = arg1.props.fixedListHeight,
                        width = buttonSizeX,
                        position = UDim2.fromScale(0, 0),
                        anchorPoint = Vector2.new(0, y),
                        background = arg1.props.menuListBackground,
                        enableTokenOverride = arg1.props.enableTokenOverride,
                        selectionOrder = arg1.props.selectionOrder
                    })
                }
            )
        }
        return createElement("Frame", tbl1, tbl2)
    end)
end

function var1.didMount(arg1)
    if arg1.props.open then
        arg1:setState({ visible = true })
    end
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.open == arg2.open then
        return
    end

    if arg1.props.open then
        arg1:setState({ visible = true })
        return
    end

    arg1:setState({ visible = false })
end

return var1
