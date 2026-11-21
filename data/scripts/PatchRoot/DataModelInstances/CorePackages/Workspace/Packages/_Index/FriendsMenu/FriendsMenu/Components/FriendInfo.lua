-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local Foundation = require(FriendsMenuParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local UserModel = require(FriendsMenuParent.UserLib).Models.UserModel
local LocalizationHelper = require(FriendsMenuParent.NotificationsCommon).LocalizationHelper
local _NotificationsCommon = require(FriendsMenuParent.NotificationsCommon)
local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local useStyle = UIBlox.Core.Style.useStyle
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

local GetFFlagLuaAppEnableOpenTypeSupport = require(FriendsMenuParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport
local FFlagEnableBlackbirdCheck = require(FriendsMenuParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = require(FriendsMenuParent.UserProfiles).Hooks.useIsRobloxSubscriber

local tbl1 = {
    online = "Common.Presence.Label.Online",
    inStudio = "Common.Presence.Label.RobloxStudio"
}

local iconsLogoStudiologo_small = Images["icons/logo/studiologo_small"]

local function func1(friend, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if friend.presence == UserModel.PresenceType.IN_GAME then
        return friend.lastLocation
    end

    if friend.presence == UserModel.PresenceType.ONLINE then
        return arg1.online
    end

    if friend.presence == UserModel.PresenceType.IN_STUDIO then
        return arg1.inStudio
    end

    return "@" .. friend.name
end

return function(tbl2)
    local var1 = useStyle()

    local theme = var1.Theme
    local font = var1.Font

    local textSize = font.BaseSize * font.Header2.RelativeSize
    local var2 = font.BaseSize * font.CaptionBody.RelativeSize

    local localizedStrings = getLocalizedStrings(tbl1)

    local friend = tbl2.friend
    assert(friend, "friend should be non-nil. Silence type checker.")
    local bool1 = friend.presence == UserModel.PresenceType.IN_STUDIO

    local var3 = useIsRobloxSubscriber(if FFlagEnableBlackbirdCheck and friend.id then friend.id else nil)
    local element

    if tbl2.isFetchingFriendsNames then
        element = React.createElement(Skeleton, { Size = UDim2.new(0, 120, 0, 10), radius = Radius.Small, LayoutOrder = 1 })
    elseif FFlagEnableBlackbirdCheck and var3 then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, textSize),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }),
            DisplayName = React.createElement(
                "TextLabel",
                {
                    Size = UDim2.new(0, 0, 0, textSize),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Text = friend.displayName,
                    TextSize = textSize,
                    TextColor3 = theme.TextEmphasis.Color,
                    TextTransparency = theme.TextEmphasis.Transparency,
                    FontFace = normalizeFontFace(var1.Tokens.Typography.TitleLarge.Font),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    LayoutOrder = 1
                },
                {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink })
                }
            ),
            SubscriptionBadge = React.createElement(Foundation.Icon, {
                name = Foundation.Enums.IconName.RobloxPlus,
                size = Foundation.Enums.IconSize.Small,
                style = {
                    Color3 = theme.TextEmphasis.Color,
                    Transparency = theme.TextEmphasis.Transparency
                },
                LayoutOrder = 2
            })
        })
    else
        element = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, textSize),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = friend.displayName,
            TextSize = textSize,
            TextColor3 = theme.TextEmphasis.Color,
            TextTransparency = theme.TextEmphasis.Transparency,
            FontFace = normalizeFontFace(var1.Tokens.Typography.TitleLarge.Font),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.AtEnd,
            LayoutOrder = 1
        })
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Position = tbl2.position,
        Size = tbl2.size,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl4 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }),
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12) }),
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 4)
        }),
        DisplayName = element,
        UserContextContainer = 0
    }
    local element2 = tbl2.isFetchingFriendsNames
        and React.createElement(Skeleton, { Size = UDim2.new(0, 80, 0, 10), radius = Radius.Small, LayoutOrder = 2 })

    if not element2 then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, var2),
            ClipsDescendants = true
        }
        local tbl6 = {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 4)
            }),
            StudioImage = bool1
                and React.createElement(ImageSetLabel, {
                    Image = iconsLogoStudiologo_small,
                    ImageColor3 = theme.TextDefault.Color,
                    ImageTransparency = theme.TextDefault.Transparency,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, var2, 0, var2),
                    LayoutOrder = 1
                }),
            UserContext = 0
        }

        local createElement3 = React.createElement
        local tbl7 = {
            Size = UDim2.new(1, -var2, 0, var2),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = 0,
            TextSize = 0,
            TextColor3 = 0,
            TextTransparency = 0,
            FontFace = 0,
            BackgroundTransparency = 1,
            TextXAlignment = 0,
            TextWrapped = true,
            TextTruncate = 0,
            LayoutOrder = 2,
            OpenTypeFeatures = 0
        }
        local var4 = func1(friend, localizedStrings)
        local str3 = "TextLabel"
        tbl7.Text = var4
        tbl7.TextSize = var2
        tbl7.TextColor3 = theme.TextEmphasis.Color
        tbl7.TextTransparency = theme.TextEmphasis.Transparency
        tbl7.FontFace = normalizeFontFace(var1.Tokens.Typography.BodySmall.Font)

        tbl7.TextXAlignment = Enum.TextXAlignment.Left

        tbl7.TextTruncate = Enum.TextTruncate.AtEnd

        tbl7.OpenTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
        tbl6.UserContext = createElement3(str3, tbl7)
        element2 = createElement2(str2, tbl5, tbl6)
    end

    tbl4.UserContextContainer = element2
    return createElement(str1, tbl3, tbl4)
end
