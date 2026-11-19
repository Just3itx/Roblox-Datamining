-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local UserLib = require(CorePackages.Workspace.Packages.UserLib)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local useLayoutValues = PlayerList.Common.useLayoutValues

local withStyle = UIBlox.Style.withStyle

local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text

local Connection = script.Parent.Parent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues
local UserProfiles = require(CorePackages.Workspace.Packages.UserProfiles)
local useVerifiedBadge = UserProfiles.Hooks.useVerifiedBadge

local EmojiTextLabel = UIBlox.Core.Text.EmojiTextLabel
local Emoji = UIBlox.App.Emoji.Enum.Emoji

local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagEnableVerifiedBadgeStore = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableVerifiedBadgeStore
local FFlagPlayerListDropDownShowPlatformName = PlayerList.Flags.FFlagPlayerListDropDownShowPlatformName

local _success, result = pcall(function(): PlatformFriendsService
    return game:GetService("PlatformFriendsService")
end)

local var1 = Roact.PureComponent:extend("DropDownPlayerHeader")

var1.validateProps = t.strictInterface({
    player = t.instanceIsA("Player"),
    transparency = t.any,
    contentVisible = t.boolean,
    layoutValues = t.optional(t.table),
    tokens = t.optional(t.table),
    showVerifiedBadge = t.optional(t.boolean),
    platformName = t.optional(t.string),
    platformProfileId = t.optional(t.string),
    canShowPlatformProfile = t.optional(t.boolean)
})

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        return withStyle(function(arg3)
            arg2 = arg1.props.layoutValues
            local tokens = arg1.props.tokens
            local size3000 = tokens.Size.Size_3000
            local size500 = tokens.Size.Size_500

            local player = arg1.props.player
            local var2 = if FFlagEnableVerifiedBadgeStore then arg1.props.showVerifiedBadge else UserLib.Utils.isPlayerVerified(player)
            local var3 = if FFlagPlayerListDropDownShowPlatformName then arg1.props.platformName and arg1.props.platformName ~= "" else nil
            local canShowPlatformProfile = if FFlagPlayerListDropDownShowPlatformName then arg1.props.canShowPlatformProfile else nil
            local createElement = Roact.createElement
            local str1 = "TextButton"
            local tbl1 = {
                BackgroundTransparency = 1,
                Text = "",
                Size = UDim2.new(1, 0, 0, arg2.DropDownHeaderSizeY),
                LayoutOrder = 0,
                Selectable = false
            }

            local tbl2 = { Background = 0, AvatarImage = 0, Divider = 0 }
            local createElement2 = Roact.createElement
            local str2 = "ImageLabel"
            local tbl3 = {
                BackgroundTransparency = 1,
                Image = "rbxasset://textures/ui/PlayerList/NewAvatarBackground.png",
                ImageTransparency = arg1.props.transparency,
                Size = UDim2.new(1, 0, 0, arg2.DropDownHeaderBackgroundSize),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1)
            }
            local tbl4 = { TextContainerFrame = 0 }
            local createElement3 = Roact.createElement
            local str3 = "Frame"
            local tbl5 = {
                Visible = arg1.props.contentVisible,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -size3000, 1, 0),
                Position = UDim2.new(0, tokens.Size.Size_2700, 0, 0)
            }
            local tbl6 = {
                Layout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 0),
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                DisplayName = 0,
                PlayerName = 0,
                PlatformName = 0
            }
            local bool1 = false
            local element

            if var2 then
                element = Roact.createElement(EmojiTextLabel, {
                    fontStyle = Cryo.Dictionary.join(arg3.Font.Header2, { Font = arg3.Tokens.Typography.TitleLarge.Font }),
                    colorStyle = arg3.Theme.TextEmphasis,
                    fluidSizing = false,
                    emoji = Emoji.Verified,
                    maxSize = Vector2.new(arg2.PlayerDropDownSizeXMobile - size3000, size500),
                    TextSize = if FFlagEnableMobilePlayerListOnConsole then arg2.DropDownHeaderDisplayNameTextSize else arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                    AutomaticSize = if FFlagEnableMobilePlayerListOnConsole then Enum.AutomaticSize.X else nil,
                    LayoutOrder = 1,
                    Text = player.DisplayName,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    TextScaled = not FFlagEnableMobilePlayerListOnConsole or nil
                })
                bool1 = element
            end

            if not bool1 then
                element = Roact.createElement("TextLabel", {
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, size500),
                    Text = player.DisplayName,
                    FontFace = normalizeFontFace(arg3.Tokens.Typography.TitleLarge.Font),
                    TextSize = if FFlagEnableMobilePlayerListOnConsole then arg2.DropDownHeaderDisplayNameTextSize else arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                    TextColor3 = arg3.Theme.TextEmphasis.Color,
                    TextTransparency = arg3.Theme.TextEmphasis.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    TextScaled = not FFlagEnableMobilePlayerListOnConsole or nil
                }, {
                    SizeConstraint = if FFlagEnableMobilePlayerListOnConsole then nil else Roact.createElement("UITextSizeConstraint", {
                        MaxTextSize = arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                        MinTextSize = arg3.Font.BaseSize * arg3.Font.Footer.RelativeSize
                    })
                })
            end

            tbl6.DisplayName = element

            tbl6.PlayerName = Roact.createElement("TextLabel", {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, size500),
                Text = "@" .. player.Name,
                FontFace = normalizeFontFace(arg3.Tokens.Typography.CaptionLarge.Font),
                TextSize = if FFlagEnableMobilePlayerListOnConsole then arg2.DropDownHeaderPlayerNameTextSize else arg3.Font.BaseSize * arg3.Font.CaptionHeader.RelativeSize,
                TextColor3 = arg3.Theme.TextMuted.Color,
                TextTransparency = arg3.Theme.TextMuted.Transparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1,
                TextScaled = not FFlagEnableMobilePlayerListOnConsole or nil
            }, {
                SizeConstraint = if FFlagEnableMobilePlayerListOnConsole then nil else Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = arg3.Font.BaseSize * arg3.Font.CaptionHeader.RelativeSize,
                    MinTextSize = arg3.Font.BaseSize * arg3.Font.Footer.RelativeSize
                })
            })

            local var4 = FFlagPlayerListDropDownShowPlatformName

            if var4 then
                if var3 then
                    local createElement4 = Roact.createElement
                    local var5 = View

                    local tbl7 = {
                        LayoutOrder = 3,
                        tag = "row align-y-center gap-xsmall radius-small",
                        Size = UDim2.new(1, 0, 0, size500),
                        onActivated = canShowPlatformProfile and function()
                            local platformProfileId = arg1.props.platformProfileId
                            if result and platformProfileId and platformProfileId ~= "" then
                                result:ShowProfile(platformProfileId)
                            end
                        end or nil
                    }

                    local tbl8 = {
                        PlatformIcon = Roact.createElement(Image, {
                            LayoutOrder = 1,
                            Image = "rbxasset://textures/ui/Shell/Icons/PlatformLogo@3x.png",
                            tag = "size-400",
                            imageStyle = {
                                Color3 = arg3.Theme.TextMuted.Color,
                                Transparency = if canShowPlatformProfile then 0 else 0.4
                            }
                        }),
                        PlatformNameButton = 0
                    }

                    local createElement5 = Roact.createElement
                    local var6 = FoundationText
                    local tbl9 = {
                        LayoutOrder = 2,
                        tag = "auto-y fill text-align-x-left text-truncate-end",
                        Text = arg1.props.platformName,
                        fontStyle = {
                            Font = arg3.Font.CaptionHeader.Font,
                            FontSize = arg2.DropDownHeaderPlayerNameTextSize
                        },
                        textStyle = 0
                    }
                    local textStyle = {
                        Color3 = arg3.Theme.TextMuted.Color,
                        Transparency = if canShowPlatformProfile then arg3.Theme.TextMuted.Transparency else math.clamp(arg3.Theme.TextMuted.Transparency + 0.3, 0, 1)
                    }
                    tbl9.textStyle = textStyle
                    tbl8.PlatformNameButton = createElement5(var6, tbl9)
                    var3 = createElement4(var5, tbl7, tbl8)
                end
            else
                var3 = var4
            end

            tbl6.PlatformName = var3
            tbl4.TextContainerFrame = createElement3(str3, tbl5, tbl6)
            tbl2.Background = createElement2(str2, tbl3, tbl4)

            tbl2.AvatarImage = Roact.createElement("ImageLabel", {
                Position = UDim2.new(0, tokens.Size.Size_1400, 0, 0),
                Size = UDim2.new(0, arg2.DropDownHeaderSizeY, 0, arg2.DropDownHeaderSizeY),
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                ImageTransparency = arg1.props.transparency,
                Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(player.UserId),
                ZIndex = 2
            })

            tbl2.Divider = not arg1.props.lastButton
                and Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    Visible = arg1.props.contentVisible,
                    BackgroundTransparency = arg3.Theme.Divider.Transparency,
                    BackgroundColor3 = arg3.Theme.Divider.Color,
                    BorderSizePixel = 0,
                    ZIndex = 3
                })
            return createElement(str1, tbl1, tbl2)
        end)
    end)
end

return function(arg1)
    local layoutValues = useLayoutValues()
    local tokens = useTokens()
    local var4 = if FFlagEnableVerifiedBadgeStore then useVerifiedBadge(arg1.player) else nil
    local platformNameFromId = nil
    local platformProfileIdFromId = nil
    local var5

    if FFlagPlayerListDropDownShowPlatformName then
        local str1 = tostring(arg1.player.UserId)
        local var6 = UserProfiles.Hooks.useUserProfilesFetch(
            {
                userIds = { str1 },
                query = UserProfiles.Queries.userProfilesDisplayUserPlatformNamesByUserIds
            }
        )
        if var6.data then
            platformNameFromId = UserProfiles.Selectors.getPlatformNameFromId(var6.data, str1)
            platformProfileIdFromId = UserProfiles.Selectors.getPlatformProfileIdFromId(var6.data, str1)
        end

        var5 = game:GetEngineFeature("PlatformFriendsService")
            and game:GetEngineFeature("PlatformFriendsProfile")
            and result
            and result:IsProfileEnabled()
            and platformProfileIdFromId
            and platformProfileIdFromId ~= ""
    else
        var5 = nil
    end

    local createElement = Roact.createElement
    local var6 = var1
    local join = Cryo.Dictionary.join
    local tbl1 = {
        layoutValues = layoutValues,
        tokens = tokens,
        showVerifiedBadge = 0,
        platformName = 0,
        platformProfileId = 0,
        canShowPlatformProfile = 0
    }

    if not FFlagEnableVerifiedBadgeStore then
        var4 = nil
    end

    tbl1.showVerifiedBadge = var4
    if not FFlagPlayerListDropDownShowPlatformName then
        platformNameFromId = nil
    end

    tbl1.platformName = platformNameFromId
    if not FFlagPlayerListDropDownShowPlatformName then
        platformProfileIdFromId = nil
    end

    tbl1.platformProfileId = platformProfileIdFromId
    if not FFlagPlayerListDropDownShowPlatformName then
        var5 = nil
    end

    tbl1.canShowPlatformProfile = var5
    return createElement(var6, join(arg1, tbl1))
end
