-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)

local Roact = dependencies.Roact
local ImageSetLabel = dependencies.UIBlox.Core.ImageSet.ImageSetLabel
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace

local var1 = Roact.PureComponent:extend("CallbackInputBox")

local defaultProps = {
    initialInputText = "",
    inputTextFont = Enum.Font.BuilderSans,
    inputTextColor3 = Color3.new(1, 0, 1),
    inputTextSize = 14,
    inputTextYAlignment = Enum.TextYAlignment.Center,
    inputTextXAlignment = Enum.TextXAlignment.Center,
    inputTextTransparency = 0,
    placeholderTextTransparency = 0.6,
    placeholderTextColor3 = Color3.new(1, 0, 0),
    placeholderText = "Test placeholder text",
    clearIcon = "rbxasset://textures/ui/LuaChat/icons/ic-close-white.png",
    clearIconColor3 = Color3.new(1, 1, 0),
    clearIconTransparency = 0,
    clearButtonSize = 24,
    clipsDescendants = true,
    manualFocusRelease = false,
    captureFocusOnMount = false,
    multiLine = false,
    textWrapped = false,
    showCancelIconOnLoad = false,
    textInputType = Enum.TextInputType.Default,
    returnKeyType = Enum.ReturnKeyType.Default,
    inputBoxSelectionImageObject = nil,
    clearButtonSelectionImageObject = nil,
    clearButtonDisabled = nil,
    textChangedCallback = nil,
    focusChangedCallback = function() end,
    onSelectCallback = function() end,
    returnPressedFromOnScreenKeyboardCallback = function() end,
    inputBoxRef = nil
}
defaultProps[Roact.Change.AbsoluteSize] = function() end

var1.defaultProps = defaultProps

function var1.init(arg1)
    arg1.clearRef = Roact.createRef()
    arg1.inputBoxRef = arg1.props.inputBoxRef or Roact.createRef()

    arg1.inputText = arg1.props.initialInputText

    arg1.textChangedEventUnlocked = false

    function arg1.focusTextbox()
        arg1.props.onSelectCallback()
        if not arg1.inputBoxRef.current:IsFocused() then
            arg1.inputBoxRef.current:captureFocus()
        end
    end
end

function var1.render(arg1)
    local placeholderTextTransparency = arg1.props.placeholderTextTransparency
    local inputTextTransparency = arg1.props.inputTextTransparency
    local textTransparency = if arg1.inputText and arg1.inputText ~= "" then inputTextTransparency else placeholderTextTransparency
    local createElement = Roact.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl3 = {
        layout = Roact.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        inputBox = 0
    }

    local createElement2 = Roact.createElement
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        LayoutOrder = 1
    }
    local tbl5 = {
        layout = Roact.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        inputTextBox = 0,
        Clear = 0
    }

    local createElement3 = Roact.createElement
    local tbl6 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -arg1.props.clearButtonSize, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = arg1.props.inputTextColor3,
        TextSize = arg1.props.inputTextSize,
        TextTransparency = textTransparency,
        FontFace = normalizeFontFace(arg1.props.inputTextFont),
        PlaceholderText = arg1.props.placeholderText,
        PlaceholderColor3 = arg1.props.placeholderTextColor3,
        TextXAlignment = arg1.props.inputTextXAlignment,
        TextYAlignment = arg1.props.inputTextYAlignment,
        OverlayNativeInput = true,
        ClearTextOnFocus = false,
        ClipsDescendants = arg1.props.clipsDescendants,
        LayoutOrder = 1,
        ManualFocusRelease = arg1.props.manualFocusRelease,
        MultiLine = arg1.props.multiLine,
        TextWrapped = arg1.props.textWrapped,
        TextInputType = arg1.props.textInputType,
        ReturnKeyType = arg1.props.returnKeyType,
        SelectionImageObject = arg1.props.inputBoxSelectionImageObject,
        [Roact.Event.ReturnPressedFromOnScreenKeyboard] = arg1.props.returnPressedFromOnScreenKeyboardCallback,
        [Roact.Event.TouchTap] = arg1.focusTextbox
    }
    tbl6[Roact.Event.Focused] = function(arg2)
        if arg1.inputBoxRef.current and arg1.inputBoxRef.current.Text ~= "" then
            if arg1.clearRef.current and not arg1.props.clearButtonDisabled then
                arg1.clearRef.current.Visible = true
            end

            arg2.TextColor3 = arg1.props.inputTextColor3
            arg2.TextTransparency = inputTextTransparency
        else
            arg2.TextColor3 = arg1.props.placeholderTextColor3
            arg2.TextTransparency = placeholderTextTransparency
        end

        arg1.props.focusChangedCallback(true)
    end

    tbl6[Roact.Event.FocusLost] = function(arg2, arg3)
        if arg1.inputBoxRef.current and arg1.inputBoxRef.current.Text == "" then
            arg2.TextColor3 = arg1.props.placeholderTextColor3
            arg2.TextTransparency = placeholderTextTransparency
        end

        arg1.props.focusChangedCallback(false, arg3)
    end

    tbl6[Roact.Change.Text] = function(arg2)
        if arg2.Text ~= "" or arg1.textChangedEventUnlocked then
            if arg2.Text ~= "" then
                if arg1.clearRef.current and not arg1.props.clearButtonDisabled then
                    arg1.clearRef.current.Visible = true
                end

                arg2.TextColor3 = arg1.props.inputTextColor3
                arg2.TextTransparency = inputTextTransparency
            else
                if arg1.clearRef.current then
                    arg1.clearRef.current.Visible = false
                end

                arg2.TextColor3 = arg1.props.placeholderTextColor3
                arg2.TextTransparency = placeholderTextTransparency
            end

            arg1.inputText = arg2.Text

            if arg1.props.textChangedCallback then
                arg1.props.textChangedCallback(arg2.Text)
            end
        end

        arg1.textChangedEventUnlocked = true
    end

    tbl6[Roact.Ref] = arg1.inputBoxRef
    tbl6[Roact.Change.AbsoluteSize] = arg1.props[Roact.Change.AbsoluteSize]
    tbl5.inputTextBox = createElement3("TextBox", tbl6)

    local createElement4 = Roact.createElement
    local tbl7 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, arg1.props.clearButtonSize, 0, arg1.props.clearButtonSize),
        AutoButtonColor = false,
        LayoutOrder = 2,
        Visible = not arg1.props.clearButtonDisabled,
        SelectionImageObject = arg1.props.clearButtonSelectionImageObject,
        Selectable = arg1.clearRef.current and arg1.clearRef.current.Visible == true
    }
    tbl7[Roact.Event.Activated] = function()
        if arg1.inputBoxRef.current then
            arg1.inputBoxRef.current.Text = ""
        end

        arg1.inputText = ""

        if arg1.clearRef.current then
            arg1.clearRef.current.Visible = false
        end
    end
    local tbl8 = {
        layout = Roact.createElement("UIListLayout", { VerticalAlignment = "Center", HorizontalAlignment = "Center" }),
        Icon = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, arg1.props.clearButtonSize, 0, arg1.props.clearButtonSize),
            Image = arg1.props.clearIcon,
            ImageColor3 = arg1.props.clearIconColor3,
            ImageTransparency = arg1.props.clearIconTransparency,
            Visible = arg1.props.showCancelIconOnLoad,
            [Roact.Ref] = arg1.clearRef
        })
    }
    tbl5.Clear = createElement4("ImageButton", tbl7, tbl8)
    tbl3.inputBox = createElement2("Frame", tbl4, tbl5)
    return createElement("Frame", tbl2, tbl3)
end

function var1.didMount(arg1)
    if not arg1.inputBoxRef.current then
        return
    end

    arg1.inputBoxRef.current.Text = arg1.inputText

    if not arg1.props.captureFocusOnMount then
        return
    end

    spawn(function()
        if arg1.inputBoxRef and arg1.inputBoxRef.current then
            arg1.inputBoxRef.current:captureFocus()
        end
    end)
end

return var1
