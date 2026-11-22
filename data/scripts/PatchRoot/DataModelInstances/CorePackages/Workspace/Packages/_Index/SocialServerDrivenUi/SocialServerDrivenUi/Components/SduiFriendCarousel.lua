-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local React = require(SocialServerDrivenUiParent.React)
local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)

local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage
local DiscoveryTypes = require(SocialServerDrivenUiParent.DiscoveryTypes)
local findAnalyticsField = require(SocialServerDrivenUiParent.SduiCoreSystem).findAnalyticsField
local SocialCarousel = require(SocialServerDrivenUiParent.SocialCarousel)

local FlyoutSidePanelIXP = require(SocialServerDrivenUiParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local OpenProfileQRCodePageBridge = require(SocialServerDrivenUi.System.OpenProfileQRCodePageBridge)

local FFlagEnableFlyoutFriendsHeaderFix = SharedFlags.FFlagEnableFlyoutFriendsHeaderFix
local FFlagFlyoutHideFriendsHeader = SocialCarousel.Flags.FFlagFlyoutHideFriendsHeader
local FFlagLuaAppCompositionAlways = SharedFlags.FFlagLuaAppCompositionAlways
local FFlagMobileGameJoinCardVideo = SharedFlags.FFlagMobileGameJoinCardVideo
local FFlagLuaAppFriendsSortHeaderByPosition = SharedFlags.FFlagLuaAppFriendsSortHeaderByPosition
local FFlagLuaAppHomeFriendsRemoveItemImpressions = SharedFlags.FFlagLuaAppHomeFriendsRemoveItemImpressions
local FFlagSocialCarouselShareQREnabled = SharedFlags.FFlagSocialCarouselShareQREnabled

local FIntLuaAppFriendsSortHeaderMaxHiddenPosition = SharedFlags.FIntLuaAppFriendsSortHeaderMaxHiddenPosition

local SORT_INDEX_SELECTION_ORDER_MULTIPLIER = DiscoveryTypes.Constants.SORT_INDEX_SELECTION_ORDER_MULTIPLIER
local SORT_SELECTION_ORDER_BASE = DiscoveryTypes.Constants.SORT_SELECTION_ORDER_BASE

local function getShouldHideCarouselHeader(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if FIntLuaAppFriendsSortHeaderMaxHiddenPosition < num1 then
        return false
    end

    local var1 = FFlagFlyoutHideFriendsHeader

    if var1 then
        if FFlagEnableFlyoutFriendsHeaderFix then
            return (FlyoutSidePanelIXP.isFriendsSortHeaderHiddenInFlyoutIxp())
        end

        var1 = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled()
    end

    return var1
end

local function SduiFriendCarousel(tbl1)
    local sortIndex = tonumber(findAnalyticsField("collectionPosition", tbl1.analyticsContext.analyticsData or {}, -1)) or -1

    local sortAnalyticsData = React.useMemo(function()
        return {
            sortIndex = sortIndex,
            appPage = tbl1.sduiContext.appPage,
            sortId = tbl1.sortId,
            startRow = tbl1.startRow
        }
    end, {
        sortIndex,
        tbl1.sduiContext.appPage,
        tbl1.sortId,
        tbl1.startRow
    })

    local createElement = React.createElement
    local entry = SocialCarousel.Entry
    local tbl2 = {
        unifiedLogging = {
            sortIndex = sortIndex,
            appPage = tbl1.sduiContext.appPage,
            sortId = tbl1.sortId or "",
            scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
            impressionTag = "HomeFriendCarousel",
            skipItemImpressionsLog = if FFlagLuaAppHomeFriendsRemoveItemImpressions then true else nil
        },
        sortAnalyticsData = sortAnalyticsData,
        refreshSignal = tbl1.refreshSignal,
        selectionOrderBase = SORT_SELECTION_ORDER_BASE + sortIndex * SORT_INDEX_SELECTION_ORDER_MULTIPLIER,
        source = SocialCarousel.Constants.ANALYTICS.SRC.HOMEPAGE_FRIENDS_CAROUSEL,
        hideCarouselHeader = if FFlagLuaAppFriendsSortHeaderByPosition then getShouldHideCarouselHeader(sortIndex) elseif FFlagFlyoutHideFriendsHeader then if if FFlagEnableFlyoutFriendsHeaderFix then FlyoutSidePanelIXP.isFriendsSortHeaderHiddenInFlyoutIxp() else FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() then true else nil else nil,
        appCompositionEnabled = if FFlagLuaAppCompositionAlways then true else tbl1.sduiContext.appCompositionEnabled,
        navigateToQRCodePage = if FFlagSocialCarouselShareQREnabled then OpenProfileQRCodePageBridge.requestOpen else nil,
        isJoinCardVideoEnabled = if FFlagMobileGameJoinCardVideo then tbl1.sduiContext.appPage == AppPage.Home else nil,
        videoPlaybackContext = if FFlagMobileGameJoinCardVideo then tbl1.sduiContext.videoPlaybackContext else nil
    }
    return createElement(entry, tbl2)
end

return SduiFriendCarousel
