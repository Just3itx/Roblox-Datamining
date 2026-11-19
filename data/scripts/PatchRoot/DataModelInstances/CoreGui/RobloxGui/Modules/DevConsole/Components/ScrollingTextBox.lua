-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.Component:extend("ScrollingTextBox")

function var1.init(arg1, arg2)
    local vector2 = TextService:GetTextSize("A", arg2.TextSize, arg2.Font, Vector2.new(0, 0))

    function arg1.adjustOffset()
        if not arg1.clipBox.current or not arg1.textboxRef.current then
            return
        end

        local fontDims = arg1.state.fontDims
        local var2 = arg1.textboxRef.current.CursorPosition - 1
        local var3 = var2 - math.ceil(arg1.state.innerXOffset / fontDims.X)

        local num1 = math.floor(arg1.clipBox.current.AbsoluteSize.X * 0.9 / fontDims.X)

        if num1 < var3 then
            local innerXOffset = (var2 - num1) * fontDims.X
            arg1:setState({ innerXOffset = innerXOffset })
        elseif var3 < 0 then
            local innerXOffset = var2 * fontDims.X
            arg1:setState({ innerXOffset = innerXOffset })
        end
    end

    arg1.clipBox = Roact.createRef()
    arg1.textboxRef = arg1.props.forwardRef or Roact.createRef()

    arg1.state = { fontDims = vector2, innerXOffset = 0 }
end

function var1.didMount(arg1)
    if arg1.onFocusConnection then
        return
    end

    arg1.onFocusConnection = UserInputService.InputBegan:Connect(function(input: InputObject)
        if not arg1.textboxRef.current or not arg1.textboxRef.current:IsFocused() then
            return
        end

        if input.KeyCode == Enum.KeyCode.Home then
            arg1.textboxRef.current.CursorPosition = 0
            return
        end

        if input.KeyCode == Enum.KeyCode.End then
            arg1.textboxRef.current.CursorPosition = #arg1.textboxRef.current.text + 1
            return
        end
        arg1.adjustOffset()
    end)
end

function var1.willUnmount(arg1)
    if arg1.onFocusConnection then
        arg1.onFocusConnection:Disconnect()
        arg1.onFocusConnection = nil
    end
end

function var1.render(arg1)
    local propsPosition = arg1.props.Position
    local propsSize = arg1.props.Size
    local placeholderText = arg1.props.PlaceholderText

    local textColor3 = arg1.props.TextColor3
    local textSize = arg1.props.TextSize
    local font = arg1.props.Font
    local propsText = arg1.props.Text

    local clearTextOnFocus = arg1.props.ClearTextOnFocus
    local showNativeInput = arg1.props.ShowNativeInput

    local textBoxFocusLost = arg1.props.TextBoxFocusLost

    local innerXOffset = arg1.state.innerXOffset

    local createElement = Roact.createElement
    local tbl1 = {
        Position = propsPosition,
        Size = propsSize,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        [Roact.Ref] = arg1.clipBox
    }
    local tbl2 = {
        TextBox = Roact.createElement("TextBox", {
            Position = UDim2.new(0, -innerXOffset, 0, 0),
            Size = UDim2.new(1, innerXOffset, 1, 0),
            BackgroundTransparency = 1,
            ShowNativeInput = showNativeInput,
            ClearTextOnFocus = clearTextOnFocus,
            TextColor3 = textColor3,
            TextXAlignment = 0,
            TextSize = textSize,
            Text = propsText,
            Font = font,
            PlaceholderText = placeholderText,
            [Roact.Ref] = arg1.textboxRef,
            [Roact.Change.CursorPosition] = arg1.adjustOffset,
            [Roact.Event.FocusLost] = textBoxFocusLost
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
