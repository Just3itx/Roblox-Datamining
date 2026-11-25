-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)

local Constants = require(ProfilePlatform.Common.Constants)
local SortCurrentlyWearing = require(ProfilePlatform.Components.CurrentlyWearing.SortCurrentlyWearing)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount
local Enums = require(ProfilePlatform.Common.Enums)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local NetworkingCurrentlyWearing = require(ProfilePlatform.Networking.NetworkingCurrentlyWearing)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useMarketplaceAnalyticsContext = require(ProfilePlatform.Hooks.useMarketplaceAnalyticsContext)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)
local NetworkingCatalog = require(ProfilePlatform.Networking.NetworkingCatalog)
local FFlagProfilePlatformEnableInventory = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableInventory
local FFlagProfilePlatformEnableStore = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableStore

local FFlagProfilePlatformUseCatalogItemOpenedNewFields = require(ProfilePlatform.Flags.FFlagProfilePlatformUseCatalogItemOpenedNewFields)
local FFlagAddIEMProfilePage = require(ProfilePlatformParent.SharedFlags).FFlagAddIEMProfilePage
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagProfileInspectAvatarCWEntry = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarCWEntry)
local GetInspectAvatarTooltipStore = require(ProfilePlatform.Stores.GetInspectAvatarTooltipStore)

local FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 = require(ProfilePlatform.Flags.FFlagSocialEnableProfileInspectAndBuyAnalyticsV2)
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local IXPService = game:GetService("IXPService")
local layerName = game:DefineFastString("SocialProfileCurrentlyWearingClickThroughLayer", "Social.ProfileCurrentlyWearingClickThrough")

local FFlagProfilePlatformEnableBundlesInAssetsCarousel = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableBundlesInAssetsCarousel

local AssetsCarousel = require(ProfilePlatform.Components.AssetsCarousel)

local function CurrentlyWearingCarousel(tbl1)
    local var1 = useDispatch()
    local var2 = useProfileWrapperContext()
    local var3 = useProfileAnalyticsContext()
    local var4 = if FFlagProfilePlatformEnableInventory then useLocalization({ currentlyWearing = TextKeys.CurrentlyWearing }) else nil
    local var5 = useMarketplaceAnalyticsContext()
    local source = if FFlagAddIEMProfilePage then var2.sourceInfo.source else nil
    local var6 = if FFlagProfileInspectAvatarCWEntry then useLocalUserId() else nil
    local bool1 = if FFlagProfileInspectAvatarCWEntry then tostring(var2.profileId) == tostring(var6) else nil
    local var7 = FFlagProfileInspectAvatarCWEntry and not bool1 and source ~= Enums.Sources.InExperienceProfile
    local var8 = if FFlagProfileInspectAvatarCWEntry then useNavigation() else nil
    local var9

    if FFlagProfileInspectAvatarCWEntry then
        local useCallback = React.useCallback
        local function func1()
            GetInspectAvatarTooltipStore(false).permanentlyDismiss()
            if FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then
                var3.fireAnalyticsEvent(EventNames.CurrentlyWearingHeaderButton)
            end
            var8.navigate(Enums.Screens.InspectAvatarSheet)
        end

        local var10 = if FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then var3 else nil
        var9 = useCallback(func1, { var8, var10 })
    else
        var9 = nil
    end

    local openItemDetails = React.useCallback(function(str1: string, str2: string, _: string?, _: string?, num1: number?)
        if FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then
            var2.navigateTo.inspectAvatar()
            return
        end

        if FFlagProfilePlatformEnableBundlesInAssetsCarousel then
            var2.navigateTo.itemOrBundleDetails(str1, str2)
        else
            var2.navigateTo.itemDetails(str1)
        end
        IXPService:LogFlagLinkedUserLayerExposure(layerName)
        if not FFlagProfilePlatformEnableStore then
            var3.fireAnalyticsEvent(EventNames.CatalogItemOpened)
            var2.externalAnalytics.catalogAnalytics.clickCatalogItemFromProfile(var5, str1, str2)

            return
        end

        local fireAnalyticsEvent = var3.fireAnalyticsEvent
        local catalogItemOpened = EventNames.CatalogItemOpened
        local tbl2

        if FFlagProfilePlatformUseCatalogItemOpenedNewFields then
            tbl2 = { btnContext = 0, btnUnitId = 0, btnSortPosition = 0 }
            local currentlyWearing = Enums.Components.CurrentlyWearing
            tbl2.btnContext = tostring(currentlyWearing)
            tbl2.btnUnitId = tostring(str1)
            tbl2.btnSortPosition = tostring(num1)
        else
            tbl2 = { source = 0, positionInComponent = 0, component = 0, itemId = 0 }
            local currentlyWearing = Enums.Components.CurrentlyWearing
            tbl2.source = tostring(currentlyWearing)
            tbl2.positionInComponent = tostring(num1)
            local currentlyWearing2 = Enums.Components.CurrentlyWearing
            tbl2.component = tostring(currentlyWearing2)
            tbl2.itemId = tostring(str1)
        end

        fireAnalyticsEvent(catalogItemOpened, tbl2)

        var2.externalAnalytics.catalogAnalytics.clickCatalogItemFromProfile(
            var5,
            str1,
            str2,
            tostring(Enums.Components.CurrentlyWearing),
            num1
        )
    end, {
        var2.navigateTo.itemDetails,
        var2.externalAnalytics.catalogAnalytics,
        var2.navigateTo.tryOnItem,
        var2.navigateTo.inspectAvatar,
        source
    })

    local var11 = useProfileJsonComponent(Enums.Components.CurrentlyWearing).assets or {}
    local var12 = nil
    local var13 = nil

    if FFlagProfilePlatformEnableBundlesInAssetsCarousel then
        local var14 = React.useCallback(function(arg1)
            local var14 = arg1[Constants.RODUX_KEY].BundleDetails or {}
            local var15 = arg1[Constants.RODUX_KEY].AssetDetails or {}
            local result = ({})
            local num1 = 1
            for _, value in var11 do
                local var16 = if value.itemType == Enums.ItemTypes.Bundle then var14[tostring(value.assetId)] else var15[tostring(value.assetId)]

                if var16 then
                    var16.itemType = value.itemType
                    result[num1] = var16
                    num1 += 1
                end
            end
            return result
        end, { var11 })

        var12 = useSelector(var14)

        React.useEffect(function()
            if #var11 > 0 then
                var1(NetworkingCatalog.GetItemAndBundleDetails.API(var11))
            end
        end, { var11, var1 })
    else
        local var14 = React.useMemo(function()
            return Cryo.List.map(var11, function(arg1)
                return arg1.assetId
            end)
        end, { var11 })

        useEffectOnMount(function()
            var1(NetworkingCurrentlyWearing.GetItemDetails.API(var14)):andThen(function(_) end):catch(function(_) end)
        end)

        local var15 = useSelector(function(arg1)
            return arg1[Constants.RODUX_KEY].ItemAssets or {}
        end)

        var13 = React.useMemo(function()
            local tbl2 = ({})

            local num1 = 1
            for _, value in var14 do
                local var16 = var15[tostring(value)]

                if var16 then
                    tbl2[num1] = var16
                    num1 += 1
                end
            end

            return Cryo.List.sort(tbl2, function(arg1, arg2)
                return SortCurrentlyWearing(arg1, arg2)
            end)
        end, { var15, var14 })
    end

    if FFlagProfilePlatformEnableBundlesInAssetsCarousel and not (#var12 > 0) then
        return nil
    end

    local createElement = React.createElement
    local var14 = AssetsCarousel
    local tbl2 = {
        title = if FFlagProfilePlatformEnableInventory then var4.currentlyWearing else nil,
        layoutOrder = tbl1.layoutOrder,
        assets = 0,
        openItemDetails = 0,
        onActivateHeader = 0,
        tileVariant = 0
    }

    if FFlagProfilePlatformEnableBundlesInAssetsCarousel then
        var13 = var12
    end

    tbl2.assets = var13
    tbl2.openItemDetails = openItemDetails
    if not var7 then
        var9 = nil
    end

    tbl2.onActivateHeader = var9

    tbl2.tileVariant = if FFlagAXEnableProfileTab then var2.currentlyWearingVariant else nil
    return (createElement(var14, tbl2))
end

return CurrentlyWearingCarousel
