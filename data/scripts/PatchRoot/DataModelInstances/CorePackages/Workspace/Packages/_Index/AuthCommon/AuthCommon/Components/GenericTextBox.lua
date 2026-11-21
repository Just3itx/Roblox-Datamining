-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Roact = require(AuthCommonParent.Roact)
local UIBlox = require(AuthCommonParent.UIBlox)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData

local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local GetFFlagLuaAppFixSelectionCursor = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppFixSelectionCursor

local var1 = Roact.PureComponent:extend("GenericTextBox")
local GetFFlagLuaAppEnableOpenTypeSupport = require(AuthCommonParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local engineFeature = game:GetEngineFeature("EnableAndroidPasswordSuggestion")

var1.defaultProps = { PaddingX = 0, PaddingY = 0 }

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
    local font = arg1.props.Font
    local textSize = arg1.props.TextSize
    local placeholderText = arg1.props.PlaceholderText
    local textXAlignment = arg1.props.TextXAlignment
    local textColor = arg1.props.TextColor
    local placeholderColor = arg1.props.PlaceholderColor
    local clearTextOnFocus = arg1.props.ClearTextOnFocus
    local textInputType = arg1.props.TextInputType
    local returnKeyType = arg1.props.ReturnKeyType
    local manualFocusRelease = arg1.props.ManualFocusRelease

    local nextSelectionDown = arg1.props.NextSelectionDown
    local nextSelectionLeft = arg1.props.NextSelectionLeft
    local nextSelectionRight = arg1.props.NextSelectionRight
    local nextSelectionUp = arg1.props.NextSelectionUp

    local propsColor = arg1.props.Color
    local propsTransparency = arg1.props.Transparency
    local textTransparency = arg1.props.TextTransparency
    local maxLength = arg1.props.maxLength
    local onChangeText = arg1.props.onChangeText
    local onAncestryChanged = arg1.props.onAncestryChanged
    local onReturnPressedFromOnScreenKeyboard = arg1.props.onReturnPressedFromOnScreenKeyboard
    local onFocused = arg1.props.onFocused
    local onFocusLost = arg1.props.onFocusLost
    local onMouseEnter = arg1.props.onMouseEnter
    local onMouseLeave = arg1.props.onMouseLeave

    local paddingX = arg1.props.PaddingX
    local paddingY = arg1.props.PaddingY

    local textBoxRef = arg1.props.TextBoxRef
    local selectionImageObject = if GetFFlagLuaAppFixSelectionCursor() then arg2(CursorKind.InputButton) else nil
    local var3 = nil
    if GetFFlagLuaAppEnableOpenTypeSupport() then
        if arg1.props.openTypeFeatures ~= nil then
            var3 = arg1.props.openTypeFeatures
        elseif textInputType == Enum.TextInputType.Password
            or textInputType == Enum.TextInputType.PasswordShown
            or textInputType == Enum.TextInputType.OneTimePassword
            or engineFeature and textInputType == Enum.TextInputType.NewPassword
            or engineFeature and textInputType == Enum.TextInputType.NewPasswordShown
        then
            var3 = OpenTypeSupport:getPasswordStylisticAlternative()
        elseif textInputType == Enum.TextInputType.Username then
            var3 = OpenTypeSupport:getUserNameStylisticAlternative()
        end
    else
        var3 = nil
    end

    local createElement = Roact.createElement
    local var4 = ImageSetLabel
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
        SliceCenter = Rect.new(8, 8, 9, 9)
    }
    local tbl2 = {
        UIPadding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0, paddingY),
            PaddingBottom = UDim.new(0, paddingY),
            PaddingLeft = UDim.new(0, paddingX),
            PaddingRight = UDim.new(0, paddingX)
        }),
        TextBox = 0
    }
    local createElement2 = Roact.createElement
    local tbl3 = {
        Size = nil,
        Size = nil,
        Size = nil,
        Size = nil,
        Size = nil,
        Size = nil,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Text = propsText,
        PlaceholderText = placeholderText,
        PlaceholderColor3 = placeholderColor,
        Font = font,
        TextSize = textSize,
        TextColor3 = textColor,
        TextTransparency = textTransparency,
        TextXAlignment = textXAlignment,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundTransparency = 1,
        ClearTextOnFocus = clearTextOnFocus,
        OverlayNativeInput = true,
        ClipsDescendants = true,
        TextInputType = textInputType,
        ReturnKeyType = returnKeyType,
        ManualFocusRelease = manualFocusRelease,
        NextSelectionDown = nextSelectionDown,
        NextSelectionLeft = nextSelectionLeft,
        NextSelectionRight = nextSelectionRight,
        NextSelectionUp = nextSelectionUp,
        SelectionImageObject = selectionImageObject,
        OpenTypeFeatures = var3 or nil,
        RichText = if var3 then true else nil,
        [Roact.Ref] = textBoxRef
    }

    tbl3[Roact.Change.Text] = function(arg3) -- name: handleTextChanged
        if maxLength then
            local str1 = string.sub(arg3.Text, 1, maxLength)
            if str1 ~= arg3.Text then
                arg3.Text = str1
                return
            end
        end
        if onChangeText then
            onChangeText(arg3)
        end
    end

    tbl3[Roact.Event.AncestryChanged] = onAncestryChanged
    tbl3[Roact.Event.ReturnPressedFromOnScreenKeyboard] = onReturnPressedFromOnScreenKeyboard
    tbl3[Roact.Event.Focused] = onFocused
    tbl3[Roact.Event.FocusLost] = onFocusLost
    tbl3[Roact.Event.MouseEnter] = onMouseEnter
    tbl3[Roact.Event.MouseLeave] = onMouseLeave
    tbl2.TextBox = createElement2("TextBox", tbl3)
    return createElement(var4, tbl1, tbl2)
end

return var1
