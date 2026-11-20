-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParent.t)

local FitFrameOnAxis = require(scriptParentParentParentParent.FitFrame).FitFrameOnAxis

local Button = require(scriptParent.Button)
local ComboButton = require(scriptParent.ComboButton)
local IconButton = require(scriptParent.IconButton)
local TextButton = require(scriptParent.TextButton)
local ButtonType = require(scriptParent.Enum.ButtonType)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local IconSize = require(scriptParentParent.ImageSet.Enum.IconSize)
local getPageMargin = require(scriptParentParent.Container.getPageMargin)
local Constants = require(scriptParentParent.Style.Constants)

local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)

local var1 = Roact.PureComponent:extend("ActionBar")

function var1.init(arg1)
    arg1.buttonRefs = arg1.props.isRoactGamepadEnabled and RoactGamepad.createRefCache() or {}

    arg1.state = { frameWidth = 0 }

    arg1.frameRef = arg1.props.frameRef or Roact.createRef()

    function arg1.updateFrameSize(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        if absoluteSizeX ~= arg1.state.frameWidth then
            arg1:setState({ frameWidth = absoluteSizeX })
        end

        if arg1.props.onAbsoluteSizeChanged then
            arg1.props.onAbsoluteSizeChanged(arg2.AbsoluteSize)
        end
    end

    function arg1.getGamepadNextSelectionLeft(arg2, _)
        return arg2 > 1 and arg1.buttonRefs[arg2 - 1] or nil
    end

    function arg1.getGamepadNextSelectionRight(arg2, arg3)
        return arg2 < arg3 and arg1.buttonRefs[arg2 + 1] or nil
    end
end

local strictInterface = t.strictInterface
local tbl1 = {
    button = t.optional(
        t.union(t.strictInterface({ props = Button.validateProps }), t.strictInterface({ props = ComboButton.validateProps }))
    ),
    buttonOverride = t.optional(t.table),
    iconSize = t.optional(t.number),
    buttonHeight = t.optional(t.number),
    buttonPadding = t.optional(t.number),
    enableButtonAtStart = t.optional(t.boolean),
    icons = t.optional(t.array(t.strictInterface({ props = IconButton.validateProps }))),
    marginOverride = t.optional(t.strictInterface({ left = t.number, right = t.number, top = t.number, bottom = t.number })),
    horizontalAlignment = t.optional(t.enum(Enum.HorizontalAlignment)),
    onAbsoluteSizeChanged = t.optional(t.callback),
    [Roact.Children] = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    frameRef = t.optional(t.table),
    textButtons = t.optional(t.array(t.strictInterface({ props = TextButton.validateProps }))),
    isRoactGamepadEnabled = t.optional(t.boolean),
    testId = t.optional(t.string)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    horizontalAlignment = Enum.HorizontalAlignment.Center,
    iconSize = 36,
    buttonHeight = 48,
    buttonPadding = 12,
    isRoactGamepadEnabled = true,
    testId = "--uiblox-action-bar"
}

function var1.render(arg1)
    return withStyle(function(_)
        local pageMargin = getPageMargin(arg1.state.frameWidth)
        local var2 = arg1.state.frameWidth - pageMargin * 2
        local medium = IconSize.Medium

        local margin = not arg1.props.marginOverride
            and {
                left = pageMargin,
                right = pageMargin,
                top = 0,
                bottom = Constants.Layout.ActionBar.PositionOffset
            }
            or arg1.props.marginOverride

        local num1 = 0
        if arg1.props.icons then
            num1 = #arg1.props.icons and #arg1.props.icons or num1
        end

        local num2 = 0
        if arg1.props.textButtons then
            num2 = #arg1.props.textButtons and #arg1.props.textButtons or num2
        end

        local num3 = if arg1.props.button == nil and (not UIBloxConfig.enableActionBarButtonOverride or arg1.props.buttonOverride == nil) then 0 else 1
        local bool1 = arg1.props.enableButtonAtStart == true and num3 ~= 0
        local num4 = num2 + num1 + num3
        local tbl2 = {}

        if num1 ~= 0 then
            for i, icon in ipairs(arg1.props.icons) do
                if bool1 then
                    i = i + num3 or i
                end

                local var4 = Cryo.Dictionary.join({ layoutOrder = i, iconSize = medium }, icon.props)

                if not arg1.props.isRoactGamepadEnabled then
                    arg1.buttonRefs[i] = arg1.buttonRefs[i] or Roact.createRef()
                end

                local createElement = Roact.createElement
                local var5 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame"
                local tbl3 = {
                    key = "Button" .. tostring(i),
                    Size = UDim2.fromOffset(arg1.props.iconSize, arg1.props.iconSize),
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.buttonRefs[i],
                    NextSelectionUp = nil,
                    NextSelectionDown = nil,
                    NextSelectionLeft = arg1.getGamepadNextSelectionLeft(i, num4),
                    NextSelectionRight = arg1.getGamepadNextSelectionRight(i, num4),
                    inputBindings = if arg1.props.isRoactGamepadEnabled then {
                        Activated = if var4.onActivated then RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, var4.onActivated) or nil else nil
                    } else nil,
                    [React.Tag] = if arg1.props.testId then `data-testid={arg1.props.testId}--icon-button` else nil
                }
                table.insert(tbl2, createElement(var5, tbl3, { Icon = Roact.createElement(IconButton, var4) }))
            end
        end

        if num2 ~= 0 then
            for i, textButton in ipairs(arg1.props.textButtons) do
                if bool1 then
                    i += num3
                end

                local layoutOrder = i + num1

                local var5 = Cryo.Dictionary.join({ layoutOrder = layoutOrder }, textButton.props)

                if not arg1.props.isRoactGamepadEnabled then
                    arg1.buttonRefs[layoutOrder] = arg1.buttonRefs[layoutOrder] or Roact.createRef()
                end

                local createElement = Roact.createElement
                local var6 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame"
                local tbl3 = {
                    key = "Button" .. tostring(layoutOrder),
                    Size = UDim2.fromOffset(0, arg1.props.iconSize),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.buttonRefs[layoutOrder],
                    NextSelectionUp = nil,
                    NextSelectionDown = nil,
                    NextSelectionLeft = arg1.getGamepadNextSelectionLeft(layoutOrder, num4),
                    NextSelectionRight = arg1.getGamepadNextSelectionRight(layoutOrder, num4),
                    inputBindings = if arg1.props.isRoactGamepadEnabled then {
                        Activated = if var5.onActivated then RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, var5.onActivated) or nil else nil
                    } else nil
                }
                table.insert(tbl2, createElement(var6, tbl3, { TextButton = Roact.createElement(TextButton, var5) }))
            end
        end

        if num3 ~= 0 then
            local uDim2 = UDim2.fromOffset(var2 - num1 * (arg1.props.iconSize + arg1.props.buttonPadding), arg1.props.buttonHeight)

            local layoutOrder = if bool1 then 1 else num1 + 1
            local var4, var5

            if UIBloxConfig.enableActionBarButtonOverride and arg1.props.buttonOverride then
                var4 = nil
                var5 = nil
            else
                var4 = ComboButton.validateProps(arg1.props.button.props)
                var5 = Cryo.Dictionary.join({ layoutOrder = layoutOrder, size = uDim2 }, arg1.props.button.props)

                if not var4 and var5.buttonType == nil then
                    local buttonType = if num1 == 0 then ButtonType.PrimarySystem else ButtonType.PrimaryContextual
                    var5.buttonType = buttonType
                end
            end

            if not arg1.props.isRoactGamepadEnabled then
                arg1.buttonRefs[layoutOrder] = arg1.buttonRefs[layoutOrder] or Roact.createRef()
            end

            local num6 = if bool1 then 1 else num4
            local createElement = Roact.createElement
            local var6 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame"
            local tbl3 = {
                key = "Button" .. layoutOrder,
                Size = uDim2,
                BackgroundTransparency = 1,
                [Roact.Ref] = arg1.buttonRefs[layoutOrder],
                NextSelectionUp = nil,
                NextSelectionDown = nil,
                NextSelectionLeft = arg1.getGamepadNextSelectionLeft(layoutOrder, num4),
                NextSelectionRight = arg1.getGamepadNextSelectionRight(layoutOrder, num4),
                inputBindings = if arg1.props.isRoactGamepadEnabled then {
                    Activated = if var4 or UIBloxConfig.enableActionBarButtonOverride and arg1.props.buttonOverride then nil else RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, var5.onActivated)
                } else nil,
                [React.Tag] = if arg1.props.testId then `data-testid={arg1.props.testId}--primary-button` else nil
            }
            local tbl5 = {
                Icon = if UIBloxConfig.enableActionBarButtonOverride and arg1.props.buttonOverride then arg1.props.buttonOverride else Roact.createElement(if var4 then ComboButton else Button, var5)
            }
            table.insert(tbl2, num6, createElement(var6, tbl3, tbl5))
        end

        if arg1.props[Roact.Children] then
            tbl2 = arg1.props[Roact.Children]
        end

        return Roact.createElement(
            if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable[FitFrameOnAxis] else FitFrameOnAxis,
            {
                BackgroundTransparency = 1,
                minimumSize = UDim2.new(1, 0, 0, arg1.props.buttonHeight),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = arg1.props.horizontalAlignment,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                contentPadding = UDim.new(0, 12),
                [Roact.Ref] = arg1.frameRef,
                [Roact.Change.AbsoluteSize] = arg1.updateFrameSize,
                margin = margin,
                NextSelectionLeft = arg1.props.NextSelectionLeft,
                NextSelectionRight = arg1.props.NextSelectionRight,
                NextSelectionUp = arg1.props.NextSelectionUp,
                NextSelectionDown = arg1.props.NextSelectionDown
            },
            tbl2
        )
    end)
end

function var1.didMount(arg1)
    if arg1.frameRef.current then
        arg1.updateFrameSize(arg1.frameRef.current)
    end
end

local var2 = Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)

var2.validateProps = var1.validateProps

return var2
