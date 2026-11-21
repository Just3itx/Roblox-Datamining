-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useSelector = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useSelector
local Constants = require(script.Parent.Parent.Constants)
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local useAppPolicy = require(FlyoutSidePanelParent.UniversalAppPolicy).useAppPolicy
local useHomeSortDropDownOptions = require(FlyoutSidePanelParent.Home.useHomeSortDropDownOptions)
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local GetFFlagPlatformEventEnabled = SharedFlags.GetFFlagPlatformEventEnabled
local GetFStringPlatformEventUrl = SharedFlags.GetFStringPlatformEventUrl
local FFlagEnableBlackbird = SharedFlags.FFlagEnableBlackbird
local FFlagEnableBlackbirdOnFlyoutMenu = SharedFlags.FFlagEnableBlackbirdOnFlyoutMenu
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagEnableRMOnMorePageGUAC = SharedFlags.FFlagEnableRMOnMorePageGUAC
local FFlagEnableRMOnMorePageForAll = SharedFlags.FFlagEnableRMOnMorePageForAll
local FFlagLuaAppFixNotificationBadgeCountsSync = SharedFlags.FFlagLuaAppFixNotificationBadgeCountsSync
local FFlagFlyoutRemoveMomentsForArgoEnabled = SharedFlags.FFlagFlyoutRemoveMomentsForArgoEnabled
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagArgoEnableMoments = SharedFlags.FFlagArgoEnableMoments
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagFlyoutFilterWebViewsAndBrowserLinks = SharedFlags.FFlagFlyoutFilterWebViewsAndBrowserLinks
local FFlagFlyoutAddAdjustScreen = require(script.Parent.Parent.Flags.FFlagFlyoutAddAdjustScreen)
local FFlagFlyoutSidePanelTradesEntry = require(script.Parent.Parent.Flags.FFlagFlyoutSidePanelTradesEntry)
local FFlagFlyoutHideSortDeeplinkItems = require(script.Parent.Parent.Flags.FFlagFlyoutHideSortDeeplinkItems)
local FFlagFlyoutGateLearnPlace = SharedFlags.FFlagFlyoutGateLearnPlace
local FFlagEnableTradesEntryForNonPremium = SharedFlags.FFlagEnableTradesEntryForNonPremium
local MomentsCommon = require(FlyoutSidePanelParent.MomentsCommon)
local useMomentsGating = MomentsCommon.Hooks.useMomentsGating
local canRenderNativeMoments = MomentsCommon.canRenderNativeMoments

local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)

local function updateNotifications(arg1, arg2, arg3, arg4)
    local num1 = 0
    if arg1.itemType == FlyoutContentSettings.ItemType.Settings then
        arg3 = arg2.MorePageSettings
    elseif arg1.itemType == FlyoutContentSettings.ItemType.Connections then
        if not FFlagLuaAppFixNotificationBadgeCountsSync then
            arg3 = arg2.MorePageFriends
        end
    elseif arg1.itemType ~= FlyoutContentSettings.ItemType.Messages then
        arg3 = num1
    elseif FFlagLuaAppFixNotificationBadgeCountsSync then
        arg3 = arg4
    else
        arg3 = arg2.MorePageMessages
    end
    if arg3 > 0 and (not arg1.notificationCount or arg1.notificationCount ~= arg3) then
        arg1.notificationCount = arg3
    end
end

local function shouldSkipLibraryItem(str1: string, arg1, tbl1)
    if arg1 == nil then
        return true
    end

    if FFlagFlyoutAddAdjustScreen and str1 == FlyoutContentSettings.ItemType.AdjustScreen and not tbl1.supportsOverscan then
        return true
    end
    if FFlagFlyoutHideSortDeeplinkItems and FlyoutContentSettings.itemIsGameSortDeeplink(arg1) then
        return true
    end

    if FFlagFlyoutFilterWebViewsAndBrowserLinks
        and not tbl1.webViewSupported
        and FlyoutContentSettings.itemRequiresWebView(arg1, tbl1.externalBrowserAllowed)
    then
        return true
    end
    if str1 == FlyoutContentSettings.ItemType.Favorites and not tbl1.hasFavoritesData then
        return true
    end

    if str1 == FlyoutContentSettings.ItemType.ContinuePlaying and not tbl1.hasContinueData then
        return true
    end

    if str1 == FlyoutContentSettings.ItemType.Premium and tbl1.disablePremiumEntrypoint then
        return true
    end

    if str1 == FlyoutContentSettings.ItemType.GiftCards and tbl1.hideGiftCards then
        return true
    end

    if str1 == FlyoutContentSettings.ItemType.Redeem and not tbl1.redeemTileEnabled then
        return true
    end

    if str1 == FlyoutContentSettings.ItemType.Trades and not (tbl1.hasPaidTradingAccess or FFlagEnableTradesEntryForNonPremium) then
        return true
    end

    if FFlagEnableBlackbird and FFlagEnableBlackbirdOnFlyoutMenu then
        if str1 == FlyoutContentSettings.ItemType.Premium then
            return true
        end

        if str1 == FlyoutContentSettings.ItemType.Blackbird and tbl1.disableBlackbirdEntrypoints then
            return true
        end
    end
    return false
end

local function useFlyoutNavigationItems()
    local flyoutDefaultPolicy = Constants.FLYOUT_DEFAULT_POLICY

    local var1 = useSelector(function(arg1)
        return arg1.NotificationBadgeCounts
    end)

    local var2 = useSelector(function(arg1)
        if not FFlagLuaAppFixNotificationBadgeCountsSync then
            return 0
        end
        local friendsCarousel = arg1.FriendsCarousel
        local requests = friendsCarousel and friendsCarousel.Friends and friendsCarousel.Friends.requests
        return requests and requests.receivedCount or 0
    end)

    local var3 = useSelector(function(arg1)
        if FFlagLuaAppFixNotificationBadgeCountsSync then
            return arg1.SocialTab and arg1.SocialTab.UnreadConversationCount or 0
        end

        return 0
    end)

    local var4, var5

    if FFlagLuaAppEnableSduiHomePage then
        local var6 = useHomeSortDropDownOptions()
        var4, var5 = React.useMemo(function()
            local var7 = nil
            local var8 = nil
            for _, value in var6 do
                if value.topicId == Constants.SORT_ID_CONTINUE_PLAYING then
                    var7 = true
                elseif value.topicId == Constants.SORT_ID_FAVORITES then
                    var8 = true
                end
            end

            return var7, var8
        end, { var6 })
    else
        local var6 = useSelector(function(arg1)
            return arg1.OmniRecommendations and arg1.OmniRecommendations.Home
        end)
        local var7 = var6 and var6.sorts or {}
        var4, var5 = React.useMemo(function()
            local var8 = nil
            local var9 = nil
            for _, value in pairs(var7) do
                if value.topicId == Constants.SORT_ID_CONTINUE_PLAYING then
                    var8 = true
                elseif value.topicId == Constants.SORT_ID_FAVORITES then
                    var9 = true
                end
            end

            return var8, var9
        end, { var7 })
    end

    local disablePremiumEntrypoint = useAppPolicy(function(arg1)
        return arg1.getDisablePremiumEntrypoint() or false
    end)
    local disableBlackbirdEntrypoints = useAppPolicy(function(arg1)
        return arg1.getDisableBlackbirdEntrypoints() or false
    end)
    local var8 = useAppPolicy(function(arg1)
        return arg1.getGiftCardSourceRefOverride()
    end)
    local redeemTileEnabled = useAppPolicy(function(arg1)
        return arg1.getRedeemTileEnabled()
    end)
    local var10 = not FFlagFlyoutGateLearnPlace or useAppPolicy(function(arg1)
        return arg1.getLearnPlaceEnabled()
    end)

    local supportsOverscan = if FFlagFlyoutAddAdjustScreen then useAppPolicy(function(arg1)
        return arg1.getSupportsOverscan()
    end) else false

    local webViewSupported = not FFlagFlyoutFilterWebViewsAndBrowserLinks or useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local externalBrowserAllowed = if FFlagFlyoutFilterWebViewsAndBrowserLinks then useAppPolicy(function(arg1)
        return arg1.shouldUseExternalBrowserForMorePageItem()
    end) else false

    local hasPaidTradingAccess = if FFlagFlyoutSidePanelTradesEntry then useSelector(function(arg1)
        local user = arg1.Users[arg1.LocalUserId]
        if not user then
            return false
        end
        local bool1 = user.membership == Enum.MembershipType.Premium
        local var14 = FFlagEnableBlackbirdCheck and user.hasRobloxSubscription == true
        return bool1 or var14
    end) else false

    local var15 = useMomentsGating()
    local isAmpPolicyEnabled = var15.isAmpPolicyEnabled
    local var16 = not FFlagEnableRMOnMorePageGUAC or isAmpPolicyEnabled
    local hideGiftCards = not var8 or var8 == ""

    local useMemo = React.useMemo
    local function func1()
        local myLibraryItems = {}
        local additionalNavigationItems = {}
        local tbl3 = {
            hasFavoritesData = var5,
            hasContinueData = var4,
            disablePremiumEntrypoint = disablePremiumEntrypoint,
            hideGiftCards = hideGiftCards,
            redeemTileEnabled = redeemTileEnabled,
            hasPaidTradingAccess = hasPaidTradingAccess,
            disableBlackbirdEntrypoints = disableBlackbirdEntrypoints,
            webViewSupported = webViewSupported,
            externalBrowserAllowed = externalBrowserAllowed,
            supportsOverscan = supportsOverscan
        }
        for _, value in flyoutDefaultPolicy.MyLibrary do
            local var17 = FlyoutContentSettings.ItemInfo[value]
            if shouldSkipLibraryItem(value, var17, tbl3) then
                continue
            end

            local var18 = table.clone(var17)
            updateNotifications(var18, var1, var2, var3)

            table.insert(myLibraryItems, var18)
        end
        for _, value in flyoutDefaultPolicy.AdditionalNavigation do
            local var17 = FlyoutContentSettings.ItemInfo[value]
            if var17 == nil then
                continue
            end
            if value == FlyoutContentSettings.ItemType.Events then
                if not GetFFlagPlatformEventEnabled() or GetFStringPlatformEventUrl() == "" then
                    continue
                end
            elseif value == FlyoutContentSettings.ItemType.Learn and FFlagFlyoutGateLearnPlace then
                if not var10 then
                    continue
                end
            elseif value == FlyoutContentSettings.ItemType.Moments
                and (FFlagFlyoutRemoveMomentsForArgoEnabled and FFlagEnableArgus and FFlagArgoEnableMoments
                    or FFlagFlyoutRemoveMomentsForArgoEnabled and var15 ~= nil and not var15.isSupportedOnPlatform
                    or (var15 == nil or not var15.isFlyoutEntryEnabled) and not (FFlagEnableRMOnMorePageForAll or var16))
            then
                continue
            end

            if FFlagFlyoutFilterWebViewsAndBrowserLinks
                and not webViewSupported
                and FlyoutContentSettings.itemRequiresWebView(var17, externalBrowserAllowed)
            then
                continue
            end

            local var18 = table.clone(var17)
            if value == FlyoutContentSettings.ItemType.Moments and var15 ~= nil then
                local tbl4 = if canRenderNativeMoments(var15) then {
                    appPage = AppPage.Moments,
                    destinationType = FlyoutContentSettings.DestinationType.AppPage
                } else {
                    appUri = FlyoutContentSettings.MomentsExperienceUri,
                    destinationType = FlyoutContentSettings.DestinationType.PlaceLaunch
                }
                var18.context = tbl4
            end

            table.insert(additionalNavigationItems, var18)
        end
        return {
            myLibraryItems = myLibraryItems,
            additionalNavigationItems = additionalNavigationItems
        }
    end

    local var17 = var5
    local var18 = var4
    local var19 = if FFlagFlyoutFilterWebViewsAndBrowserLinks then webViewSupported else nil
    local var20 = if FFlagFlyoutFilterWebViewsAndBrowserLinks then externalBrowserAllowed else nil
    local var21 = if FFlagFlyoutSidePanelTradesEntry then hasPaidTradingAccess else nil
    local var22 = if FFlagFlyoutGateLearnPlace then var10 else nil
    local var23 = if FFlagFlyoutAddAdjustScreen then supportsOverscan else nil
    local var24 = if FFlagLuaAppFixNotificationBadgeCountsSync then var2 else nil
    local var25 = if FFlagLuaAppFixNotificationBadgeCountsSync then var3 else nil
    return useMemo(func1, {
        var17,
        var18,
        flyoutDefaultPolicy,
        var1,
        disablePremiumEntrypoint,
        disableBlackbirdEntrypoints,
        hideGiftCards,
        var19,
        var20,
        var21,
        var16,
        var22,
        var23,
        var15,
        var24,
        var25
    })
end

return useFlyoutNavigationItems
