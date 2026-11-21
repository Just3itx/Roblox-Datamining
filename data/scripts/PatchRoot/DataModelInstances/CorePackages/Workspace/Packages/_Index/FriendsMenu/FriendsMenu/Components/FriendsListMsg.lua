-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local normalizeFontFace = require(FriendsMenuParent.Foundation).Utility.normalizeFontFace
local LocalizationHelper = require(FriendsMenuParent.NotificationsCommon).LocalizationHelper

local useStyle = UIBlox.Core.Style.useStyle
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

return function(tbl1)
    local var1 = useStyle()
    local theme = var1.Theme
    local font = var1.Font

    local textSize = font.BaseSize * font.Body.RelativeSize
    local localizedStrings = getLocalizedStrings({
        errorFriendsList = "Feature.SettingsHub.Label.FriendsListLoadErrorMessage",
        noResultFriendsList = "Feature.SettingsHub.Label.InviteSearchNoResults"
    })
    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Name = tbl1.msgType
    }, {
        subtitle = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = localizedStrings[tbl1.msgType],
            TextColor3 = theme.TextDefault.Color,
            TextTransparency = theme.TextDefault.Transparency,
            TextSize = textSize,
            TextWrapped = true,
            FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
            Size = UDim2.new(1, 0, 0, textSize),
            Position = UDim2.new(0, 0, 0.4, 0),
            TextYAlignment = Enum.TextYAlignment.Top
        })
    })
end
