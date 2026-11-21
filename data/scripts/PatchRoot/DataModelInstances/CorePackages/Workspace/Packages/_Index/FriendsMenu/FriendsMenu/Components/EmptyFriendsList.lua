-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local normalizeFontFace = require(FriendsMenuParent.Foundation).Utility.normalizeFontFace
local LocalizationHelper = require(FriendsMenuParent.NotificationsCommon).LocalizationHelper

local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

local iconsMenuFriends_large = Images["icons/menu/friends_large"]

return function()
    local var1 = useStyle()
    local theme = var1.Theme
    local font = var1.Font

    local localizedStrings = getLocalizedStrings({ noFriendsText = "Feature.SettingsHub.Label.NoFriendsPageMessage" })

    local textSize = font.BaseSize * font.Body.RelativeSize

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, -20),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Name = "EmptyFriendsList"
    }, {
        listLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        }),
        friendsIcon = React.createElement(
            ImageSetLabel,
            {
                Image = iconsMenuFriends_large,
                Size = UDim2.new(0, 48, 0, 48),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            }
        ),
        subtitle = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = localizedStrings.noFriendsText,
            TextColor3 = theme.TextDefault.Color,
            TextTransparency = theme.TextDefault.Transparency,
            TextSize = textSize,
            TextWrapped = true,
            FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, textSize),
            TextYAlignment = Enum.TextYAlignment.Top
        })
    })
end
