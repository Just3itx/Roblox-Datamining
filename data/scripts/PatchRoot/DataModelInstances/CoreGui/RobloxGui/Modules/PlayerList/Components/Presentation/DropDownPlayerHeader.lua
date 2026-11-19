-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local UserLib = require(CorePackages.Workspace.Packages.UserLib)
local Cryo = require(CorePackages.Packages.Cryo)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParent = script.Parent.Parent
local Connection = scriptParentParent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local FFlagPlayerListFixDropDownVerifiedBadgeSize = require(scriptParentParent.Parent.Flags.FFlagPlayerListFixDropDownVerifiedBadgeSize)
local useVerifiedBadge = require(CorePackages.Workspace.Packages.UserProfiles).Hooks.useVerifiedBadge

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableVerifiedBadgeStore = SharedFlags.FFlagEnableVerifiedBadgeStore
local FFlagCoreUiMigrateUIBloxToFoundation = SharedFlags.FFlagCoreUiMigrateUIBloxToFoundation

local EmojiTextLabel = UIBlox.Core.Text.EmojiTextLabel
local Emoji = UIBlox.App.Emoji.Enum.Emoji

local var1 = Roact.PureComponent:extend("DropDownPlayerHeader")

var1.validateProps = t.strictInterface({ player = t.instanceIsA("Player"), showVerifiedBadge = t.optional(t.boolean) })

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        return withFoundationOrUIBloxStyle(function(tokens)
            return {
                Tokens = tokens,
                Theme = {
                    Divider = {
                        Color = tokens.Color.Stroke.Emphasis.Color3,
                        Transparency = tokens.Color.Stroke.Emphasis.Transparency
                    },
                    TextEmphasis = {
                        Color = tokens.Color.Content.Emphasis.Color3,
                        Transparency = tokens.Color.Content.Emphasis.Transparency
                    },
                    TextMuted = {
                        Color = tokens.Color.Content.Muted.Color3,
                        Transparency = tokens.Color.Content.Muted.Transparency
                    }
                },
                Font = {
                    BaseSize = 1,
                    CaptionHeader = {
                        Font = tokens.Typography.CaptionLarge.Font,
                        RelativeSize = tokens.Typography.CaptionLarge.FontSize
                    },
                    Footer = {
                        Font = tokens.Typography.CaptionSmall.Font,
                        RelativeSize = tokens.Typography.CaptionSmall.FontSize
                    },
                    Header2 = {
                        Font = tokens.Typography.TitleLarge.Font,
                        RelativeSize = tokens.Typography.TitleLarge.FontSize,
                        FontSize = tokens.Typography.TitleLarge.FontSize,
                        LineHeight = tokens.Typography.TitleLarge.LineHeight,
                        LetterSpacing = tokens.Typography.TitleLarge.LetterSpacing
                    }
                }
            }
        end, function(arg3)
            local player = arg1.props.player
            local var2 = if FFlagEnableVerifiedBadgeStore then arg1.props.showVerifiedBadge else UserLib.Utils.isPlayerVerified(player)
            local fontStyle = Cryo.Dictionary.join(arg3.Font.Header2, {
                Font = arg3.Tokens.Typography.TitleLarge.Font,
                RelativeSize = if FFlagPlayerListFixDropDownVerifiedBadgeSize and FFlagCoreUiMigrateUIBloxToFoundation then Cryo.None else nil
            })

            return Roact.createElement("TextButton", {
                BackgroundTransparency = 1,
                Text = "",
                Size = UDim2.new(1, 0, 0, arg2.DropDownHeaderSizeY),
                LayoutOrder = 0,
                Selectable = false
            }, {
                Background = Roact.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Image = "rbxasset://textures/ui/PlayerList/NewAvatarBackground.png",
                    ImageTransparency = 0,
                    Size = UDim2.new(1, 0, 0, arg2.DropDownHeaderBackgroundSize),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1)
                }, {
                    TextContainerFrame = Roact.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -124, 1, 0),
                            Position = UDim2.new(0, 107, 0, 0)
                        },
                        {
                            Layout = Roact.createElement("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Vertical,
                                Padding = UDim.new(0, 0),
                                VerticalAlignment = Enum.VerticalAlignment.Center
                            }),
                            DisplayName = var2
                                and Roact.createElement(EmojiTextLabel, {
                                    fontStyle = fontStyle,
                                    colorStyle = arg3.Theme.TextEmphasis,
                                    fluidSizing = false,
                                    emoji = Emoji.Verified,
                                    maxSize = Vector2.new(arg2.PlayerDropDownSizeX - 124, 22),
                                    LayoutOrder = 1,
                                    Text = player.DisplayName,
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextTruncate = Enum.TextTruncate.AtEnd,
                                    BackgroundTransparency = 1,
                                    TextScaled = true
                                })
                                or Roact.createElement("TextLabel", {
                                    LayoutOrder = 1,
                                    Size = UDim2.new(1, 0, 0, 22),
                                    Text = player.DisplayName,
                                    FontFace = normalizeFontFace(arg3.Tokens.Typography.TitleLarge.Font),
                                    TextSize = arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                                    TextColor3 = arg3.Theme.TextEmphasis.Color,
                                    TextTransparency = arg3.Theme.TextEmphasis.Transparency,
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextTruncate = Enum.TextTruncate.AtEnd,
                                    BackgroundTransparency = 1,
                                    TextScaled = true
                                }, {
                                    SizeConstraint = Roact.createElement("UITextSizeConstraint", {
                                        MaxTextSize = arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                                        MinTextSize = arg3.Font.BaseSize * arg3.Font.Footer.RelativeSize
                                    })
                                }),
                            PlayerName = Roact.createElement("TextLabel", {
                                LayoutOrder = 2,
                                Size = UDim2.new(1, 0, 0, 22),
                                Text = "@" .. player.Name,
                                FontFace = normalizeFontFace(arg3.Tokens.Typography.CaptionLarge.Font),
                                TextSize = arg3.Font.BaseSize * arg3.Font.CaptionHeader.RelativeSize,
                                TextColor3 = arg3.Theme.TextMuted.Color,
                                TextTransparency = arg3.Theme.TextMuted.Transparency,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                BackgroundTransparency = 1,
                                TextScaled = true
                            }, {
                                SizeConstraint = Roact.createElement("UITextSizeConstraint", {
                                    MaxTextSize = arg3.Font.BaseSize * arg3.Font.CaptionHeader.RelativeSize,
                                    MinTextSize = arg3.Font.BaseSize * arg3.Font.Footer.RelativeSize
                                })
                            })
                        }
                    )
                }),
                AvatarImage = Roact.createElement("ImageLabel", {
                    Position = UDim2.new(0, 56, 0, 0),
                    Size = UDim2.new(0, arg2.DropDownHeaderSizeY, 0, arg2.DropDownHeaderSizeY),
                    AnchorPoint = Vector2.new(0.5, 0),
                    BackgroundTransparency = 1,
                    Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150",
                    ZIndex = 2
                }),
                Divider = not arg1.props.lastButton
                    and Roact.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, 1),
                        Position = UDim2.new(0, 0, 1, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        BackgroundTransparency = arg3.Theme.Divider.Transparency,
                        BackgroundColor3 = arg3.Theme.Divider.Color,
                        BorderSizePixel = 0,
                        ZIndex = 3
                    })
            })
        end)
    end)
end

return if FFlagEnableVerifiedBadgeStore then function(arg1)
    local showVerifiedBadge = useVerifiedBadge(arg1.player)

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { showVerifiedBadge = showVerifiedBadge }))
end else var1
