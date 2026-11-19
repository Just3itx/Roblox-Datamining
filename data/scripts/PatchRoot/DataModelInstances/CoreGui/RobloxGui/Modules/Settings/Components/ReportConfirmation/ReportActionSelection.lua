-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local TextButton = UIBlox.App.Button.TextButton

local CheckboxRow = require(script.Parent.CheckboxRow)

local var1 = Roact.PureComponent:extend("ReportActionSelection")

local function func1() end

var1.defaultProps = {
    titleText = "Thanks for your report!",
    subtitleText = "We've received your report and will take action soon if needed. Your feedback helps keep our community safe.",
    instructionText = "Other steps you can take:",
    muteText = "Mute {DISPLAYNAME}(@username)",
    blockText = "Block {DISPLAYNAME}(@username)",
    doneText = "Done",
    showVoiceMuting = true,
    isVoiceMuted = false,
    isBlocked = false,
    onMuteCheckboxActivated = func1,
    onBlockCheckboxActivated = func1,
    onDoneActivated = func1,
    ZIndex = 1,
    uiScale = 1.3
}

var1.validateProps = t.interface({
    titleText = t.string,
    subtitleText = t.string,
    instructionText = t.string,
    muteText = t.string,
    blockText = t.string,
    doneText = t.string,
    showVoiceMuting = t.boolean,
    isVoiceMuted = t.optional(t.boolean),
    isBlocked = t.optional(t.boolean),
    onMuteCheckboxActivated = t.optional(t.callback),
    onBlockCheckboxActivated = t.optional(t.callback),
    onDoneActivated = t.callback,
    ZIndex = t.number
})

function var1.init(arg1)
    function arg1.onMuteCheckboxActivated(isVoiceMuted)
        arg1:setState({ isVoiceMuted = isVoiceMuted })

        arg1.props.onMuteCheckboxActivated(isVoiceMuted)
    end

    function arg1.onBlockCheckboxActivated(isBlocked)
        arg1:setState({ isBlocked = isBlocked })

        arg1.props.onBlockCheckboxActivated(isBlocked)
    end

    function arg1.onDoneActivated()
        arg1.props.onDoneActivated(arg1.state.isBlocked, arg1.state.isVoiceMuted)
    end

    arg1:setState({ isVoiceMuted = arg1.props.isVoiceMuted, isBlocked = arg1.props.isBlocked })
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                Divider = {
                    Color = tokens.Color.Stroke.Emphasis.Color3,
                    Transparency = tokens.Color.Stroke.Emphasis.Transparency
                },
                SystemPrimaryContent = {
                    Color = tokens.Color.ActionSubEmphasis.Foreground.Color3,
                    Transparency = tokens.Color.ActionSubEmphasis.Foreground.Transparency
                },
                TextDefault = {
                    Color = tokens.Color.Content.Default.Color3,
                    Transparency = tokens.Color.Content.Default.Transparency
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
                Text = arg1.props.titleText,
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
                Text = arg1.props.subtitleText,
                TextColor3 = arg2.Theme.TextEmphasis.Color,
                TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                TextSize = arg2.Font.CaptionHeader.RelativeSize * baseSize,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionLarge.Font),
                TextWrapped = true,
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            }),
            actions = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.fromOffset(584, 0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 3
                },
                {
                    layout = Roact.createElement("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = UDim.new(0, 18),
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    instruction = Roact.createElement("TextLabel", {
                        Size = UDim2.fromScale(1, 0),
                        Text = arg1.props.instructionText,
                        TextColor3 = arg2.Theme.TextDefault.Color,
                        TextTransparency = arg2.Theme.TextDefault.Transparency,
                        TextSize = arg2.Font.CaptionHeader.RelativeSize * baseSize,
                        FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionLarge.Font),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 1
                    }),
                    muteCheckbox = arg1.props.showVoiceMuting
                        and Roact.createElement(CheckboxRow, {
                            height = 28,
                            image = "icons/controls/microphone",
                            descriptionText = arg1.props.muteText,
                            actionDisabled = arg1.state.isBlocked,
                            checkboxSelected = arg1.state.isBlocked or arg1.state.isVoiceMuted,
                            onCheckboxActivated = arg1.onMuteCheckboxActivated,
                            LayoutOrder = 2
                        }),
                    div = arg1.props.showVoiceMuting
                        and Roact.createElement("Frame", {
                            Size = UDim2.new(1, 0, 0, 1),
                            BackgroundColor3 = arg2.Theme.Divider.Color,
                            BackgroundTransparency = arg2.Theme.Divider.Transparency,
                            BorderSizePixel = 0,
                            LayoutOrder = 3
                        }),
                    blockCheckbox = Roact.createElement(CheckboxRow, {
                        height = 28,
                        image = "icons/actions/block",
                        descriptionText = arg1.props.blockText,
                        checkboxSelected = arg1.state.isBlocked,
                        onCheckboxActivated = arg1.onBlockCheckboxActivated,
                        LayoutOrder = 4
                    }),
                    doneContainer = Roact.createElement("Frame", {
                        BackgroundColor3 = arg2.Theme.SystemPrimaryContent.Color,
                        BackgroundTransparency = arg2.Theme.SystemPrimaryContent.Transparency,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 44),
                        LayoutOrder = 5
                    }, {
                        uiCorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                        doneButton = Roact.createElement(
                            TextButton,
                            {
                                size = UDim2.fromScale(1, 1),
                                text = arg1.props.doneText,
                                onActivated = arg1.onDoneActivated
                            }
                        )
                    })
                }
            )
        })
    end)
end

return var1
