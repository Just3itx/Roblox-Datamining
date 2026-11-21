-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local CoreGui = game:GetService("CoreGui")

local Roact = require(AuthCommonParent.Roact)
local UIBlox = require(AuthCommonParent.UIBlox)
local Foundation = require(AuthCommonParent.Foundation)
local GetTextSize = require(AuthCommonParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData
local CountryCodeSelector = require(AuthCommon.Components.CountryCodeSelector)

local var1 = Roact.Component:extend("PhoneNumberTextBox")

var1.defaultProps = { CountryCodeSize = 70, InnerPadding = 12 }

function var1.init(arg1)
    arg1:setState({ CountryCodeHover = false, CountryCodeSearchVisible = false })

    function arg1.CountryCodeMouseEnter()
        arg1:setState({ CountryCodeHover = true })
    end

    function arg1.CountryCodeMouseLeave()
        arg1:setState({ CountryCodeHover = false })
    end

    function arg1.OpenCountryCode()
        arg1:setState({ CountryCodeSearchVisible = true })

        if arg1.props.phoneCountryCodeSelectorCallback then
            arg1.props.phoneCountryCodeSelectorCallback(true)
        end
    end

    function arg1.CloseCountryCode()
        arg1:setState({ CountryCodeSearchVisible = false })

        if arg1.props.phoneCountryCodeSelectorCallback then
            arg1.props.phoneCountryCodeSelectorCallback(false)
        end
    end

    function arg1.SelectCountryCode(arg2)
        if arg1.props.SetCountryCode then
            arg1.props.SetCountryCode(arg2)
        end
        arg1.CloseCountryCode()
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local propsColor = arg1.props.Color
        local backgroundMutedColor = arg2.Theme.BackgroundMuted.Color
        local propsTransparency = arg1.props.Transparency
        local textSize = arg2.Font.BaseSize * arg2.Font.Body.RelativeSize
        local textDefaultColor = arg2.Theme.TextDefault.Color
        local textDefaultTransparency = arg2.Theme.TextDefault.Transparency
        local uiDefaultColor = arg2.Theme.UIDefault.Color
        local _placeholderText = arg1.props.PlaceholderText or ""
        local propsText = arg1.props.Text or ""
        local textInputType = arg1.props.TextInputTypeOverride or Enum.TextInputType.Phone

        local var4 = " +" .. arg1.props.CountryCode.prefix
        local xOffset = math.max(
            GetTextSize(var4, textSize, arg2.Tokens.Typography.BodyLarge.Font, Vector2.new(10000, 10000)).X + arg1.props.InnerPadding * 2,
            arg1.props.CountryCodeSize
        )

        local createElement = Roact.createElement
        local tbl1 = {
            Size = arg1.props.Size,
            Position = arg1.props.Position,
            AnchorPoint = arg1.props.AnchorPoint,
            LayoutOrder = arg1.props.LayoutOrder,
            BackgroundTransparency = 1,
            Text = "",
            [Roact.Event.MouseEnter] = arg1.props.onMouseEnter,
            [Roact.Event.MouseLeave] = arg1.props.onMouseLeave
        }
        local tbl2 = { InputWrapper = 0, CountryCodeButton = 0, Divider = 0, CountryCodePortal = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, -xOffset - 2, 1, 0),
            Position = UDim2.new(0, xOffset + 2, 0, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        }

        local tbl4 = {
            Background = Roact.createElement(ImageSetLabel, {
                Size = UDim2.new(1, 18, 1, 0),
                Position = UDim2.new(0, -18, 0, 0),
                BackgroundTransparency = 1,
                Image = GetImageData("LuaApp/buttons/buttonFill") or "LuaApp/buttons/buttonFill",
                ImageColor3 = propsColor,
                ImageTransparency = propsTransparency,
                BorderSizePixel = 0,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 9, 9)
            }),
            InputField = Roact.createElement("TextBox", {
                BackgroundTransparency = 1,
                ZIndex = 2,
                Size = UDim2.new(1, -arg1.props.InnerPadding * 2, 1, 0),
                Position = UDim2.new(0, arg1.props.InnerPadding, 0, 0),
                PlaceholderColor3 = uiDefaultColor,
                PlaceholderText = arg1.props.PlaceholderText,
                Text = propsText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = textDefaultColor,
                TextSize = textSize,
                TextInputType = textInputType,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                ClearTextOnFocus = false,
                [Roact.Event.Focused] = arg1.props.onFocused,
                [Roact.Event.FocusLost] = arg1.props.onFocusLost,
                [Roact.Change.Text] = arg1.props.onChangeText
            })
        }
        tbl2.InputWrapper = createElement2("Frame", tbl3, tbl4)

        tbl2.CountryCodeButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0, xOffset, 1, 0),
            ZIndex = 2,
            Text = "",
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            [Roact.Event.MouseEnter] = arg1.CountryCodeMouseEnter,
            [Roact.Event.MouseLeave] = arg1.CountryCodeMouseLeave,
            [Roact.Event.Activated] = arg1.OpenCountryCode
        }, {
            Background = Roact.createElement(ImageSetLabel, {
                Size = UDim2.new(1, 18, 1, 0),
                BackgroundTransparency = 1,
                Image = GetImageData("LuaApp/buttons/buttonFill") or "LuaApp/buttons/buttonFill",
                ImageColor3 = arg1.state.CountryCodeHover and backgroundMutedColor or propsColor,
                ImageTransparency = propsTransparency,
                BorderSizePixel = 0,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 9, 9)
            }),
            Prefix = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, -arg1.props.InnerPadding, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 2,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                Text = "<u>" .. var4 .. "</u>",
                TextSize = textSize,
                TextColor3 = textDefaultColor,
                TextTransparency = textDefaultTransparency,
                BackgroundTransparency = 1,
                RichText = true
            })
        })

        tbl2.Divider = Roact.createElement("Frame", {
            BackgroundColor3 = backgroundMutedColor,
            Size = UDim2.new(0, 2, 1, 0),
            Position = UDim2.new(0, xOffset, 0, 0),
            BackgroundTransparency = propsTransparency,
            BorderSizePixel = 0,
            ZIndex = 2
        })

        tbl2.CountryCodePortal = Roact.createElement(Roact.Portal, { target = CoreGui }, {
            CountryCodeSelectionGui = Roact.createElement(
                "ScreenGui",
                {
                    Enabled = true,
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                    DisplayOrder = 13
                },
                {
                    CountryCodeSelector = Roact.createElement(CountryCodeSelector, {
                        WidgetVisible = arg1.state.CountryCodeSearchVisible,
                        CloseCallback = arg1.CloseCountryCode,
                        SelectionCallback = arg1.SelectCountryCode
                    })
                }
            )
        })
        return createElement("TextButton", tbl1, tbl2)
    end)
end

return var1
