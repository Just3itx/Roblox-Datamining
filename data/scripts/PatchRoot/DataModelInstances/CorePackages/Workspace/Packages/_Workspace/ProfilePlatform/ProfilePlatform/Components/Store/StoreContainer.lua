-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Dash = require(ProfilePlatformParent.Dash)
local Constants = require(ProfilePlatform.Common.Constants)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local memoize = require(ProfilePlatformParent.AppCommonLib).memoize

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local Enums = require(ProfilePlatform.Common.Enums)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local NetworkingCatalog = require(ProfilePlatform.Networking.NetworkingCatalog)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useMarketplaceAnalyticsContext = require(ProfilePlatform.Hooks.useMarketplaceAnalyticsContext)
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)

local FFlagProfilePlatformNavigateToMarketplaceWebView = require(ProfilePlatform.Flags.FFlagProfilePlatformNavigateToMarketplaceWebView)
local Url = require(ProfilePlatformParent.Http).Url
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local FFlagProfilePlatformUseCatalogItemOpenedNewFields = require(ProfilePlatform.Flags.FFlagProfilePlatformUseCatalogItemOpenedNewFields)
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab

local GetFIntProfilePlatformMeTabStoreItemLimit = require(ProfilePlatform.Flags.GetFIntProfilePlatformMeTabStoreItemLimit)
local num1 = game:DefineFastInt("ProfilePlatformStoreItemLimit", 3)

local bool1 = game:DefineFastFlag("ProfilePlatformHideStoreIfNoAssets", false)

local FFlagEnableCommunityProfileLoadingSkeletons = require(ProfilePlatform.Flags.FFlagEnableCommunityProfileLoadingSkeletons)
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local HttpService = game:GetService("HttpService")

local StoreGrid = require(script.Parent.StoreGrid)
local StoreGridSkeleton = require(script.Parent.StoreGridSkeleton)
local var1 = memoize(function(arg1, arg2, arg3)
    local result = ({})
    local num2 = 1
    for _, value in arg1 do
        local var1 = if value.itemType == Enums.ItemTypes.Bundle then arg2[tostring(value.assetId)] else arg3[tostring(value.assetId)]

        if var1 then
            var1.itemType = value.itemType
            result[num2] = var1
            num2 += 1
        end
    end
    return result
end)

local function StoreContainer(tbl1)
    local var2 = useProfileWrapperContext()
    local var3 = useProfileAnalyticsContext()
    local var4 = useDispatch()
    local var5, var6 = React.useState(not not FFlagEnableCommunityProfileLoadingSkeletons)

    local var7 = useMarketplaceAnalyticsContext()

    local openItemDetails = React.useCallback(function(str1: string, str2: string, num2: number?)
        var2.navigateTo.itemOrBundleDetails(str1, str2)
        local fireAnalyticsEvent = var3.fireAnalyticsEvent
        local catalogItemOpened = EventNames.CatalogItemOpened
        local tbl2

        if FFlagProfilePlatformUseCatalogItemOpenedNewFields then
            tbl2 = { btnContext = 0, btnUnitId = 0, btnSortPosition = 0 }
            local store = Enums.Components.Store
            tbl2.btnContext = tostring(store)
            tbl2.btnUnitId = tostring(str1)
            tbl2.btnSortPosition = tostring(num2)
        else
            tbl2 = { source = 0, positionInComponent = 0, component = 0, itemId = 0 }
            local store = Enums.Components.Store
            tbl2.source = tostring(store)
            tbl2.positionInComponent = tostring(num2)
            local store2 = Enums.Components.Store
            tbl2.component = tostring(store2)
            tbl2.itemId = tostring(str1)
        end

        fireAnalyticsEvent(catalogItemOpened, tbl2)

        var2.externalAnalytics.catalogAnalytics.clickCatalogItemFromProfile(
            var7,
            str1,
            str2,
            tostring(Enums.Components.Store),
            num2
        )
    end, { var3, var2.navigateTo.itemOrBundleDetails, var2.externalAnalytics.catalogAnalytics })

    local var9 = useProfileJsonComponent(Enums.Components.Store).assets or {}

    local var10 = React.useCallback(function(arg1)
        local var10 = arg1[Constants.RODUX_KEY].BundleDetails or {}
        local var11 = arg1[Constants.RODUX_KEY].AssetDetails or {}
        return var1(var9, var10, var11)
    end, { var9 })

    local var11 = useSelector(var10)
    local var12 = if FFlagAXEnableProfileTab then useProfileFormFactor() else nil
    local bool2 = if FFlagAXEnableProfileTab then var2.forceFullView == true else nil
    local bool3 = if FFlagAXEnableProfileTab then var12.formFactor == Enums.ProfileFormFactor.Wide else nil
    local var13 = if FFlagAXEnableProfileTab and bool2 and bool3 then GetFIntProfilePlatformMeTabStoreItemLimit() else num1
    local num2 = if FFlagAXEnableProfileTab and bool2 and bool3 then 6 else 3

    local name = useProfileJsonComponent(Enums.Components.Store).name

    local profileType = var2.profileType
    local profileId = var2.profileId
    local var14 = if profileType == Enums.ProfileTypes.Community then HttpService:UrlEncode(name) else name

    local var15 = if FFlagProfilePlatformNavigateToMarketplaceWebView then React.useCallback(function()
        var3.fireAnalyticsEvent(EventNames.StoreHeaderButton)
        local detail = if profileType == Enums.ProfileTypes.Community then string.format("%scommunities/%s/CommunityName/#!/store", Url.BASE_URL, profileId) else string.format("%scatalog?CreatorName=%s", Url.BASE_URL, var14)
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                titleKey = TextKeys.Store
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var4(NavigateDown(tbl2))
    end, {
        var3,
        name,
        profileType,
        profileId
    }) else nil

    local var16 = React.useCallback(function()
        var3.fireAnalyticsEvent(EventNames.StoreHeaderButton)

        var2.navigateTo.catalogSearch(name)
    end, { var2.navigateTo.catalogSearch, name, var3 })

    React.useEffect(function()
        var4(NetworkingCatalog.GetItemAndBundleDetails.API(var9)):catch(function(_) end):finally(function()
            if FFlagEnableCommunityProfileLoadingSkeletons then
                var6(false)
            end
        end)
    end, { var9, var4 })

    if FFlagEnableCommunityProfileLoadingSkeletons and var5 then
        return React.createElement(
            StoreGridSkeleton,
            {
                layoutOrder = tbl1.layoutOrder,
                numSkeletons = #var9,
                numColumns = if FFlagAXEnableProfileTab then num2 else 3
            }
        )
    end
    if bool1 and #var11 == 0 then
        return nil
    end

    local createElement = React.createElement
    local var17 = StoreGrid
    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        assets = Dash.slice(var11, 1, var13),
        numColumns = if FFlagAXEnableProfileTab then num2 else 3,
        openItemDetails = openItemDetails,
        navigateToCatalogSearch = 0
    }

    if not FFlagProfilePlatformNavigateToMarketplaceWebView then
        var15 = var16
    end

    tbl2.navigateToCatalogSearch = var15
    return createElement(var17, tbl2)
end

return StoreContainer
