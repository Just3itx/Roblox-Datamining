-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local UserTile = require(ProfilePlatformParent.UserTile).UserTile
local LayoutMode = require(ProfilePlatformParent.UserTile).LayoutMode
local iconsActionsEditCopy = require(ProfilePlatformParent.FoundationImages).Images["icons/actions/edit/copy"]
local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local useCurrentProfileFriendStatus = require(ProfilePlatform.Hooks.useCurrentProfileFriendStatus)
local convertToFoundationPresenceEnum = require(ProfilePlatformParent.SocialCommon).Utils.convertToFoundationPresenceEnum
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local default = require(ProfilePlatformParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FFlagEnableFontStylisticAlternativesOnSocialScreens = require(ProfilePlatformParent.SharedFlags).FFlagEnableFontStylisticAlternativesOnSocialScreens
local FFlagAddPlatformNameToProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagAddPlatformNameToProfileHeader
local FFlagEnableBlackbirdCheck = require(ProfilePlatformParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagDisableCopyUsernameOnConsole = require(ProfilePlatformParent.SharedFlags).FFlagDisableCopyUsernameOnConsole
local FFlagEnableUserRecentActivityEntryPoint = require(ProfilePlatformParent.SharedFlags).FFlagEnableUserRecentActivityEntryPoint
local Responsive = require(ProfilePlatformParent.Responsive)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation

local useIsRobloxSubscriber = require(ProfilePlatformParent.UserProfiles).Hooks.useIsRobloxSubscriber

local getBuilderIconForCurrentPlatform = Foundation.Utility.getBuilderIconForCurrentPlatform

local function AvatarHeadshotComponent(tbl1)
    local var1 = useTokens()
    local offset, var2 = useDynamicSizeMargin()
    local var3 = useLocalUserId()

    local userId = tbl1.userId
    local bool1 = userId == tostring(var3)
    local userPresenceType = if bool1 or not tbl1.userPresenceType then nil else convertToFoundationPresenceEnum(tbl1.userPresenceType)
    local subtitle = if tbl1.username and tbl1.username ~= "" then if FFlagEnableFontStylisticAlternativesOnSocialScreens then `<font features="zero, ss03">@{tbl1.username}</font>` else "@" .. tbl1.username else ""
    local var6 = useDispatch()
    local var7 = useLocalization({ usernameCopied = TextKeys.UsernameCopied, viewRecentActivity = TextKeys.ViewRecentActivity })

    local var8 = React.useMemo(function()
        if FFlagAddPlatformNameToProfileHeader then
            return (getBuilderIconForCurrentPlatform())
        end

        return nil
    end, {})

    local var9 = if FFlagEnableBlackbirdCheck then useIsRobloxSubscriber(userId) else nil
    local bool2 = if FFlagDisableCopyUsernameOnConsole then Responsive.usePreferredInput() == Responsive.Input.Directional else false
    local var10 = if FFlagEnableUserRecentActivityEntryPoint then useCurrentProfileFriendStatus() else nil
    local bool3 = if FFlagEnableUserRecentActivityEntryPoint then bool1 or var10 == Enums.FriendStatus.Friends else false
    local var11 = if FFlagEnableUserRecentActivityEntryPoint then useNavigation() else nil

    local var12 = if FFlagEnableUserRecentActivityEntryPoint then React.useCallback(function()
        var11.navigate(AppPage.UserRecentActivity, { userId = tbl1.userId, primaryName = tbl1.primaryName })
    end, { var11, tbl1.userId, tbl1.primaryName }) else nil

    local var13 = React.useCallback(function()
        default:setClipboardText({ context = Contexts.ProfileCard, text = tbl1.username })

        var6(
            SetCurrentToastMessage({ toastMessage = var7.usernameCopied, isLocalized = true, toastIcon = iconsActionsEditCopy })
        )
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, Constants.AVATAR_HEADSHOT_HEIGHT),
        Position = UDim2.new(0, 0, 0, -(Constants.AVATAR_HEADSHOT_HEIGHT / 2) - var1.Gap.Large),
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = var2
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset), PaddingRight = UDim.new(0, offset) }),
        UserTile = 0
    }
    local createElement2 = React.createElement
    local var14 = UserTile
    local tbl4 = {
        layoutOrder = 1,
        userId = tbl1.userId,
        title = tbl1.primaryName,
        isVerified = tbl1.isVerified,
        isPremium = tbl1.isPremium,
        isRobloxAdmin = tbl1.isRobloxAdmin,
        subtitle = subtitle,
        contextualInfo = if FFlagAddPlatformNameToProfileHeader then tbl1.platformName else nil,
        contextualInfoIcon = 0,
        layoutMode = 0,
        userPresenceType = 0,
        titleStyle = 0,
        subtitleStyle = 0,
        onSubtitleClicked = 0,
        trustedConnectionIndicatorEnabled = true,
        isRobloxSubscriber = 0,
        extraInfo = 0,
        onExtraInfoClicked = 0
    }

    if not FFlagAddPlatformNameToProfileHeader then
        var8 = nil
    end

    tbl4.contextualInfoIcon = var8
    tbl4.layoutMode = LayoutMode.wide
    tbl4.userPresenceType = userPresenceType
    tbl4.titleStyle = var1.Typography.HeadingSmall
    tbl4.subtitleStyle = var1.Typography.BodyMedium
    if bool2 then
        var13 = nil
    end

    tbl4.onSubtitleClicked = var13

    if not FFlagEnableBlackbirdCheck then
        var9 = nil
    end

    tbl4.isRobloxSubscriber = var9
    tbl4.extraInfo = if bool3 then var7.viewRecentActivity else nil
    if not bool3 then
        var12 = nil
    end

    tbl4.onExtraInfoClicked = var12
    tbl3.UserTile = createElement2(var14, tbl4)
    return createElement(str1, tbl2, tbl3)
end

return AvatarHeadshotComponent
