-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Constants = require(ProfilePlatform.Common.Constants)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local Url = require(ProfilePlatformParent.Http).Url
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local Enums = require(ProfilePlatform.Common.Enums)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local NetworkingCatalog = require(ProfilePlatform.Networking.NetworkingCatalog)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useMarketplaceAnalyticsContext = require(ProfilePlatform.Hooks.useMarketplaceAnalyticsContext)
local AssetsCarousel = require(ProfilePlatform.Components.AssetsCarousel)
local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)

local FFlagProfilePlatformUseCatalogItemOpenedNewFields = require(ProfilePlatform.Flags.FFlagProfilePlatformUseCatalogItemOpenedNewFields)
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil

local function InventoryContainer(tbl1)
    local var1 = useProfileWrapperContext()
    local var2 = useProfileAnalyticsContext()
    local profileId = var1.profileId
    local var3 = useDispatch()
    local var4 = useLocalization({ inventory = TextKeys.Inventory })

    local var5 = useMarketplaceAnalyticsContext()

    local openItemDetails = React.useCallback(function(str1: string, str2: string, _: string?, _: string?, num1: number?)
        var1.navigateTo.itemDetails(str1)
        local fireAnalyticsEvent = var2.fireAnalyticsEvent
        local catalogItemOpened = EventNames.CatalogItemOpened
        local tbl2

        if FFlagProfilePlatformUseCatalogItemOpenedNewFields then
            tbl2 = { btnContext = 0, btnUnitId = 0, btnSortPosition = 0 }
            local inventory = Enums.Components.Inventory
            tbl2.btnContext = tostring(inventory)
            tbl2.btnUnitId = tostring(str1)
            tbl2.btnSortPosition = tostring(num1)
        else
            tbl2 = {
                positionInComponent = tostring(num1),
                component = 0,
                itemId = 0
            }
            local inventory = Enums.Components.Inventory
            tbl2.component = tostring(inventory)
            tbl2.itemId = tostring(str1)
        end

        fireAnalyticsEvent(catalogItemOpened, tbl2)

        var1.externalAnalytics.catalogAnalytics.clickCatalogItemFromProfile(var5, str1, str2, Enums.Components.Inventory, num1)
    end, { var2, var1.navigateTo.itemDetails, var1.externalAnalytics.catalogAnalytics })

    local var7 = useProfileJsonComponent(Enums.Components.Inventory).assets or {}

    local var8 = useSelector(function(arg1)
        return arg1[Constants.RODUX_KEY].AssetDetails or {}
    end)

    local assets = React.useMemo(function()
        local result = {}

        for _, value in var7 do
            local var9 = var8[tostring(value.assetId)]
            if var9 then
                var9.itemType = value.itemType
                table.insert(result, var9)
            end
        end
        return result
    end, { var7, var8 })

    local onActivateHeader = React.useCallback(function()
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = string.format("%susers/%s/inventory", Url.BASE_URL, profileId),
            extraProps = {
                titleKey = TextKeys.Inventory
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var3(NavigateDown(tbl2))
    end)

    React.useEffect(function()
        var3(NetworkingCatalog.GetItemAndBundleDetails.API(var7))
    end, { var7, var3 })

    if not (#assets > 0) then
        return nil
    end

    return (React.createElement(AssetsCarousel, {
        title = var4.inventory,
        layoutOrder = tbl1.layoutOrder,
        assets = assets,
        openItemDetails = openItemDetails,
        onActivateHeader = onActivateHeader
    }))
end
return InventoryContainer
