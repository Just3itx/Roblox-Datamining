-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent

local AnalyticsService = require(script.AnalyticsService)
local AvatarExperienceAnalyticsService = require(script.AvatarExperienceAnalyticsService)
local AXUnifiedEventFilter = require(script.AXUnifiedEventFilter)
local addUnifiedEventLogging = require(script.addUnifiedEventLogging)
local useUnifiedEventListener = require(script.useUnifiedEventListener)
local sendUnifiedEventLog = require(script.sendUnifiedEventLog)
local sendUnifiedEventLogForInstance = require(script.sendUnifiedEventLogForInstance)
local sendPassthroughUnifiedEventLog = require(script.sendPassthroughUnifiedEventLog)
local logWidgetLoaded = require(script.logWidgetLoaded)
local flushDeferredWidgetLoaded = require(script.flushDeferredWidgetLoaded)
local sendUnifiedEventForDeferredAction = require(script.sendUnifiedEventForDeferredAction)
local normalizeDiscoveryPurchaseEntity = require(script.normalizeDiscoveryPurchaseEntity)
local buildDiscoveryPurchaseAttempt = require(script.buildDiscoveryPurchaseAttempt)
local sendUnifiedClickItemDetailsEvent = require(script.sendUnifiedClickItemDetailsEvent)
local sendUnifiedEventsForMultiItemShopping = require(script.sendUnifiedEventsForMultiItemShopping)
local UnifiedEventLogConstants = require(script.UnifiedEventLogConstants)
local UnifiedEventLogEnums = require(script.UnifiedEventLogEnums)
local _UnifiedEventTypes = require(script.Generated.UnifiedEventTypes)
local TagBasedImpressionsDetector = require(script.TagBasedImpressionsDetector)

return {
    AnalyticsService = AnalyticsService,
    AvatarExperienceAnalyticsService = AvatarExperienceAnalyticsService,
    AXUnifiedEventFilter = AXUnifiedEventFilter,
    addUnifiedEventLogging = addUnifiedEventLogging,
    useUnifiedEventListener = useUnifiedEventListener,
    sendUnifiedEventLog = sendUnifiedEventLog,
    sendUnifiedEventLogForInstance = sendUnifiedEventLogForInstance,
    sendPassthroughUnifiedEventLog = sendPassthroughUnifiedEventLog.send,
    sendPassthroughUnifiedEventLogForInstance = sendPassthroughUnifiedEventLog.sendForInstance,
    logWidgetLoaded = logWidgetLoaded,
    flushDeferredWidgetLoaded = flushDeferredWidgetLoaded,
    sendUnifiedEventForDeferredAction = sendUnifiedEventForDeferredAction,
    normalizeDiscoveryPurchaseEntity = normalizeDiscoveryPurchaseEntity,
    buildDiscoveryPurchaseAttempt = buildDiscoveryPurchaseAttempt,
    sendUnifiedClickItemDetailsEvent = sendUnifiedClickItemDetailsEvent,
    sendUnifiedEventsForMultiItemShopping = sendUnifiedEventsForMultiItemShopping,
    UnifiedEventLogConstants = UnifiedEventLogConstants,
    UnifiedEventLogEnums = UnifiedEventLogEnums,
    useUnifiedEventImpressionsReporter = require(script.useUnifiedEventImpressionsReporter),
    useRequestImpressionsOnTagAdded = require(script.useRequestImpressionsOnTagAdded),
    useUnifiedEventTagging = require(script.useUnifiedEventTagging),
    TagBasedImpressionsDetector = TagBasedImpressionsDetector,
    AvatarExperienceImpressionsDetector = require(script.AvatarExperienceImpressionsDetector),
    AvatarExperienceScreenSizeImpressionsDetector = require(script.AvatarExperienceScreenSizeImpressionsDetector),
    sendAXStat = require(script.sendAXStat),
    sendAXCounterV2 = require(script.sendAXCounterV2),
    UnifiedEventCounterAggregator = require(script.Lib.UnifiedEventCounterAggregator),
    getAvatarEventCounterNameWithPlatform = require(script.getAvatarEventCounterNameWithPlatform),
    reportAvatarEventCounterNoAnalyticsArgument = require(script.reportAvatarEventCounterNoAnalyticsArgument),
    reportAvatarEventCounterV1 = require(script.reportAvatarEventCounterV1),
    reportAvatarEditorServiceCounter = require(script.reportAvatarEditorServiceCounter),
    Flags = {
        FFlagAllowCustomUnifiedEventFilter = require(script.FFlagAllowCustomUnifiedEventFilter),
        FFlagAXAvatarEditorServiceTelemetryV2 = require(scriptParent.AvatarExperienceFlags).FFlagAXAvatarEditorServiceTelemetryV2,
        FFlagAXDeprecateAvatarEditorServiceTelemetryV1 = require(scriptParent.AvatarExperienceFlags).FFlagAXDeprecateAvatarEditorServiceTelemetryV1,
        FFlagAXUnifiedEventCounters = require(scriptParent.AvatarExperienceFlags).FFlagAXUnifiedEventCounters,
        FFlagAXUnifiedEventStrictPayloads = require(scriptParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads
    },
    reportBackgroundUserActionCounter = require(script.reportBackgroundUserActionCounter),
    Enums = {
        ImpressionEnums = require(script.Enums.ImpressionEnums),
        UnifiedLoggingElementNameEnums = require(script.Enums.UnifiedLoggingElementNameEnums),
        UnifiedLoggingSectionEnums = require(script.Enums.UnifiedLoggingSectionEnums)
    },
    Lib = {
        CartIdService = require(script.Lib.CartIdService)
    },
    Store = {
        SeenImpressionsStore = require(script.Store.SeenImpressionsStore),
        UnifiedEventPageStore = require(script.Store.UnifiedEventPageStore),
        UnifiedSelectionListStore = require(script.Store.UnifiedSelectionListStore)
    },
    Surfaces = {
        SlotBasedEditorAnalytics = require(script.Surfaces.SlotBasedEditorAnalytics),
        SupportRegionAvatarOverlayAnalytics = require(script.Surfaces.SupportRegionAvatarOverlayAnalytics)
    },
    Utils = {
        UnifiedEventLoggingUtils = require(script.Utils.UnifiedEventLoggingUtils),
        aliasSortAndFiltersToLegacyKeys = require(script.Utils.aliasSortAndFiltersToLegacyKeys),
        getMarketplaceUnifiedItemType = require(script.Utils.getMarketplaceUnifiedItemType),
        getMarketplaceUnifiedAssetType = require(script.Utils.getMarketplaceUnifiedAssetType),
        getMarketplaceUnifiedBundleType = require(script.Utils.getMarketplaceUnifiedBundleType),
        getMarketplaceUnifiedLookType = require(script.Utils.getMarketplaceUnifiedLookType),
        getWidgetAttributionFields = require(script.Utils.getWidgetAttributionFields),
        getTimedOptionForItemData = require(script.Utils.getTimedOptionForItemData),
        getUnifiedEventsForMIS = require(script.Utils.getUnifiedEventsForMIS),
        getUnifiedLoggingSurface = require(script.Utils.getUnifiedLoggingSurface),
        getUnifiedLoggingSurfaceForAppPage = require(script.Utils.getUnifiedLoggingSurfaceForAppPage),
        getUnifiedLoggingSurfaceForRoute = require(script.Utils.getUnifiedLoggingSurfaceForRoute),
        mapAnalyticsMetadataFields = require(script.Utils.mapAnalyticsMetadataFields),
        mapMarketplaceSurfaceToUnifiedLoggingSurface = require(script.Utils.mapMarketplaceSurfaceToUnifiedLoggingSurface),
        getItemSelectionAction = require(script.Utils.getItemSelectionAction),
        getCatalogItemUnifiedLoggingFields = require(script.Utils.getCatalogItemUnifiedLoggingFields)
    },
    Constants = require(script.Constants),
    ImpressionsReporter = {
        ImpressionsUtil = require(script.ImpressionsReporter.ImpressionsUtil),
        OrganicEventImpressionsSchema = require(script.ImpressionsReporter.OrganicEventImpressionsSchema)
    },
    Events = {
        BulkPurchaseMissingPurchaseOptionsCounter = require(script.Events.BulkPurchaseMissingPurchaseOptionsCounter)
    },
    ["jest.config"] = script["jest.config"]
}
