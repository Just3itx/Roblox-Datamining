-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local RoactRodux = require(AuthCommonParent.RoactRodux)
local RoactAppExperiment = require(AuthCommonParent.RoactAppExperiment)

local Roact = require(AuthCommonParent.Roact)
local UIBlox = require(AuthCommonParent.UIBlox)
local normalizeFontFace = require(AuthCommonParent.Foundation).Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData

local AreaTest = require(AuthCommon.Utils.AreaTest)

local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local GetFFlagLuaAppFixSelectionCursor = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppFixSelectionCursor

local GetFFlagEnableTextFieldContentType = require(AuthCommonParent.SharedFlags).GetFFlagEnableTextFieldContentType

local GetFFlagLuaAppEnableOpenTypeSupport = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local engineFeature = game:GetEngineFeature("GuiObjectInputSink")

local bool1 = game:DefineFastFlag("EnableKeyboardVisibilityCheckOnPasswordFocus", false)

local engineFeature2 = game:GetEngineFeature("EnableAndroidPasswordSuggestion")

local FFlagAndroidPasswordSuggestionExperimentEnrollmentBypass = require(AuthCommonParent.SharedFlags).FFlagAndroidPasswordSuggestionExperimentEnrollmentBypass

local FStringLuaMultiPageSignupIxpLayer = require(AuthCommonParent.SharedFlags).FStringLuaMultiPageSignupIxpLayer

local var1 = Roact.PureComponent:extend("PasswordBox")

function var1.init(arg1)
    arg1.state = {
        hidePassword = true,
        containerSize = Vector2.new(0, 0)
    }

    function arg1.getHidePassword()
        return if arg1.props.hidePassword == nil then arg1.state.hidePassword else arg1.props.hidePassword
    end

    arg1.isMounted = false
    arg1.passwordBoxRef = Roact.createRef()

    local ref = Roact.createRef()
    function arg1.getPasswordTextBoxRef()
        return arg1.props.TextBoxRef or ref
    end

    function arg1.isTouchPositionInPasswordBox(arg2)
        if not arg1.passwordBoxRef.current then
            return false
        end

        local absolutePosition = arg1.passwordBoxRef.current.AbsolutePosition
        local absoluteSize = arg1.passwordBoxRef.current.AbsoluteSize

        return AreaTest.IsPointInRect(Rect.new(absolutePosition, absolutePosition + absoluteSize), arg2)
    end

    arg1.tapBeganInTextbox = false
    function arg1.tapEventBegan(arg2, _)
        if arg1.props.CentralOverlayBlocksInput and arg1.props.centralOverlay and arg1.props.centralOverlay.OverlayType ~= nil
            or bool1 and not UserInputService.OnScreenKeyboardVisible
        then
            return
        end

        arg1.tapBeganInTextbox = arg1.isTouchPositionInPasswordBox(arg2)
        local current = arg1.getPasswordTextBoxRef().current
        local textBox = UserInputService:GetFocusedTextBox()

        if not current or textBox == current or not arg1.tapBeganInTextbox or not arg1.props.CaptureFocusOnTapStart then
            return
        end

        if textBox then
            textBox:ReleaseFocus()
        end

        current:CaptureFocus()
    end

    function arg1.tapEventEnded(arg2, _)
        if arg1.tapBeganInTextbox then
            arg1.tapBeganInTextbox = false
            return
        end

        local textBox = UserInputService:GetFocusedTextBox()
        local current = arg1.getPasswordTextBoxRef().current

        if not textBox or textBox ~= current then
            return
        end

        if not arg1.isTouchPositionInPasswordBox(arg2) then
            current:ReleaseFocus()
        end
    end

    function arg1.onAbsoluteSizeChanged(arg2)
        local containerSize = arg1.state.containerSize
        local absoluteSize = arg2.AbsoluteSize
        if not (absoluteSize.X > 0) or not (absoluteSize.Y > 0) or containerSize == absoluteSize then
            return
        end

        spawn(function()
            if arg1.isMounted then
                arg1:setState({ containerSize = absoluteSize })
            end
        end)
    end

    function arg1.onTogglerActivated(_)
        local onToggleCallback = arg1.props.onToggleCallback
        local hidePassword = arg1.getHidePassword()

        if onToggleCallback then
            onToggleCallback(hidePassword)
        end

        if arg1.isMounted then
            arg1:setState({ hidePassword = not hidePassword })
        end
    end

    function arg1.shouldTakeInput(arg2): boolean
        if arg1.props.Disabled then
            return false
        end

        local bool2 = arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch
        return not arg1.props.ManualFocusRelease and bool2
    end
end

var1.defaultProps = {
    TextXAlignment = Enum.TextXAlignment.Left,
    PaddingX = 10,
    PaddingY = 7,
    ClearTextOnFocus = false,
    IsKeyboardOverlayUsed = true
}

function var1.didMount(arg1)
    arg1.isMounted = true

    if not arg1.props.IsKeyboardOverlayUsed then
        return
    end

    arg1.inputBeganConnection = UserInputService.InputBegan:connect(function(input: InputObject, gameProcessedEvent: boolean)
        if arg1.shouldTakeInput(input) then
            arg1.tapEventBegan(input.Position, gameProcessedEvent)
        end
    end)

    arg1.inputEndedConnection = UserInputService.InputEnded:connect(function(input: InputObject, gameProcessedEvent: boolean)
        if arg1.shouldTakeInput(input) then
            arg1.tapEventEnded(input.Position, gameProcessedEvent)
        end
    end)
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    if not arg1.props.IsKeyboardOverlayUsed then
        return
    end

    if arg1.inputBeganConnection then
        arg1.inputBeganConnection:disconnect()
    end
    if arg1.inputEndedConnection then
        arg1.inputEndedConnection:disconnect()
    end
end

function var1.render(arg1)
    if GetFFlagLuaAppFixSelectionCursor() then
        return withSelectionCursorProvider(function(arg2)
            return arg1:renderWithSelectionCursor(arg2)
        end)
    end
    return arg1:renderWithSelectionCursor(nil)
end

function var1.renderWithSelectionCursor(arg1, arg2)
    local propsSize = arg1.props.Size
    local propsPosition = arg1.props.Position
    local layoutOrder = arg1.props.LayoutOrder
    local propsText = arg1.props.Text
    local textSize = arg1.props.TextSize
    local placeholderText = arg1.props.PlaceholderText
    local textXAlignment = arg1.props.TextXAlignment
    local textColor = arg1.props.TextColor
    local placeholderColor = arg1.props.PlaceholderColor
    local clearTextOnFocus = arg1.props.ClearTextOnFocus

    local propsColor = arg1.props.Color
    local propsTransparency = arg1.props.Transparency
    local textTransparency = arg1.props.TextTransparency

    local returnKeyType = arg1.props.ReturnKeyType

    local nextSelectionDown = arg1.props.NextSelectionDown
    local nextSelectionLeft = arg1.props.NextSelectionLeft
    local nextSelectionRight = arg1.props.NextSelectionRight
    local nextSelectionUp = arg1.props.NextSelectionUp

    local paddingX = arg1.props.PaddingX
    local paddingY = arg1.props.PaddingY

    local hidePassword = arg1.getHidePassword()
    local containerSizeY = arg1.state.containerSize.Y
    local onFocused = arg1.props.onFocused
    local onFocusLost = arg1.props.onFocusLost
    local onMouseEnter = arg1.props.onMouseEnter
    local onMouseLeave = arg1.props.onMouseLeave

    local enablePasswordSuggestion = arg1.props.IsNewPassword and arg1.props.enablePasswordSuggestion
    local var2 = enablePasswordSuggestion and engineFeature2 and Enum.TextInputType.NewPassword or Enum.TextInputType.Password
    local var3 = enablePasswordSuggestion and engineFeature2 and Enum.TextInputType.NewPasswordShown
        or GetFFlagEnableTextFieldContentType() and Enum.TextInputType.PasswordShown
        or Enum.TextInputType.NoSuggestions

    return withStyle(function(arg3)
        local selectionImageObject = if GetFFlagLuaAppFixSelectionCursor() then arg2(CursorKind.InputButton) else nil
        local createElement = Roact.createElement
        local var5 = ImageSetLabel
        local tbl1 = {
            Size = propsSize,
            Position = propsPosition,
            LayoutOrder = layoutOrder,
            BackgroundTransparency = 1,
            Image = GetImageData("LuaApp/buttons/buttonFill") or "LuaApp/buttons/buttonFill",
            ImageColor3 = propsColor,
            ImageTransparency = propsTransparency,
            BorderSizePixel = 0,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            [Roact.Ref] = arg1.passwordBoxRef,
            [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged
        }
        local tbl2 = { TextBoxContainer = 0, Toggler = 0 }
        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, -containerSizeY, 1, 0),
            BackgroundTransparency = 1
        }
        local tbl4 = {
            TextBox = Roact.createElement("TextBox", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Text = propsText,
                PlaceholderText = placeholderText,
                PlaceholderColor3 = placeholderColor,
                FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
                InputSink = if engineFeature then Enum.InputSink.None else nil,
                OpenTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getPasswordStylisticAlternative() else nil,
                TextSize = textSize,
                TextColor3 = textColor,
                TextTransparency = textTransparency,
                TextXAlignment = textXAlignment,
                TextYAlignment = Enum.TextYAlignment.Center,
                BackgroundTransparency = 1,
                ClearTextOnFocus = clearTextOnFocus,
                OverlayNativeInput = true,
                ManualFocusRelease = arg1.props.IsKeyboardOverlayUsed,
                ClipsDescendants = true,
                TextInputType = hidePassword and var2 or var3,
                ReturnKeyType = returnKeyType,
                NextSelectionDown = nextSelectionDown,
                NextSelectionLeft = nextSelectionLeft,
                NextSelectionRight = nextSelectionRight,
                NextSelectionUp = nextSelectionUp,
                SelectionImageObject = selectionImageObject,
                [Roact.Ref] = arg1.getPasswordTextBoxRef(),
                [Roact.Change.Text] = arg1.props.onChangeText,
                [Roact.Event.ReturnPressedFromOnScreenKeyboard] = arg1.props.onReturnPressedFromOnScreenKeyboard,
                [Roact.Event.Focused] = onFocused,
                [Roact.Event.FocusLost] = onFocusLost,
                [Roact.Event.MouseEnter] = onMouseEnter,
                [Roact.Event.MouseLeave] = onMouseLeave
            }),
            UIPadding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, paddingY),
                PaddingBottom = UDim.new(0, paddingY),
                PaddingLeft = UDim.new(0, paddingX),
                PaddingRight = UDim.new(0, paddingX)
            })
        }
        tbl2.TextBoxContainer = createElement2(str1, tbl3, tbl4)

        local createElement3 = Roact.createElement
        local str2 = "TextButton"
        local tbl5 = {
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, containerSizeY, 1, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            Text = "",
            BackgroundTransparency = 1,
            SelectionImageObject = selectionImageObject,
            [Roact.Event.Activated] = arg1.onTogglerActivated
        }
        local tbl6 = {
            ImageLabel = Roact.createElement(ImageSetLabel, {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = if hidePassword then GetImageData("LuaApp/icons/actions_privacy_show") or "LuaApp/icons/actions_privacy_show" else GetImageData("LuaApp/icons/actions_edit_hide") or "LuaApp/icons/actions_edit_hide",
                ImageColor3 = arg3.Theme.IconDefault.Color,
                ImageTransparency = arg3.Theme.IconDefault.Transparency
            })
        }
        tbl2.Toggler = createElement3(str2, tbl5, tbl6)
        return createElement(var5, tbl1, tbl2)
    end)
end

local var2 = RoactRodux.connect(function(arg1, _)
    return {
        centralOverlay = arg1.CentralOverlay
    }
end)(var1)

if engineFeature2 then
    var2 = RoactAppExperiment.connectBrowserTrackerLayer({ FStringLuaMultiPageSignupIxpLayer }, function(arg1, _)
        return {
            enablePasswordSuggestion = (arg1[FStringLuaMultiPageSignupIxpLayer] or {}).enablePasswordSuggestion
                or FFlagAndroidPasswordSuggestionExperimentEnrollmentBypass
                or false
        }
    end)(var2)
end

return var2
