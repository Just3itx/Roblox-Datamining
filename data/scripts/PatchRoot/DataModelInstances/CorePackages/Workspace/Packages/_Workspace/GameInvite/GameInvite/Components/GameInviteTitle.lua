-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local Components = GameInvite.Components
local Context = GameInvite.Context
local GameInviteParent = GameInvite.Parent
local utils = GameInvite.utils

local FriendsMenu = require(GameInviteParent.FriendsMenu)
local React = require(GameInviteParent.React)
local UIBlox = require(GameInviteParent.UIBlox)
local Foundation = require(GameInviteParent.Foundation)
local GetTextSize = require(GameInviteParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local UniversalAppPolicy = require(GameInviteParent.UniversalAppPolicy)
local DeviceInfo = require(GameInviteParent.NotificationsCommon).DeviceInfo
local IsVRAppBuild = require(GameInviteParent.AppCommonLib).IsVRAppBuild

local FriendsMenuSearch = FriendsMenu.FriendsMenuSearch
local FriendsListContext = FriendsMenu.FriendsListContext
local InviteFriendContext = FriendsMenu.InviteFriendContext

local GameInviteAnalyticsManager = require(GameInvite.analytics.GameInviteAnalyticsManager)
local GameInviteModalManager = require(GameInvite.GameInviteModalManager)
local ShareGameInviteLink = require(Components.ShareGameInviteLink)
local isExperienceOlderThanOneWeek = require(utils.isExperienceOlderThanOneWeek)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)
local LocalizationHelper = require(GameInviteParent.NotificationsCommon).LocalizationHelper
local GameInviteConstants = require(GameInvite.GameInviteConstants)
local shouldShowJoinCta = require(utils.shouldShowJoinCta)
local FFlagGameInviteInExpJoinCta = require(GameInvite.Flags.FFlagGameInviteInExpJoinCta)

local GameInviteModalLayoutContext = require(Context.GameInviteModalLayoutContext)
local GameDetailsContext = require(Context.GameDetailsContext)

local useStyle = UIBlox.Core.Style.useStyle
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings
local useAppPolicy = UniversalAppPolicy.useAppPolicy

local GetFFlagEnableGameInviteModalVRSupport = require(GameInviteParent.SharedFlags).GetFFlagEnableGameInviteModalVRSupport

local TitleIconSize = GameInviteConstants.Layout.TitleIconSize
local SidePadding = GameInviteConstants.Layout.SidePadding

local iconsNavigationClose = Images["icons/navigation/close"]
local iconsMenuSearch = Images["icons/menu/search"]

local tbl1 = {
    cancelText = "Feature.SettingsHub.Action.CancelSearch",
    inviteFriends = "CoreScripts.InGameMenu.PageTitle.InviteFriends",
    joinOrInviteFriends = if FFlagGameInviteInExpJoinCta then "CoreScripts.InGameMenu.PageTitle.JoinOrInviteFriends" else nil,
    copyLink = "Feature.SocialShare.Action.CopyLink"
}

local function func1(arg1, bool1: boolean, bool2: boolean)
    if GetFFlagEnableGameInviteModalVRSupport() then
        local isCoreScript = not IsVRAppBuild() and bool2 and not bool1 and arg1 and arg1.isCoreScript
        return isCoreScript and arg1.serverType == "StandardServer" and isExperienceOlderThanOneWeek(arg1.gameDetails)
    end

    local isCoreScript = not bool1 and bool2 and arg1 and arg1.isCoreScript
    return isCoreScript and arg1.serverType == "StandardServer" and isExperienceOlderThanOneWeek(arg1.gameDetails)
end

return function(tbl2)
    local var1 = useStyle()
    local var2 = React.useContext(GameInviteModalLayoutContext)
    local var3 = React.useContext(GameDetailsContext)
    local var4 = React.useContext(FriendsListContext)
    local var5 = React.useContext(InviteFriendContext)

    local var6, var7 = React.useState(false)
    local localizedStrings = getLocalizedStrings(tbl1)
    local var8 = if FFlagGameInviteInExpJoinCta and shouldShowJoinCta(var3) then localizedStrings.joinOrInviteFriends else localizedStrings.inviteFriends
    local searchFriends = var4.searchFriends

    local var9 = useAppPolicy(function(arg1)
        return arg1.getExperienceInviteShareLinkEnabled()
    end)

    local bool1 = var2.modalMode == "compact"
    local isFullWidth = var2.isFullWidth
    local isDesktop = DeviceInfo.isDesktopDevice()
    local var11 = DeviceInfo.isConsole()
    local var12 = func1(var3, var11, var9)
    local isFullSize = isDesktop and not isFullWidth

    local var10 = var1.Font.BaseSize * var1.Font.Header2.RelativeSize
    local var13 = var1.Font.BaseSize * var1.Font.Body.RelativeSize

    local textSize = GetTextSize(
        localizedStrings.copyLink,
        var10,
        var1.Tokens.Typography.TitleLarge.Font,
        Vector2.new(300 - TitleIconSize, math.huge),
        { addTemporaryPadding = false }
    )

    local var16 = nil
    local xOffset = 0
    if var12 then
        if isDesktop and isFullSize then
            local xOffset2 = math.ceil(textSize.X) + 10
            var16 = UDim2.new(0, xOffset2, 1, 0)
            xOffset += xOffset2
        else
            var16 = UDim2.new(0, TitleIconSize, 0, TitleIconSize)
            xOffset += TitleIconSize
        end
    end

    if bool1 then
        xOffset += TitleIconSize
    end
    if bool1 and var12 then
        xOffset += 4
    end

    local function func2()
        GameInviteModalManager:closeModal(var5.getMaxRecipientRowNum())
    end

    local function func3()
        var7(true)
    end

    local function func4() -- Luacid: Inlined by compiler; 1 call site recovered
        var7(false)
        searchFriends("")
    end

    if not bool1 and var6 then
        func4()
    end

    local var17 = React.useMemo(function()
        local tbl3 = {
            UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, SidePadding), PaddingRight = UDim.new(0, SidePadding) }),
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            LeftActionContainer = 0,
            Title = 0,
            RightActionContainer = 0
        }
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = UDim2.new(0, xOffset, 1, 0),
            LayoutOrder = 0,
            BackgroundTransparency = 1
        }

        local tbl5 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, 4)
            }),
            CloseButton = 0
        }
        local element

        if tbl2.hideCloseButton then
            element = nil
        else
            element = React.createElement(ImageSetButton, {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, TitleIconSize, 0, TitleIconSize),
                [React.Event.Activated] = func2,
                Image = iconsNavigationClose,
                ImageColor3 = var1.Theme.IconEmphasis.Color,
                ImageTransparency = var1.Theme.IconEmphasis.Transparency,
                BorderSizePixel = 0
            })
        end

        tbl5.CloseButton = element
        tbl3.LeftActionContainer = createElement(str1, tbl4, tbl5)

        tbl3.Title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = var8,
            TextSize = var10,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextColor3 = var1.Theme.TextEmphasis.Color,
            FontFace = normalizeFontFace(var1.Tokens.Typography.TitleLarge.Font),
            Size = UDim2.new(1, xOffset * 2 * -1, 1, 0),
            LayoutOrder = 1
        })

        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl6 = {
            Size = UDim2.new(0, xOffset, 1, 0),
            LayoutOrder = 2,
            BackgroundTransparency = 1
        }

        local tbl7 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 4)
            }),
            SearchButton = 0,
            ShareGameInviteLink = 0
        }
        local element2

        if bool1 then
            element2 = React.createElement(ImageSetButton, {
                LayoutOrder = 0,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(0, TitleIconSize, 0, TitleIconSize),
                [React.Event.Activated] = func3,
                Image = iconsMenuSearch,
                ImageColor3 = var1.Theme.IconEmphasis.Color,
                ImageTransparency = var1.Theme.IconEmphasis.Transparency,
                BorderSizePixel = 0
            })
                or nil
        else
            element2 = nil
        end

        tbl7.SearchButton = element2

        tbl7.ShareGameInviteLink = var12
            and React.createElement(
                ShareGameInviteLink,
                { layoutOrder = 1, isDesktop = isDesktop, isFullSize = isFullSize, size = var16 }
            )
            or nil
        tbl3.RightActionContainer = createElement2(str2, tbl6, tbl7)
        return tbl3
    end, {
        var6,
        isFullSize,
        bool1,
        var12,
        isDesktop,
        var8
    })
    local var18 = React.useMemo(function()
        local tbl3 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 4)
            }),
            SearchBox = React.createElement(FriendsMenuSearch, {
                layoutOrder = 0,
                size = UDim2.new(1, -120, 1, -20),
                focusElement = true,
                onFocus = function()
                    GameInviteAnalyticsManager:onSearchFocused()
                end
            }),
            CancelButton = React.createElement("TextButton", {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.new(0, 100, 1, 0),
                TextSize = var13,
                TextColor3 = var1.Theme.UIDefault.Color,
                Text = localizedStrings.cancelText,
                FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                [React.Event.Activated] = func4
            })
        }

        return tbl3
    end, { var6 })

    if var6 then
        var17 = var18
    end
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 1),
        LayoutOrder = tbl2.layoutOrder,
        Position = UDim2.new(0, 0, 1, 0),
        Size = tbl2.size
    }, var17)
end
