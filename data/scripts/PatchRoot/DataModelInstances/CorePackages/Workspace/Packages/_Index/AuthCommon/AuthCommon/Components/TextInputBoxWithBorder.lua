-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)

local UIBlox = require(AuthCommonParent.UIBlox)
local normalizeFontFace = require(AuthCommonParent.Foundation).Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle

local PasswordBox = require(AuthCommon.Components.PasswordBox)
local GenericTextBox = require(AuthCommon.Components.GenericTextBox)
local AuthStatefulRoundCornerBorder = require(AuthCommon.Components.AuthStatefulRoundCornerBorder)

local GetFFlagEnableAuthStatefulTextInputUpdates = require(AuthCommonParent.SharedFlags).GetFFlagEnableAuthStatefulTextInputUpdates

local var1 = Roact.PureComponent:extend(script.Name)

var1.defaultProps = {
    text = "",
    textInputType = Enum.TextInputType.NoSuggestions,
    textInputHeight = 30,
    textInputListPadding = 12,
    borderState = AuthStatefulRoundCornerBorder.BorderState.Default
}

function var1.render(arg1)
    local text = arg1.props.text
    local textInputType = arg1.props.textInputType
    local textInputHeight = arg1.props.textInputHeight
    local offset = if GetFFlagEnableAuthStatefulTextInputUpdates() then arg1.props.textInputListPadding else 12

    local layoutOrder = arg1.props.layoutOrder
    local borderState = arg1.props.borderState
    local placeholderText = arg1.props.placeholderText
    local onChangeTextCallback = arg1.props.onChangeTextCallback
    local onFocused = arg1.props.onFocused
    local onFocusLost = arg1.props.onFocusLost
    local labelText = arg1.props.labelText
    local errorText = arg1.props.errorText

    local maxLength = arg1.props.maxLength
    local bool1 = arg1.props.textInputType == Enum.TextInputType.Password

    return withStyle(function(arg2)
        local font = arg2.Font.Body.Font
        local textSize = arg2.Font.BaseSize * arg2.Font.Body.RelativeSize
        local textDefaultColor = arg2.Theme.TextDefault.Color
        local textDefaultTransparency = arg2.Theme.TextDefault.Transparency
        local backgroundUiContrastColor = arg2.Theme.BackgroundUIContrast.Color
        local backgroundUiContrastTransparency = arg2.Theme.BackgroundUIContrast.Transparency
        local uiDefaultColor = arg2.Theme.UIDefault.Color
        local textEmphasisColor = arg2.Theme.TextEmphasis.Color

        if arg1.props.placeholderTextColor then
            uiDefaultColor = arg1.props.placeholderTextColor
        end
        if arg1.props.labelTextColor then
            textEmphasisColor = arg1.props.labelTextColor
        end
        if arg1.props.textBarColor then
            backgroundUiContrastColor = arg1.props.textBarColor
        end

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            Size = UDim2.new(1, 0, 0, 0)
        }
        local tbl2 = {
            ListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, offset)
            }),
            TextBoxLabel = labelText
                and Roact.createElement("TextLabel", {
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Text = labelText,
                    TextWrapped = true,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionLarge.Font),
                    TextSize = arg2.Font.BaseSize * arg2.Font.CaptionHeader.RelativeSize,
                    TextColor3 = textEmphasisColor,
                    TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
            TextBox = 0,
            ErrorText = 0
        }
        local createElement2 = Roact.createElement
        local var3 = AuthStatefulRoundCornerBorder
        local tbl3 = {
            size = UDim2.new(1, 0, 0, textInputHeight),
            layoutOrder = if GetFFlagEnableAuthStatefulTextInputUpdates() then 2 else layoutOrder,
            borderState = borderState
        }
        local tbl4 = {
            PasswordBox = bool1
                and Roact.createElement(PasswordBox, {
                    LayoutOrder = if GetFFlagEnableAuthStatefulTextInputUpdates() then nil else 2,
                    Size = UDim2.new(1, 0, 1, 0),
                    Color = backgroundUiContrastColor,
                    Transparency = backgroundUiContrastTransparency,
                    TextSize = textSize,
                    TextColor = textDefaultColor,
                    TextTransparency = textDefaultTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = text,
                    PlaceholderText = placeholderText,
                    PlaceholderColor3 = uiDefaultColor,
                    ManualFocusRelease = false,
                    CaptureFocusOnTapStart = true,
                    onChangeText = onChangeTextCallback
                }),
            GenericTextBox = 0
        }
        local bool2 = not bool1

        if bool2 then
            bool2 = Roact.createElement(GenericTextBox, {
                LayoutOrder = if GetFFlagEnableAuthStatefulTextInputUpdates() then nil else 2,
                Size = UDim2.new(1, 0, 1, 0),
                Text = text,
                Font = font,
                TextSize = textSize,
                TextColor = textDefaultColor,
                TextTransparency = textDefaultTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                Color = backgroundUiContrastColor,
                Transparency = backgroundUiContrastTransparency,
                TextInputType = textInputType,
                onChangeText = onChangeTextCallback,
                PlaceholderText = placeholderText,
                PlaceholderColor = uiDefaultColor,
                PaddingX = 12,
                onFocused = onFocused,
                onFocusLost = onFocusLost,
                TextBoxRef = if GetFFlagEnableAuthStatefulTextInputUpdates then arg1.props.textBoxRef else nil,
                maxLength = maxLength
            })
        end

        tbl4.GenericTextBox = bool2
        tbl2.TextBox = createElement2(var3, tbl3, tbl4)

        tbl2.ErrorText = errorText
            and Roact.createElement("TextLabel", {
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                Text = errorText,
                TextSize = arg2.Font.CaptionBody.RelativeSize * arg2.Font.BaseSize,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.TitleLarge.Font),
                TextColor3 = arg2.Theme.Alert.Color,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 0)
            })
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
