-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local TextButton = UIBlox.App.Button.TextButton

local var1 = Roact.PureComponent:extend("ReportActionSelection")

local function func1() end

var1.defaultProps = {
    isMuted = true,
    isBlocked = true,
    onCancelActivated = func1,
    onConfirmActivated = func1,
    ZIndex = 1,
    uiScale = 1.3
}

var1.validateProps = t.strictInterface({
    mutedTitleText = t.string,
    blockedTitleText = t.string,
    mutedAndBlockedTitleText = t.string,
    mutedSubtitleText = t.string,
    blockedSubtitleText = t.string,
    mutedAndBlockedSubtitleText = t.string,
    cancelText = t.string,
    confirmText = t.string,
    isMuted = t.boolean,
    isBlocked = t.boolean,
    onCancelActivated = t.callback,
    onConfirmActivated = t.callback,
    ZIndex = t.optional(t.number),
    uiScale = t.optional(t.number)
})

function var1.init(arg1)
    function arg1.onCancelActivated()
        arg1.props.onCancelActivated()
    end

    function arg1.onConfirmActivated()
        arg1.props.onConfirmActivated()
    end

    local var2 = nil
    local var3 = nil

    if arg1.props.isMuted and arg1.props.isBlocked then
        var2 = arg1.props.mutedAndBlockedTitleText
        var3 = arg1.props.mutedAndBlockedSubtitleText
    elseif arg1.props.isMuted then
        var2 = arg1.props.mutedTitleText
        var3 = arg1.props.mutedSubtitleText
    elseif arg1.props.isBlocked then
        var2 = arg1.props.blockedTitleText
        var3 = arg1.props.blockedSubtitleText
    end

    arg1:setState({ titleText = var2, subtitleText = var3 })
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                SystemPrimaryContent = {
                    Color = tokens.Color.ActionSubEmphasis.Foreground.Color3,
                    Transparency = tokens.Color.ActionSubEmphasis.Foreground.Transparency
                },
                TextEmphasis = {
                    Color = tokens.Color.Content.Emphasis.Color3,
                    Transparency = tokens.Color.Content.Emphasis.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                CaptionHeader = {
                    Font = tokens.Typography.CaptionLarge.Font,
                    RelativeSize = tokens.Typography.CaptionLarge.FontSize
                },
                Header1 = {
                    Font = tokens.Typography.HeadingSmall.Font,
                    RelativeSize = tokens.Typography.HeadingSmall.FontSize
                }
            }
        }
    end, function(arg2)
        local baseSize = arg2.Font.BaseSize

        return Roact.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
            ZIndex = arg1.props.ZIndex
        }, {
            uiScale = Roact.createElement("UIScale", { Scale = arg1.props.uiScale }),
            layout = Roact.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Top,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 22),
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            title = Roact.createElement("TextLabel", {
                Text = arg1.state.titleText,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                TextSize = arg2.Font.Header1.RelativeSize * baseSize,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.HeadingSmall.Font),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 1
            }),
            subtitle = Roact.createElement("TextLabel", {
                Size = UDim2.fromOffset(612, 0),
                Text = arg1.state.subtitleText,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                TextSize = arg2.Font.CaptionHeader.RelativeSize * baseSize,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionLarge.Font),
                TextWrapped = true,
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            }),
            spacer = Roact.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 62), LayoutOrder = 3 }),
            actions = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.fromOffset(584, 0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 4
                },
                {
                    layout = Roact.createElement("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = UDim.new(0, 70),
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    cancelContainer = Roact.createElement("Frame", {
                        BackgroundColor3 = arg2.Theme.SystemPrimaryContent.Color,
                        BackgroundTransparency = arg2.Theme.SystemPrimaryContent.Transparency,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(234, 44),
                        LayoutOrder = 1
                    }, {
                        uiCorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                        cancelButton = Roact.createElement(
                            TextButton,
                            {
                                size = UDim2.fromScale(1, 1),
                                text = arg1.props.cancelText,
                                onActivated = arg1.onCancelActivated
                            }
                        )
                    }),
                    confirmContainer = Roact.createElement("Frame", {
                        BackgroundColor3 = UIBlox.App.Style.Colors.Blue,
                        BackgroundTransparency = 0,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(234, 44),
                        LayoutOrder = 2
                    }, {
                        uiCorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                        confirmButton = Roact.createElement(
                            TextButton,
                            {
                                size = UDim2.fromScale(1, 1),
                                text = arg1.props.confirmText,
                                onActivated = arg1.onConfirmActivated
                            }
                        )
                    })
                }
            )
        })
    end)
end

return var1
