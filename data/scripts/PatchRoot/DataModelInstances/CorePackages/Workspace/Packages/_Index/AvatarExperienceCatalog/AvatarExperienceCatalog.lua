-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getWidgetListInfo = require(script.Api.GetWidgetListInfo.getWidgetListInfo)
local getWidgetListInfoSearch = require(script.Api.GetWidgetListInfo.getWidgetListInfoSearch)
local getLooksFromWidgetListInfo = require(script.Api.GetWidgetListInfo.getLooksFromWidgetListInfo)
local getCatalogV2SearchItemDetails = require(script.Api.GetCatalogV2SearchItemDetails.getCatalogV2SearchItemDetails)
local CatalogSearchAXPages = require(script.Api.GetCatalogV2SearchItemDetails.Types.CatalogSearchAXPages)
local _AXPagesTypes = require(script.Api.GetCatalogV2SearchItemDetails.Types.AXPagesTypes)
local trackSponsoredItemClick = require(script.Api.TrackSponsoredItemClick.trackSponsoredItemClick)
local _WidgetListInfo = require(script.Models.WidgetListInfo)
local _CatalogV2SearchItemDetails = require(script.Models.CatalogV2SearchItemDetails)
local _WidgetListInfoViewModel = require(script.Components.ResultsList.WidgetListInfoViewModel)
local useWidgetListInfoViewModel = require(script.Components.ResultsList.useWidgetListInfoViewModel)
local WidgetListBreakPointEnum = require(script.Components.ResultsList.WidgetListBreakPointEnum)
local WidgetListBreakPointThresholds = require(script.Components.ResultsList.WidgetListBreakPointThresholds)
local WidgetListBreakPointSizeMap = require(script.Components.ResultsList.WidgetListBreakPointSizeMap)
local WidgetIxpLayerMap = require(script.Utils.WidgetIxpLayerMap)
local getFooterVisibilityFromItemFooters = require(script.Utils.getFooterVisibilityFromItemFooters)
local PurchaseItemsSuccess = require(script.State.Actions.PurchaseItemsSuccess)
local FetchAssetOrBundleInfoBatchedSuccess = require(script.State.Actions.FetchAssetOrBundleInfoBatchedSuccess)
local FetchCollectibleItemDataBatchedSuccess = require(script.State.Actions.FetchCollectibleItemDataBatchedSuccess)
local SetSelectedTimedOption = require(script.State.Actions.SetSelectedTimedOption)
local getCatalogCategories = require(script.Api.GetCatalogCategories.getCatalogCategories)
local getFaeStatus = require(script.Api.GetFaeStatus.getFaeStatus).getFaeStatus
local _normalizeFaeStatus = require(script.Api.GetFaeStatus.normalizeFaeStatus)
local SaveAsMakeupLookThunk = require(script.State.Thunks.SaveAsMakeupLookThunk)

local FFlagAXCatalogSpecialFeaturesFilter = require(script.Parent.AvatarExperienceFlags).FFlagAXCatalogSpecialFeaturesFilter
local addSpecialFeaturesFilter = require(script.Api.GetCatalogV2SearchItemDetails.addSpecialFeaturesFilter)

local GetAXMarketplaceWidgetStore = require(script.Stores.GetAXMarketplaceWidgetStore)
local GetAvatarsTabSearchInfoStore = require(script.Stores.GetAvatarsTabSearchInfoStore)
local GetCatalogPageRequestIdStore = require(script.Stores.GetCatalogPageRequestIdStore)
local GetFaeFeatureAccessStore = require(script.Stores.GetFaeFeatureAccessStore)
local WidgetConstants = require(script.WidgetConstants)

local _Stores = require(script.Stores)

local tbl1 = {}
local Api = {
    getWidgetListInfo = getWidgetListInfo,
    getWidgetListInfoSearch = getWidgetListInfoSearch,
    getLooksFromWidgetListInfo = getLooksFromWidgetListInfo,
    getCatalogV2SearchItemDetails = getCatalogV2SearchItemDetails.getCatalogV2SearchItemDetails,
    CatalogSearchAXPages = CatalogSearchAXPages,
    getCatalogCategories = getCatalogCategories.getCatalogCategories,
    getFaeStatus = getFaeStatus,
    trackSponsoredItemClick = trackSponsoredItemClick,
    addSpecialFeaturesFilter = 0
}

if not FFlagAXCatalogSpecialFeaturesFilter then
    addSpecialFeaturesFilter = nil
end

Api.addSpecialFeaturesFilter = addSpecialFeaturesFilter
tbl1.Api = Api

tbl1.Components = {
    CatalogSduiFeedEntryPoint = require(script.Sdui.CatalogSduiFeedEntryPoint),
    CatalogSduiCategoryMenuEntryPoint = require(script.Sdui.CatalogSduiCategoryMenuEntryPoint),
    MarketplaceFeedSkeleton = require(script.Components.MarketplaceFeedSkeleton.MarketplaceFeedSkeleton),
    MarketplaceCategoryMenuSkeleton = require(script.Components.MarketplaceCategoryMenuSkeleton.MarketplaceCategoryMenuSkeleton),
    CatalogOffersBanner = require(script.Components.CatalogOffersBanner.CatalogOffersBanner),
    CatalogItemGroupSort = {
        CatalogItemGroupSortContainer = require(script.Components.CatalogItemGroupSort.CatalogItemGroupSortContainer),
        CatalogItemGroupSortView = require(script.Components.CatalogItemGroupSort.CatalogItemGroupSortView),
        useCatalogItemGroupSortViewModel = require(script.Components.CatalogItemGroupSort.useCatalogItemGroupSortViewModel)
    },
    CatalogItemCarouselSort = {
        CatalogItemCarouselSortContainer = require(script.Components.CatalogItemCarouselSort.CatalogItemCarouselSortContainer),
        CatalogItemCarouselSortView = require(script.Components.CatalogItemCarouselSort.CatalogItemCarouselSortView),
        useCatalogItemCarouselSortViewModel = require(script.Components.CatalogItemCarouselSort.useCatalogItemCarouselSortViewModel)
    },
    Checkout = {
        CheckoutPage = require(script.Components.Checkout.CheckoutPage),
        CheckoutPageContainer = require(script.Components.Checkout.CheckoutPageContainer),
        CheckoutActionBarContainer = require(script.Components.Checkout.CheckoutActionBarContainer),
        OwnedActionBar = require(script.Components.Checkout.OwnedActionBar)
    },
    ResultsList = {
        useWidgetListInfoViewModel = useWidgetListInfoViewModel,
        WidgetListBreakPointEnum = WidgetListBreakPointEnum,
        WidgetListBreakPointThresholds = WidgetListBreakPointThresholds,
        WidgetListBreakPointSizeMap = WidgetListBreakPointSizeMap,
        getOrderedWidgets = require(script.Components.ResultsList.getOrderedWidgets)
    },
    WidgetPanelContainer = require(script.Components.WidgetPanel.WidgetPanelContainer),
    Prompts = {
        ClearAllItemsOnAvatarPrompt = require(script.Components.Prompts.ClearAllItemsOnAvatarPrompt),
        WearAvatarReplaceAllItemsPrompt = require(script.Components.Prompts.WearAvatarReplaceAllItemsPrompt),
        CartUnavailableItemsPrompt = require(script.Components.Prompts.CartUnavailableItemsPrompt),
        GoToCustomizeToEditPrompt = require(script.Components.Prompts.GoToCustomizeToEditPrompt),
        ItemReplacedOnAvatarPrompt = require(script.Components.Prompts.ItemReplacedOnAvatarPrompt),
        ItemsUnavailablePrompt = require(script.Components.Prompts.ItemsUnavailablePrompt),
        TimeoutStatusPrompt = require(script.Components.Prompts.TimeoutStatusPrompt)
    }
}
tbl1.Constants = require(script.Constants)
tbl1.WidgetConstants = WidgetConstants
tbl1.Hooks = {
    useMultiItemShoppingFtux = require(script.Hooks.useMultiItemShoppingFtux),
    useTimedOptionsFtux = require(script.Hooks.useTimedOptionsFtux),
    useCatalogPageTimeoutPrompt = require(script.Hooks.useCatalogPageTimeoutPrompt),
    useMakeupFtux = require(script.Hooks.useMakeupFtux),
    useMakeupLayeringTooltip = require(script.Hooks.useMakeupLayeringTooltip),
    useCatalogPageMakeupReleaseFtux = require(script.Hooks.useCatalogPageMakeupReleaseFtux),
    useWidgetItemImpressions = require(script.Hooks.useWidgetItemImpressions),
    useWidgetItemPayload = require(script.Hooks.useWidgetItemPayload),
    useAddUnifiedLoggingToCatalogSortEffect = require(script.Components.Hooks.useAddUnifiedLoggingToCatalogSortEffect),
    useHydrateCatalogSortOnDemandEffect = require(script.Components.Hooks.useHydrateCatalogSortOnDemandEffect),
    useHydrateCatalogItemGridOnDemandEffect = require(script.Components.Hooks.useHydrateCatalogItemGridOnDemandEffect),
    useShouldFetchCartPricingForPurchasePrompt = require(script.Hooks.useShouldFetchCartPricingForPurchasePrompt),
    useShouldFetchCartPricingForLookPurchasePrompt = require(script.Hooks.useShouldFetchCartPricingForLookPurchasePrompt),
    useOnRequestImpressionsSignal = require(script.Components.Hooks.useOnRequestImpressionsSignal)
}
tbl1.Utils = {
    WidgetIxpLayerMap = WidgetIxpLayerMap,
    getFooterVisibilityFromItemFooters = getFooterVisibilityFromItemFooters,
    resolveWidgetListItemBottomPaddingPx = require(script.Utils.resolveWidgetListItemBottomPaddingPx),
    getBreakpointFromRowWidth = require(script.Utils.getBreakpointFromRowWidth),
    getUIScaleFromTokens = require(script.Utils.getUIScaleFromTokens),
    getShouldPageUseWidgetOnlyFetcher = require(script.Utils.getShouldPageUseWidgetOnlyFetcher),
    logEditorTaxonomyExposureIfApplicable = require(script.Utils.logEditorTaxonomyExposureIfApplicable),
    TryOns = {
        getEquippableAssetsFromTryOnItems = require(script.Utils.TryOns.getEquippableAssetsFromTryOnItems),
        getDoesBundleHaveClothingOrAccessories = require(script.Utils.TryOns.getDoesBundleHaveClothingOrAccessories),
        getTryOnItemsContainsOnlyMakeupTypes = require(script.Utils.TryOns.getTryOnItemsContainsOnlyMakeupTypes)
    }
}
tbl1.Context = {
    AXCatalogStoreContext = require(script.Context.AXCatalogStoreContext),
    useAXCatalogStoreContext = require(script.Context.useAXCatalogStoreContext)
}
tbl1.Providers = {
    CatalogPageMonolithDependenciesContext = require(script.Providers.CatalogPageMonolithDependenciesContext)
}
tbl1.Stores = {
    getCatalogStores = require(script.Stores),
    getAXMarketplaceWidgetStore = GetAXMarketplaceWidgetStore,
    getAvatarsTabSearchInfoStore = GetAvatarsTabSearchInfoStore,
    getCatalogPageRequestIdStore = GetCatalogPageRequestIdStore,
    GetFaeFeatureAccessStore = GetFaeFeatureAccessStore
}
tbl1.State = {
    Actions = {
        PurchaseItemsSuccess = PurchaseItemsSuccess,
        FetchAssetOrBundleInfoBatchedSuccess = FetchAssetOrBundleInfoBatchedSuccess,
        FetchCollectibleItemDataBatchedSuccess = FetchCollectibleItemDataBatchedSuccess,
        SetSelectedTimedOption = SetSelectedTimedOption
    },
    Selectors = {
        selectHydratedWidgetData = require(script.State.Selectors.selectHydratedWidgetData)
    }
}
tbl1.Sdui = {
    fetchCatalogPage = require(script.Sdui.fetchCatalogPage),
    CatalogSduiPageContext = require(script.Sdui.CatalogSduiPageContext),
    getCatalogConfigKey = require(script.Sdui.Utils.getCatalogConfigKey),
    getCatalogPageIdentifier = require(script.Sdui.Utils.getCatalogPageIdentifier),
    buildOrderedWidgetsFromCatalogPage = require(script.Sdui.buildOrderedWidgetsFromCatalogPage),
    getCatalogPageThumbnailPrefetchItems = require(script.Sdui.getCatalogPageThumbnailPrefetchItems),
    hydrateCatalogSortEntities = require(script.Sdui.hydrateCatalogSortEntities),
    hydrateCatalogSortById = require(script.Sdui.hydrateCatalogSortById),
    buildFocusedSortWidgetInfo = require(script.Sdui.buildFocusedSortWidgetInfo),
    resolveSduiFocusedSortContext = require(script.Sdui.resolveSduiFocusedSortContext),
    useApplySduiFocusedSort = require(script.Sdui.useApplySduiFocusedSort),
    useClearSduiFocusedSort = require(script.Sdui.useClearSduiFocusedSort),
    useCatalogSduiPageRequestId = require(script.Sdui.Hooks.useCatalogSduiPageRequestId),
    createMapMarketplaceCategoryToCatalogCategory = require(script.Sdui.createMapMarketplaceCategoryToCatalogCategory)
}

tbl1.Thunks = { SaveAsMakeupLookThunk = SaveAsMakeupLookThunk }

tbl1["jest.config"] = script["jest.config"]
return tbl1
