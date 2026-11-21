-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local NotificationService = game:GetService("NotificationService")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Promise = require(AvatarExperienceCatalogParent.Promise)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local mutedError = require(AvatarExperienceCatalogParent.Loggers).mutedError
local _Http = require(AvatarExperienceCatalogParent.Http)
local RoactUtils = require(AvatarExperienceCatalogParent.RoactUtils)
local SignalsReact = require(AvatarExperienceCatalogParent.SignalsReact)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ToastRodux = require(AvatarExperienceCatalogParent.ToastRodux)
local RobloxSubscriptionPurchaseApp = require(AvatarExperienceCatalogParent.RobloxSubscriptionPurchaseApp)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local RobloxEventReceiver = require(AvatarExperienceCatalogParent.RealtimeDelivery).RobloxEventReceiver

local _CheckoutPage = require(AvatarExperienceCatalog.Components.Checkout.CheckoutPage)

local PurchaseItemsSuccessThunk = require(AvatarExperienceCatalog.State.Thunks.PurchaseItemsSuccessThunk)
local SaveAsAvatarThunk = require(AvatarExperienceCatalog.State.Thunks.SaveAsAvatarThunk)
local SaveAsMakeupLookThunk = require(AvatarExperienceCatalog.State.Thunks.SaveAsMakeupLookThunk)
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local SetSelectedTimedOption = require(AvatarExperienceCatalog.State.Actions.SetSelectedTimedOption)
local CloseCentralOverlay = require(AvatarExperienceCatalogParent.CentralOverlay).Thunks.CloseCentralOverlay

local Constants = AvatarExperienceCommon.Constants
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen
local ToastType = ToastRodux.Enums.ToastType
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local DiscountTypeEnum = AvatarExperienceCommon.Enums.DiscountTypeEnum

local PurchaseItems = require(AvatarExperienceCatalog.Requests.PurchaseItems)
local getRobloxSubscriptionProducts = RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProducts

local avatarLastEquippedStateStore = AvatarExperienceCommon.Stores.AvatarLastEquippedStateStore.avatarLastEquippedStateStore

local mapPurchaseItemsResponse = require(AvatarExperienceCatalog.Requests.PurchaseItems.mapPurchaseItemsResponse)
local getEquippableAssetsFromTryOnItems = require(AvatarExperienceCatalog.Utils.TryOns.getEquippableAssetsFromTryOnItems)
local getTryOnItemsContainsOnlyMakeupTypes = require(AvatarExperienceCatalog.Utils.TryOns.getTryOnItemsContainsOnlyMakeupTypes)
local getTryOnItemReducerKey = AvatarExperienceCommon.Utils.getTryOnItemReducerKey
local _createAXShoppingCartStore = require(AvatarExperienceCatalog.Stores.createAXShoppingCartStore)
local getIsInsufficientRobuxError = AvatarExperienceCommon.Utils.getIsInsufficientRobuxError

local useAXCatalogStoreContext = require(AvatarExperienceCatalog.Context.useAXCatalogStoreContext)
local useOffersCartPricingCalculationsForCartItems = require(AvatarExperienceCatalog.Hooks.useOffersCartPricingCalculationsForCartItems)
local useSignalState = SignalsReact.useSignalState
local useNetworking = AvatarExperienceCommon.Hooks.useNetworking
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useAppPolicy = require(AvatarExperienceCatalogParent.UniversalAppPolicy).useAppPolicy
local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation
local useNavigationFocus = require(AvatarExperienceCatalogParent.Navigation).useNavigationFocus
local useSaveOptionsStoredValues = require(AvatarExperienceCatalog.Hooks.useSaveOptionsStoredValues)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local LocalizationRoactContext = require(AvatarExperienceCatalogParent.Localization).LocalizationRoactContext

local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local sendUnifiedEventForDeferredAction = AvatarExperienceAnalytics.sendUnifiedEventForDeferredAction
local getUnifiedLoggingSurface = AvatarExperienceAnalytics.Utils.getUnifiedLoggingSurface
local getMarketplaceUnifiedAssetType = AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedAssetType
local getMarketplaceUnifiedBundleType = AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedBundleType
local sendUnifiedEventsForMultiItemShopping = AvatarExperienceAnalytics.sendUnifiedEventsForMultiItemShopping
local getUnifiedEventsForMIS = AvatarExperienceAnalytics.Utils.getUnifiedEventsForMIS
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedEventLogConstants = AvatarExperienceAnalytics.UnifiedEventLogConstants
local UnifiedSelectionListStore = AvatarExperienceAnalytics.Store.UnifiedSelectionListStore
local CartIdService = AvatarExperienceAnalytics.Lib.CartIdService

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagAXMISWithOffers = AvatarExperienceFlags.FFlagAXMISWithOffers
local FFlagAXMISOffersChip = AvatarExperienceFlags.FFlagAXMISOffersChip
local FFlagAXEnableExpiredUserLookCheckout = AvatarExperienceFlags.FFlagAXEnableExpiredUserLookCheckout
local FFlagAXCatalogMakeupSupport = AvatarExperienceFlags.FFlagAXCatalogMakeupSupport

local FFlagAXRevertEquippedAssetsAfterLayeringTryOnMakeup = AvatarExperienceFlags.FFlagAXRevertEquippedAssetsAfterLayeringTryOnMakeup
local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads
local FFlagAXMISSaveWearFix = AvatarExperienceFlags.FFlagAXMISSaveWearFix
local FFlagAXBackgroundsEquipTryOnCounters = AvatarExperienceFlags.FFlagAXBackgroundsEquipTryOnCounters
local FIntBlackbirdUpsellMinPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMinPriceForDiscountInclusive
local FIntBlackbirdUpsellMaxPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMaxPriceForDiscountInclusive
local reportBackgroundUserActionCounter = AvatarExperienceAnalytics.reportBackgroundUserActionCounter
local bool1 = game:DefineFastFlag("AXFixSelectUserRobloxSubscriptionNil", false)

local function selectTryOnLookId(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.LookId
end

local var1 = nil
var1 = FFlagAXCatalogMakeupSupport and function(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.MakeupLookId
end or var1

local var2 = nil
local var3 = nil
if FFlagAXMISEnableMultiShoppingUnifiedEvents then
    var2 = function(arg1)
        return arg1.AvatarExperience.AvatarScene.OutfitTryOn.LookAnalyticsInfo
    end

    var3 = function(arg1)
        return arg1.AvatarExperience.AvatarScene.OutfitTryOn.MakeupLookAnalyticsInfo
    end
end

local function selectAvatarSceneLooks(arg1)
    return arg1.AvatarExperience.AvatarScene.Looks
end

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function selectTryOnItems(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.TryOnItems
end

local function selectTryOnBodyColor3s(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.BodyColor3s
end

local function selectTryOnBodyScales(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.Scale
end

local function selectTryOnBodyPartColorRangeIds(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.BodyPartColorRangeIds
end

local function selectAssetInfos(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AvatarExperience.Common.AssetInfos or {}
end

local function selectBundleInfos(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AvatarExperience.Common.BundleInfos or {}
end

local function selectCollectibles(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AvatarExperience.Common.Collectibles or {}
end

local function selectLocalUserId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.LocalUserId
end

local function selectShouldTryOnWithoutEquippedItems(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.ShouldTryOnWithoutEquippedItems
end

local function selectUserRobux(arg1)
    local var4 = selectLocalUserId(arg1)

    return if var4 and arg1.UserRobux then arg1.UserRobux[var4] else nil
end

local function func1(arg1)
    local var4 = selectLocalUserId(arg1)

    return if var4 and arg1.Users and (not bool1 or arg1.Users[var4]) then arg1.Users[var4].hasRobloxSubscription else false
end

local function selectItemInfoForTryOnItems(arg1)
    local var4 = selectTryOnItems(arg1)
    local var5 = selectAssetInfos(arg1)
    local var6 = selectBundleInfos(arg1)
    local var7 = selectCollectibles(arg1)
    local result = {}
    for _, value in var4 do
        if value.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
            table.insert(result, {
                itemId = value.itemId,
                itemType = value.itemType,
                itemData = value.itemData,
                collectibleItemId = value.itemId,
                ordering = value.itemRecency
            })
        else
            local itemData = if value.itemType == Enum.AvatarItemType.Asset.Name then var5[value.itemId] else var6[value.itemId]
            local collectibleItemId = if itemData then itemData.collectibleItemId else nil
            local collectibleItemInfo = if collectibleItemId and var7.CollectiblesItemInfo then var7.CollectiblesItemInfo[collectibleItemId] else nil

            if itemData and collectibleItemId and collectibleItemInfo then
                local resellableInstances = if var7.CollectiblesResellableInstances then var7.CollectiblesResellableInstances[collectibleItemId] else nil
                table.insert(result, {
                    itemId = value.itemId,
                    itemType = value.itemType,
                    itemData = itemData,
                    collectibleItemId = collectibleItemId,
                    ordering = value.itemRecency,
                    collectibleItemInfo = collectibleItemInfo,
                    resellableInstances = resellableInstances,
                    selectedTimedOptionIndex = if FFlagAXDurablesForMIS then value.selectedTimedOptionIndex else nil
                })
            end
        end
    end

    return result
end

local function func2(arg1, discountedItemsFromOffers)
    local result = {}
    for _, value in arg1 do
        local var4 = table.clone(value)

        if discountedItemsFromOffers[var4.collectibleItemId] then
            var4.discountInformation = discountedItemsFromOffers[var4.collectibleItemId].discountInformation or {}
            var4.priceInRobuxDiscountedByOffers = discountedItemsFromOffers[var4.collectibleItemId].priceInRobux
            var4.offerApplied = if FFlagAXMISOffersChip then #discountedItemsFromOffers[var4.collectibleItemId].offerIdsApplied > 0 else nil
        end

        table.insert(result, var4)
    end
    return result
end

local function useCheckoutPageViewModel(tbl1)
    local purchasePromptLite = require(AvatarExperienceCatalogParent.PurchasePromptLite)

    local shoppingCartStore = useAXCatalogStoreContext().shoppingCartStore

    local var4 = useNavigation()
    local var5 = useAvatarRoute()
    local networkImpl = useNetworking()
    local var7 = useDispatch()
    local var8 = if FFlagAXMISWithOffers then useSaveOptionsStoredValues() else nil
    local var9 = useSignalState(shoppingCartStore.getItems)
    local var10 = if FFlagAXUnifiedEventStrictPayloads then useSelector(selectScreenSize) else nil
    local var11 = if FFlagAXMISWithBlackbird then useSignalState(shoppingCartStore.getDiscounts) else nil
    local canPurchase = useSignalState(shoppingCartStore.getCanPurchase)
    local priceInRobux = useSignalState(shoppingCartStore.getPurchasableItemsTotalPriceInRobux)

    local var14 = useSignalState(shoppingCartStore.getPurchasableItemsTotalOriginalPriceInRobux)
    local erroredItemCount = useSignalState(shoppingCartStore.getErroredItemCount)

    local var16 = nil
    local var17 = nil
    if FFlagAXMISWithOffers then
        var16, var17 = React.useState(false)
    end
    local isWearAfterPurchaseChecked, var19 = React.useState(not FFlagAXMISWithOffers or not var8 or var8.getWearAfterPurchase())

    local isAddToMyAvatarsChecked, var21 = React.useState(if FFlagAXMISWithOffers and var8 then var8.getAddToAvatars() else false)

    local isPurchasing, var23 = React.useState(false)
    local var24 = nil
    local var25 = nil
    if FFlagAXMISWithBlackbird then
        local var26
        var24, var26 = React.useState({})
        var25 = var26
    end
    local var26 = nil
    local var27 = nil
    if FFlagAXMISWithOffers then
        local var28
        var26, var28 = React.useState(false)
        var27 = var28
    end

    local var28 = useSelector(selectTryOnItems, tutils.deepEqual)
    local var29 = useSelector(selectTryOnBodyColor3s, tutils.deepEqual)
    local var30 = useSelector(selectTryOnBodyScales, tutils.deepEqual)
    local var31 = useSelector(selectTryOnBodyPartColorRangeIds, tutils.deepEqual)
    local var32 = useSelector(selectTryOnLookId)
    local itemId = if FFlagAXCatalogMakeupSupport then useSelector(var1) else nil
    local var34 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then useSelector(var2) else nil
    local var35 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then useSelector(var3) else nil
    local var36 = useSelector(selectAvatarSceneLooks, tutils.deepEqual)
    local var37 = useSelector(selectItemInfoForTryOnItems, tutils.deepEqual)
    local var38 = useSelector(selectShouldTryOnWithoutEquippedItems)
    local userId = useSelector(selectLocalUserId)
    local var40 = useSelector(selectUserRobux)
    local var41 = if FFlagAXMISWithBlackbird then useSelector(func1) else nil
    local var42 = useLocalization({
        purchaseFailedTitle = "Feature.Catalog.Title.Checkout.PurchaseFailedSingular",
        purchaseFailedTitlePlural = {
            "Feature.Catalog.Title.Checkout.PurchaseFailedPlural",
            count = #var9
        },
        purchaseFailedUnknownError = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName",
        purchaseFailedButton = "Feature.Avatar.Action.GotIt",
        characterSavedHeading = "Feature.Avatar.Heading.LooksAvatarSaved",
        characterSavedMsg = "Feature.Avatar.Message.LooksAvatarSaved"
    })

    local var43 = React.useContext(LocalizationRoactContext)
    local var44 = useAppPolicy(function(arg1)
        return arg1.getDisableResellingCollectiblesForCompliance()
    end)

    local var45 = if FFlagAXMISWithBlackbird then useAppPolicy(function(arg1)
        return arg1.getDisableBlackbirdEntrypoints()
    end) else nil

    local var46 = React.useRef(false)

    local var47 = useNavigationFocus()

    local var48 = nil
    if FFlagAXEnableExpiredUserLookCheckout then
        local var49 = React.useMemo(function()
            return RobloxEventReceiver.new(NotificationService)
        end, {})
        var48 = React.useRef(nil)

        if var49 ~= nil then
            local current = var49:observeEvent("AvatarAssetOwnershipNotifications", function()
                if (if FFlagAXEnableExpiredUserLookCheckout then var5 and var5.current and var5.current.name else nil) == AvatarScreen.ExpiredUserLookCheckout then
                    var4.pop(2)
                end
            end)

            var48.current = current
        end
    end

    React.useEffect(function()
        if tbl1.fetchUserRobux and not var40 then
            tbl1.fetchUserRobux()
        end

        if FFlagAXMISWithBlackbird then
            getRobloxSubscriptionProducts():andThen(function(arg1)
                var25(arg1)
            end):catch(function(arg1)
                mutedError("CheckoutPageViewModel", "Failed to fetch Roblox subscription products: " .. tostring(arg1))
            end)
        end

        return function()
            if FFlagAXEnableExpiredUserLookCheckout and var48.current ~= nil then
                var48.current:disconnect()
                var48.current = nil
            end
        end
    end, {})

    React.useEffect(function()
        if var47 and var46.current and tbl1.fetchUserRobux then
            tbl1.fetchUserRobux()
            var46.current = false
        end
    end, { var47, tbl1.fetchUserRobux })

    local useLayoutEffect = React.useLayoutEffect
    local function func3()
        shoppingCartStore.syncFromTryOns(var37, var44)
        if FFlagAXMISWithOffers then
            var27(true)
        end

        local name = if FFlagAXEnableExpiredUserLookCheckout then var5 and var5.current and var5.current.name else nil

        if FFlagAXEnableExpiredUserLookCheckout then
            if var37 and #var37 <= 0 and (name == AvatarScreen.Checkout or name == AvatarScreen.ExpiredUserLookCheckout) then
                var4.goBack()
            end
        elseif var37 and #var37 <= 0 then
            var4.goBack()
        end
    end

    local var49 = if FFlagAXEnableExpiredUserLookCheckout then var5 else nil
    useLayoutEffect(func3, { shoppingCartStore, var37, var44, var4, var49 })

    local isVisible = React.useMemo(function(): boolean
        local name = var5 and var5.current and var5.current.name

        if FFlagAXEnableExpiredUserLookCheckout then
            return name == AvatarScreen.ExpiredUserLookCheckout or name == AvatarScreen.Checkout
        end

        return name == AvatarScreen.Checkout
    end, { var5 })

    local var51 = if FFlagAXMISWithOffers then useOffersCartPricingCalculationsForCartItems(var9, isVisible, var26) else nil

    local useMemo = React.useMemo
    local function func4()
        local result = {}
        for value, value2 in var9 do
            table.insert(
                result,
                Cryo.Dictionary.join(value2, {
                    onActivated = function()
                        if value2.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
                            return
                        end
                        if tbl1.onOpenItemDetailsPage then
                            tbl1.onOpenItemDetailsPage(value2.itemId, value2.itemType, value2.itemSubType)
                        end
                    end,
                    onRemove = function()
                        if not tbl1.onRemoveItem then
                            return
                        end
                        if FFlagAXBackgroundsEquipTryOnCounters then
                            reportBackgroundUserActionCounter.reportIfAvatarBackgroundAsset("RemoveTryOn", value2.itemType, value2.itemSubType)
                        end

                        tbl1.onRemoveItem(value2.itemId, value2.itemType)

                        if not FFlagAXMISEnableMultiShoppingUnifiedEvents then
                            return
                        end

                        local var52 = nil
                        if value2.itemType == "Asset" then
                            var52 = UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET
                        elseif value2.itemType == "Bundle" then
                            var52 = UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE
                        end

                        local var53 = nil
                        local var54 = nil
                        local var55 = nil
                        local var56 = nil
                        local var57 = nil
                        local var58 = nil
                        if FFlagAXUnifiedEventStrictPayloads then
                            local attributePrefix = UnifiedEventLogConstants.ATTRIBUTE_PREFIX
                            local var59 = attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_ID
                            local var60 = attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_TYPE
                            for _, value3 in UnifiedSelectionListStore.getSelectionList() do
                                local str1 = tostring(value3[var59])

                                if str1 ~= tostring(value2.itemId) or tostring(value3[var60]) ~= tostring(var52) then
                                    continue
                                end

                                var53 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_GRID_POSITION_ROW]

                                var54 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_GRID_POSITION_COLUMN]

                                var55 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_ELEMENT_SIZE_HEIGHT]

                                var56 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_ELEMENT_SIZE_WIDTH]

                                var57 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_SCREEN_SIZE_HEIGHT]

                                var58 = value3[attributePrefix .. UnifiedEventLogConstants.FIELD_SCREEN_SIZE_WIDTH]
                                break
                            end
                        end

                        local tbl2 = {
                            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_DESELECTED,
                            cartId = CartIdService.getCartId(),
                            itemId = value2.itemId,
                            itemType = 0,
                            assetType = 0,
                            bundleType = 0,
                            gridPositionRow = 0,
                            gridPositionColumn = 0,
                            elementSizeHeight = 0,
                            elementSizeWidth = 0,
                            screenSizeHeight = 0,
                            screenSizeWidth = 0
                        }
                        if FFlagAXUnifiedEventStrictPayloads then
                            if value2.itemType == "Asset" then
                                var52 = UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET
                            else
                                var52 = UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE
                            end
                        end

                        tbl2.itemType = var52

                        tbl2.assetType = if value2.itemType ~= "Asset" then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(value2.itemSubType) else value2.itemSubType

                        tbl2.bundleType = if value2.itemType == "Asset" then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(value2.itemSubType) else value2.itemSubType

                        tbl2.gridPositionRow = if FFlagAXUnifiedEventStrictPayloads then var53 or value else nil

                        tbl2.gridPositionColumn = FFlagAXUnifiedEventStrictPayloads and (var54 or 1) or nil

                        if not FFlagAXUnifiedEventStrictPayloads then
                            var55 = nil
                        end

                        tbl2.elementSizeHeight = var55

                        if not FFlagAXUnifiedEventStrictPayloads then
                            var56 = nil
                        end

                        tbl2.elementSizeWidth = var56

                        if FFlagAXUnifiedEventStrictPayloads then
                            if not var57 then
                                if var10 then
                                    var57 = math.round(var10.Y)
                                else
                                    var57 = nil
                                end
                            end
                        else
                            var57 = nil
                        end

                        tbl2.screenSizeHeight = var57

                        if FFlagAXUnifiedEventStrictPayloads then
                            if not var58 then
                                if var10 then
                                    var58 = math.round(var10.X)
                                else
                                    var58 = nil
                                end
                            end
                        else
                            var58 = nil
                        end

                        tbl2.screenSizeWidth = var58

                        sendUnifiedEventForDeferredAction(
                            tbl2,
                            FFlagAXUnifiedEventStrictPayloads and {
                                surface = getUnifiedLoggingSurface(var5)
                            } or nil
                        )
                    end,
                    onTimedOptionPriceChanged = FFlagAXDurablesForMIS and function(num1: number, days: number?)
                        if not shoppingCartStore.updateItemPrice then
                            return
                        end

                        if value2.timedOptions then
                            local selectedTimedOptionIndex = Cryo.List.findWhere(value2.timedOptions, function(arg1): boolean
                                return arg1.days == days
                            end) or #value2.timedOptions

                            var7(
                                SetSelectedTimedOption(
                                    {
                                        itemId = value2.itemId,
                                        itemType = value2.itemType,
                                        selectedTimedOptionIndex = selectedTimedOptionIndex
                                    }
                                )
                            )
                        end

                        shoppingCartStore.updateItemPrice(value2.itemId, value2.itemType, num1, days)
                    end or nil
                })
            )
        end

        if FFlagAXMISWithOffers and var51.discountedItemsFromOffers and #Cryo.Dictionary.keys(var51.discountedItemsFromOffers) > 0 then
            result = func2(result, var51.discountedItemsFromOffers)
        end

        return result
    end

    local var52 = if FFlagAXUnifiedEventStrictPayloads then var10 else nil
    local var53 = if FFlagAXUnifiedEventStrictPayloads then var5 else nil
    local onOpenItemDetailsPage = tbl1.onOpenItemDetailsPage
    local onRemoveItem = tbl1.onRemoveItem
    local var54 = if FFlagAXDurablesForMIS then shoppingCartStore else nil
    local var55 = if FFlagAXDurablesForMIS then var7 else nil
    local discountedItemsFromOffers = if FFlagAXMISWithOffers then var51.discountedItemsFromOffers else nil
    local cartItems = useMemo(func4, { var9, var52, var53, onOpenItemDetailsPage, onRemoveItem, var54, var55, discountedItemsFromOffers })

    local var57 = if FFlagAXEnableExpiredUserLookCheckout then React.useMemo(function(): boolean
        return (var5 and var5.current and var5.current.name) == AvatarScreen.ExpiredUserLookCheckout
    end, { var5 }) else nil

    local var58

    if FFlagAXMISWithBlackbird then
        local useMemo2 = React.useMemo
        local function func5()
            if not var41
                and not var45
                and (not FFlagAXMISWithOffers or FFlagAXMISWithOffers and #Cryo.Dictionary.keys(var51.offersAvailable) == 0)
            then
                for _, value in var9 do
                    local priceInRobux = value.priceInRobux

                    if FIntBlackbirdUpsellMinPriceForDiscountInclusive <= priceInRobux
                        and value.priceInRobux <= FIntBlackbirdUpsellMaxPriceForDiscountInclusive
                        and (not value.isOwned or value.isOwned and value.expirationTime)
                    then
                        return true
                    end
                end
            end

            return false
        end

        local offersAvailable = if FFlagAXMISWithOffers then var51.offersAvailable else nil
        var58 = useMemo2(func5, { var41, var45, var9, offersAvailable })
    else
        var58 = nil
    end

    local var6 = React.useCallback(function(str1: string, str2: string, _: string)
        if tbl1.onRemoveItem then
            tbl1.onRemoveItem(str1, str2)
        end
    end, { tbl1.onRemoveItem, var28, var4 })

    local var12 = React.useCallback(function(str1: string, str2: string, str3: string)
        if tbl1.onOpenItemDetailsPage then
            tbl1.onOpenItemDetailsPage(str1, str2, str3)
        end
    end, { tbl1.onOpenItemDetailsPage })

    local onUnavailableButtonActivated = React.useCallback(function()
        var4.navigate(AvatarScreen.CartUnavailableItemsPrompt)
    end, { var4 })

    local useCallback = React.useCallback

    local function func5()
        var19(not isWearAfterPurchaseChecked)
        if FFlagAXMISWithOffers and var8 then
            var8.setWearAfterPurchase(not isWearAfterPurchaseChecked)
        end
    end

    local var62 = if FFlagAXMISWithOffers then var8 else nil
    local onWearAfterPurchaseToggle = useCallback(func5, { isWearAfterPurchaseChecked, var62 })

    local useCallback2 = React.useCallback

    local function func6()
        var21(not isAddToMyAvatarsChecked)
        if FFlagAXMISWithOffers and var8 then
            var8.setAddToAvatars(not isAddToMyAvatarsChecked)
        end
    end

    local var64 = if FFlagAXMISWithOffers then var8 else nil
    local onAddToMyAvatarsToggle = useCallback2(func6, { isAddToMyAvatarsChecked, var64 })

    local onSaveOptionsOpenToggle = if FFlagAXMISWithOffers then React.useCallback(function()
        var17(not var16)
    end, { var16 }) else nil

    local useCallback3 = React.useCallback

    local function func7()
        local result = {}
        for _, value in var9 do
            if value.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
                continue
            end

            local discountedItemsFromOffer = if FFlagAXMISWithOffers then var51.discountedItemsFromOffers[value.collectibleItemId] else nil
            local tbl2 = {
                agreedPriceRobux = if FFlagAXMISWithOffers and discountedItemsFromOffer then discountedItemsFromOffer.priceInRobux else value.priceInRobux,
                collectibleProductId = value.collectibleProductId,
                collectibleItemId = if FFlagAXMISWithOffers then value.collectibleItemId else nil,
                rentalOption = if FFlagAXDurablesForMIS and value.selectedTimedOptionDays and value.selectedTimedOptionDays > 0 then {
                    durationDays = value.selectedTimedOptionDays
                } else nil,
                offerIds = if FFlagAXMISWithOffers and discountedItemsFromOffer then discountedItemsFromOffer.offerIdsApplied else nil
            }
            table.insert(result, tbl2)
        end

        return result
    end

    local var67 = if FFlagAXMISWithOffers then var51 else nil
    local var68 = useCallback3(func7, { var9, var67 })

    local var69 = React.useCallback(function()
        local tbl2 = {
            isLocalized = true,
            toastMessage = var42.characterSavedHeading,
            toastSubMessage = var42.characterSavedMsg,
            toastType = ToastType.SuccessConfirmation
        }
        var7(SetCurrentToastMessage(tbl2))
    end, { var7, var42 })

    local useCallback4 = React.useCallback

    local function func8(arg1)
        if not FFlagAXCatalogMakeupSupport then
            local var70 = if var36 and var36[var32] and var36[var32].name then var36[var32].name else "Avatar"

            var7(SaveAsAvatarThunk(var70, tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn, arg1, var69))

            return
        end

        local tryOnItemsContainsOnlyMakeupTypes = getTryOnItemsContainsOnlyMakeupTypes(arg1)

        local var70 = not (var36 and var36[itemId] and var36[itemId].name)
            and (if tryOnItemsContainsOnlyMakeupTypes then "Makeup" else "Avatar")
            or var36[itemId].name

        if var36 and var36[var32] and var36[var32].name then
            var70 = var36[var32].name
        end

        if not tryOnItemsContainsOnlyMakeupTypes then
            var7(SaveAsAvatarThunk(var70, tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn, arg1, var69))
        elseif FFlagAXMISSaveWearFix then
            var7(
                SaveAsMakeupLookThunk(networkImpl, var70, arg1, nil, tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn)
            )
        else
            var7(SaveAsMakeupLookThunk(networkImpl, var70, arg1))
        end
    end
    local getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn = tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn
    local var70 = if FFlagAXCatalogMakeupSupport then networkImpl else nil
    local var71 = if FFlagAXCatalogMakeupSupport then itemId else nil
    local var72 = useCallback4(
        func8,
        {
            var7,
            var69,
            getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn,
            var36,
            var32,
            var70,
            var71
        }
    )

    local useCallback5 = React.useCallback
    local function func9(arg1, tbl2)
        local var73 = shoppingCartStore.updateCartFromPurchaseResponse(arg1)
        local boughtItems = var73.boughtItems
        local equippableItems = var73.equippableItems
        local needDataRefeshItems = var73.needDataRefeshItems
        local var74, var75

        if FFlagAXMISEnableMultiShoppingUnifiedEvents then
            var74 = var36[var32]
            if var74 ~= nil then
                var74 = table.clone(var74)
                var74.itemId = var32
            end

            var75 = var36[itemId]
            if var75 ~= nil then
                var75 = table.clone(var75)
                var75.itemId = itemId
            end
        else
            var74 = nil
            var75 = nil
        end

        for _, needDataRefeshItem in needDataRefeshItems do
            if tbl1.fetchItemData then
                tbl1.fetchItemData(needDataRefeshItem.itemId, needDataRefeshItem.itemType)
            end
        end

        var7(
            SetCurrentToastMessage({
                toastMessage = var43:Format("Feature.Catalog.Title.Checkout.ItemsPurchased", { count = #boughtItems }),
                isLocalized = true,
                toastType = ToastType.InformationMessage
            })
        )

        local tbl3 = {}
        for _, equippableItem in equippableItems do
            local var76 = tbl2[getTryOnItemReducerKey(equippableItem.itemId, equippableItem.itemType)]
            if var76 then
                table.insert(tbl3, var76)
            end
        end

        if isAddToMyAvatarsChecked then
            var72(tbl3)
        end

        if not FFlagAXMISSaveWearFix then
            for _, equippableItem in equippableItems do
                if tbl1.onRemoveItem then
                    tbl1.onRemoveItem(equippableItem.itemId, equippableItem.itemType)
                end
            end
        end

        local tbl4 = {}

        if not FFlagAXMISSaveWearFix and FFlagAXRevertEquippedAssetsAfterLayeringTryOnMakeup then
            avatarLastEquippedStateStore.setShouldRevertLastEquippedState(false)
        end

        if isWearAfterPurchaseChecked then
            tbl4 = getEquippableAssetsFromTryOnItems(tbl3)
        end

        local bool2 = itemId ~= nil

        local var76 = var7
        local var77 = PurchaseItemsSuccessThunk

        local var78 = var38
        local var79 = var29
        local var80 = var30
        local var81 = var31

        local getBundleOutfitInfoFromProvidedTryOns = tbl1.getBundleOutfitInfoFromProvidedTryOns

        if not FFlagAXMISEnableMultiShoppingUnifiedEvents then
            var74 = nil
        end

        if not FFlagAXMISEnableMultiShoppingUnifiedEvents then
            var75 = nil
        end

        var76(
            var77(
                boughtItems,
                tbl4,
                var78,
                var79,
                var80,
                var81,
                tbl3,
                getBundleOutfitInfoFromProvidedTryOns,
                bool2,
                var74,
                var75,
                if FFlagAXMISSaveWearFix then tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn else nil
            )
        )

        if not FFlagAXMISSaveWearFix then
            return
        end
        for _, equippableItem in equippableItems do
            if tbl1.onRemoveItem then
                tbl1.onRemoveItem(equippableItem.itemId, equippableItem.itemType)
            end
        end

        if FFlagAXRevertEquippedAssetsAfterLayeringTryOnMakeup then
            avatarLastEquippedStateStore.setShouldRevertLastEquippedState(false)
        end
    end

    local updateCartFromPurchaseResponse = shoppingCartStore.updateCartFromPurchaseResponse

    local onRemoveItem2 = tbl1.onRemoveItem
    local fetchItemData = tbl1.fetchItemData
    local getBundleOutfitInfoFromProvidedTryOns = tbl1.getBundleOutfitInfoFromProvidedTryOns
    local var73 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var32 else nil
    local var74 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var36 else nil
    local getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn2 = if FFlagAXMISSaveWearFix then tbl1.getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn else nil
    local var75 = useCallback5(func9, {
        var7,
        updateCartFromPurchaseResponse,
        isWearAfterPurchaseChecked,
        isAddToMyAvatarsChecked,
        var29,
        var30,
        var31,
        var38,
        var72,
        onRemoveItem2,
        fetchItemData,
        getBundleOutfitInfoFromProvidedTryOns,
        itemId,
        var73,
        var74,
        getCombinedHumanoidDescriptionFromEquippedAndOutfitTryOn2
    })

    local var76 = if FFlagAXMISWithBlackbird then React.useCallback(function()
        local var76 = nil
        if var11 then
            for _, value in var11 do
                if value.discountCampaign == DiscountTypeEnum.RobloxPlusSubscription then
                    var76 = value
                    break
                end
            end
        end

        local tbl2 = {}
        if var76 then
            table.insert(tbl2, 1, {
                Type = DiscountTypeEnum.RobloxPlusSubscription,
                AmountInRobux = var14 - priceInRobux,
                Percent = var76.robuxDiscountPercentage
            })
        end
        if var51.discountSummaryEntriesFromOffers then
            for _, discountSummaryEntriesFromOffer in var51.discountSummaryEntriesFromOffers do
                table.insert(tbl2, {
                    Type = discountSummaryEntriesFromOffer.type,
                    AmountInRobux = discountSummaryEntriesFromOffer.amountInRobux,
                    Percent = discountSummaryEntriesFromOffer.percent,
                    LocalizedDiscountAttribution = discountSummaryEntriesFromOffer.localizedDiscountAttribution
                })
            end
        end

        var7(
            purchasePromptLite.Thunks.OpenCentralOverlayForUnifiedPurchasePrompt({
                productPayload = { kind = "RobuxUpsell" },
                purchaseCallbacks = {
                    onFlowComplete = function()
                        var7(CloseCentralOverlay())
                    end,
                    fetchProductInfo = function()
                        return Promise.resolve({
                            PriceInRobux = priceInRobux - var51.totalSelectedOffersDiscount,
                            IsForSale = true,
                            Name = "RobuxUpsell",
                            SavingsSummaryOverride = if var76 then var51.savingsSummary else nil,
                            BasePriceInRobux = if var76 then var14 else nil,
                            PriceDiscountDetails = if var76 then tbl2 else nil
                        })
                    end
                }
            })
        )
        var46.current = true
    end, {
        var4,
        var7,
        priceInRobux,
        var14,
        var11,
        var51
    }) else React.useCallback(function()
        var4.navigate(AvatarScreen.InsufficientRobuxPrompt)

        var46.current = true
    end, { var4 })

    local var77

    if FFlagAXMISWithBlackbird then
        local useMemo2 = React.useMemo
        local function func10()
            local var78 = nil
            if var11 then
                for _, value in var11 do
                    if value.discountCampaign == DiscountTypeEnum.RobloxPlusSubscription then
                        var78 = value
                        break
                    end
                end
            end

            if not FFlagAXMISWithOffers then
                if var78 and var14 and priceInRobux then
                    return {
                        itemPrice = {
                            basePriceInRobux = var14,
                            priceInRobux = priceInRobux,
                            discounts = {{
                                type = DiscountTypeEnum.RobloxPlusSubscription,
                                amountInRobux = var14 - priceInRobux,
                                percent = var78.robuxDiscountPercentage
                            }}
                        }
                    }
                end

                return nil
            end

            local discounts = table.clone(var51.discountSummaryEntriesFromOffers)

            if var78 then
                table.insert(discounts, 1, {
                    type = DiscountTypeEnum.RobloxPlusSubscription,
                    amountInRobux = var14 - priceInRobux,
                    percent = var78.robuxDiscountPercentage
                })
            end

            return {
                itemPrice = {
                    basePriceInRobux = var14,
                    priceInRobux = math.max(priceInRobux - var51.totalSelectedOffersDiscount, 0),
                    discounts = discounts
                },
                savingsSummary = var51.savingsSummary
            }
        end

        local discountSummaryEntriesFromOffers = if FFlagAXMISWithOffers then var51.discountSummaryEntriesFromOffers else nil
        local totalSelectedOffersDiscount = if FFlagAXMISWithOffers then var51.totalSelectedOffersDiscount else nil
        local savingsSummary = if FFlagAXMISWithOffers then var51.savingsSummary else nil
        var77 = useMemo2(
            func10,
            {
                var14,
                priceInRobux,
                var11,
                discountSummaryEntriesFromOffers,
                totalSelectedOffersDiscount,
                savingsSummary
            }
        )
    else
        var77 = nil
    end

    local useCallback6 = React.useCallback
    local function func10()
        var23(true)

        if FFlagAXMISEnableMultiShoppingUnifiedEvents and not pcall(function()
            local var78 = var36[var32]
            if var78 ~= nil then
                var78 = table.clone(var78)
                var78.itemId = var32
            end

            local var79 = var36[itemId]
            if var79 ~= nil then
                var79 = table.clone(var79)
                var79.itemId = itemId
            end

            if var78 then
                var78.isOrganicLook = var34 == nil
            end

            if var79 then
                var79.isOrganicLook = var35 == nil
            end

            local name = var5 and var5.current and var5.current.name
            local var80 = AvatarScreenProperties[name]
            local unifiedLoggingSurface = if var80 and var80.analyticsData then var80.analyticsData.unifiedLoggingSurface else nil

            if FFlagAXUnifiedEventStrictPayloads then
                local var81, var82 = getUnifiedEventsForMIS(
                    var9,
                    var28,
                    var78,
                    var79,
                    UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
                    unifiedLoggingSurface,
                    var34,
                    var35
                )
                sendUnifiedEventsForMultiItemShopping(var81, unifiedLoggingSurface, var82)
                return
            end
            sendUnifiedEventsForMultiItemShopping(
                getUnifiedEventsForMIS(var9, var28, var78, var79, UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT),
                unifiedLoggingSurface
            )
        end) then
            mutedError("Failed to send unified events for multi-item shopping purchase attempt")
        end

        local var78 = PurchaseItems
        local tbl2 = {
            networkImpl = networkImpl,
            userId = userId,
            lookId = var32,
            makeupLookId = if FFlagAXMISEnableMultiShoppingUnifiedEvents then itemId else nil,
            lineItems = var68()
        }

        var78(tbl2):andThen(function(arg1)
            if not arg1.isJSONValid or arg1.responseCode ~= 200 then
                return
            end

            local responseBody = arg1.responseBody
            local var79 = mapPurchaseItemsResponse(responseBody)
            var75(var79, tutils.deepCopy(var28))

            purchasePromptLite.Events.firePurchaseCompleted()

            if tbl1.fetchUserRobux then
                tbl1.fetchUserRobux()
            end
        end):catch(function(arg1)
            if getIsInsufficientRobuxError(arg1) then
                var76()
                return
            end
            var4.navigate(AvatarScreen.GenericPrompt, {
                titleText = if #var9 == 1 then var42.purchaseFailedTitle else var42.purchaseFailedTitlePlural,
                bodyText = var42.purchaseFailedUnknownError,
                buttonText = var42.purchaseFailedButton
            })
        end):finally(function()
            var23(false)
        end)
    end

    local fetchUserRobux = tbl1.fetchUserRobux
    local var78 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then itemId else nil
    local var79 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var36 else nil
    local var80 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var28 else nil
    local var81 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var34 else nil
    local var82 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var35 else nil
    local var83 = if FFlagAXMISEnableMultiShoppingUnifiedEvents then var5 else nil
    local var84 = useCallback6(func10, {
        var68,
        userId,
        networkImpl,
        var76,
        fetchUserRobux,
        var75,
        var9,
        var42,
        var4,
        var32,
        var78,
        var79,
        var80,
        var81,
        var82,
        var83,
        purchasePromptLite.Events.firePurchaseCompleted
    })

    local useCallback7 = React.useCallback
    local function func11()
        local var85 = if FFlagAXMISWithOffers then priceInRobux - var51.totalSelectedOffersDiscount else priceInRobux

        if var40 and var40 < var85 then
            var76()
            return
        end
        var84()
    end

    local totalSelectedOffersDiscount = if FFlagAXMISWithOffers then var51.totalSelectedOffersDiscount else nil
    local onCheckoutButtonActivated = useCallback7(func11, { var40, priceInRobux, var84, var76, totalSelectedOffersDiscount })

    local tbl2 = {
        canPurchase = canPurchase,
        cartItems = cartItems,
        discounts = if FFlagAXMISWithBlackbird then var11 else nil,
        erroredItemCount = erroredItemCount,
        isPurchasing = isPurchasing,
        isVisible = isVisible,
        hideBuyOptions = 0,
        shouldShowBlackbirdUpsellBanner = 0,
        isWearAfterPurchaseChecked = 0,
        isAddToMyAvatarsChecked = 0,
        isSaveOptionsOpen = 0,
        onCheckoutButtonActivated = 0,
        onOpenItemDetailsPage = 0,
        onRemoveItem = 0,
        onUnavailableButtonActivated = 0,
        onWearAfterPurchaseToggle = 0,
        onAddToMyAvatarsToggle = 0,
        onSaveOptionsOpenToggle = 0,
        purchasableItemsTotalPriceInRobux = 0,
        purchasableItemsTotalOriginalPriceInRobux = 0,
        robloxSubscriptionProducts = 0,
        discountSummaryProps = 0,
        offersAvailable = 0,
        handleDeselectOfferId = 0
    }

    if not FFlagAXEnableExpiredUserLookCheckout then
        var57 = nil
    end

    tbl2.hideBuyOptions = var57
    if not FFlagAXMISWithBlackbird then
        var58 = nil
    end

    tbl2.shouldShowBlackbirdUpsellBanner = var58
    tbl2.isWearAfterPurchaseChecked = isWearAfterPurchaseChecked
    tbl2.isAddToMyAvatarsChecked = isAddToMyAvatarsChecked
    tbl2.isSaveOptionsOpen = var16
    tbl2.onCheckoutButtonActivated = onCheckoutButtonActivated
    tbl2.onOpenItemDetailsPage = var12
    tbl2.onRemoveItem = var6
    tbl2.onUnavailableButtonActivated = onUnavailableButtonActivated
    tbl2.onWearAfterPurchaseToggle = onWearAfterPurchaseToggle
    tbl2.onAddToMyAvatarsToggle = onAddToMyAvatarsToggle
    tbl2.onSaveOptionsOpenToggle = onSaveOptionsOpenToggle
    local var86 = if FFlagAXMISWithOffers then math.max(priceInRobux - var51.totalSelectedOffersDiscount, 0) else priceInRobux
    tbl2.purchasableItemsTotalPriceInRobux = var86

    tbl2.purchasableItemsTotalOriginalPriceInRobux = var14
    if not FFlagAXMISWithBlackbird then
        var24 = nil
    end

    tbl2.robloxSubscriptionProducts = var24
    if not FFlagAXMISWithBlackbird then
        var77 = nil
    end

    tbl2.discountSummaryProps = var77
    tbl2.offersAvailable = if FFlagAXMISWithOffers then var51.offersAvailable else nil
    tbl2.handleDeselectOfferId = if FFlagAXMISWithOffers then var51.handleDeselectOfferId else nil
    return tbl2
end

return useCheckoutPageViewModel
