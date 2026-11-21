-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Cryo = require(AuthCommonParent.Cryo)
local UIBlox = require(AuthCommonParent.UIBlox)
local normalizeFontFace = require(AuthCommonParent.Foundation).Utility.normalizeFontFace

local Roact = require(AuthCommonParent.Roact)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData
local withStyle = UIBlox.Style.withStyle

local var1 = Roact.Component:extend("TextBoxStateWrapper")

var1.defaultProps = {
    IconSize = UDim2.new(1, 0, 1, 0),
    TextBoxLabelPadding = 12,
    InnerSidePadding = 0
}

function var1.init(arg1)
    arg1:setState({ Focused = false, Hover = false })

    function arg1.onMouseEnter()
        arg1:setState({ Hover = true })
    end

    function arg1.onMouseLeave()
        arg1:setState({ Hover = false })
    end

    function arg1.onFocused(...)
        arg1:setState({ Focused = true })

        if arg1.props.ChildProps.onFocused then
            arg1.props.ChildProps.onFocused(...)
        end
    end

    function arg1.onFocusLost(...)
        arg1:setState({ Focused = false })

        if arg1.props.ChildProps.onFocusLost then
            arg1.props.ChildProps.onFocusLost(...)
        end
    end
end

function var1.render(arg1)
    local helpComponent = arg1.props.HelpComponent
    local errorText = arg1.props.ErrorText
    local labelText = arg1.props.LabelText

    return withStyle(function(arg2)
        local uiDefaultColor = arg2.Theme.UIDefault.Color
        local uiDefaultTransparency = arg2.Theme.UIDefault.Transparency

        if arg1.props.ErrorState then
            uiDefaultColor = arg2.Theme.Alert.Color
            uiDefaultTransparency = arg2.Theme.Alert.Transparency
        elseif arg1.state.Focused then
            uiDefaultColor = arg2.Theme.IconEmphasis.Color
            uiDefaultTransparency = arg2.Theme.IconEmphasis.Transparency
        elseif arg1.state.Hover then
            uiDefaultColor = arg2.Theme.IconDefault.Color
            uiDefaultTransparency = arg2.Theme.IconDefault.Transparency
        end

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            AnchorPoint = arg1.props.AnchorPoint,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = arg1.props.LayoutOrder,
            Position = arg1.props.Position,
            Size = UDim2.fromScale(1, 0),
            [Roact.Change.AbsolutePosition] = arg1.props.onPositionChangedCallback
        }
        local tbl2 = {
            ListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, arg1.props.TextBoxLabelPadding)
            }),
            TextBoxLabel = labelText
                and Roact.createElement("TextLabel", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionLarge.Font),
                    LayoutOrder = 1,
                    Size = UDim2.fromScale(1, 0),
                    Text = labelText,
                    TextColor3 = arg2.Theme.TextEmphasis.Color,
                    TextSize = arg1.props.TextBoxLabelTextSize,
                    TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
            TextBox = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 2,
                Size = arg1.props.Size,
                [Roact.Ref] = arg1.props.buttonRef
            }, {
                Border = Roact.createElement(ImageSetLabel, {
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(9, 9, 9, 9),
                    Image = GetImageData("LuaApp/buttons/buttonStroke") or "LuaApp/buttons/buttonStroke",
                    ImageColor3 = uiDefaultColor,
                    ImageTransparency = uiDefaultTransparency
                }),
                TextBox = Roact.createElement(
                    arg1.props.ChildClass,
                    Cryo.Dictionary.join(arg1.props.ChildProps, {
                        Size = UDim2.new(1, 0, 1, 0),
                        onMouseEnter = arg1.onMouseEnter,
                        onMouseLeave = arg1.onMouseLeave,
                        onFocused = arg1.onFocused,
                        onFocusLost = arg1.onFocusLost
                    })
                ),
                IconWrapper = arg1.props.Icon
                    and Roact.createElement("Frame", {
                        Size = UDim2.new(1, 0, 1, 0),
                        Position = UDim2.new(1, -2, 0, 0),
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundTransparency = 1,
                        ZIndex = 2
                    }, {
                        AspectRatio = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1 }),
                        Icon = Roact.createElement(ImageSetLabel, {
                            Size = arg1.props.IconSize,
                            Position = UDim2.new(0.5, 0, 0.5, 0),
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundTransparency = 1,
                            Image = arg1.props.Icon,
                            ImageColor3 = uiDefaultColor,
                            ImageTransparency = uiDefaultTransparency
                        })
                    })
            }),
            ErrorText = 0,
            HelpComponentWrapper = 0
        }

        local var2 = errorText

        if var2 then
            var2 = Roact.createElement("TextLabel", {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font),
                LayoutOrder = 3,
                Size = UDim2.fromScale(1, 0),
                Text = errorText,
                TextColor3 = arg2.Theme.Alert.Color,
                TextSize = arg2.Font.CaptionBody.RelativeSize * arg2.Font.BaseSize,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left
            }, {
                Padding = not (arg1.props.InnerSidePadding == 0)
                    and Roact.createElement(
                        "UIPadding",
                        {
                            PaddingRight = UDim.new(0, arg1.props.InnerSidePadding),
                            PaddingLeft = UDim.new(0, arg1.props.InnerSidePadding)
                        }
                    )
            })
        end

        tbl2.ErrorText = var2

        local var3 = not errorText and helpComponent

        if var3 then
            var3 = Roact.createElement("Frame", {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 4,
                Size = UDim2.fromScale(1, 0)
            }, {
                Padding = not (arg1.props.InnerSidePadding == 0)
                    and Roact.createElement(
                        "UIPadding",
                        {
                            PaddingRight = UDim.new(0, arg1.props.InnerSidePadding),
                            PaddingLeft = UDim.new(0, arg1.props.InnerSidePadding)
                        }
                    ),
                HelpComponent = helpComponent
            })
        end

        tbl2.HelpComponentWrapper = var3
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
