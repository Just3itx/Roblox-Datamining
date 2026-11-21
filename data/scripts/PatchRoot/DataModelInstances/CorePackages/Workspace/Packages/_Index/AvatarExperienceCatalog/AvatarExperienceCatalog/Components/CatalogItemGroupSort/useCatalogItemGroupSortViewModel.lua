-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)

local useTokens = require(AvatarExperienceCatalogParent.Foundation).Hooks.useTokens

local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum

local UnifiedEventLogEnums = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).UnifiedEventLogEnums

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXCatalogItemInformationPopover = AvatarExperienceFlags.FFlagAXCatalogItemInformationPopover
local FFlagAXDeferLookImpressionsForHydration = AvatarExperienceFlags.FFlagAXDeferLookImpressionsForHydration
local FFlagAXSduiSortSessionImpressionDedup = AvatarExperienceFlags.FFlagAXSduiSortSessionImpressionDedup
local FFlagAXSduiSeeAllClickLogging = AvatarExperienceFlags.FFlagAXSduiSeeAllClickLogging
local FFlagAXSduiSponsoredItemClickTracking = AvatarExperienceFlags.FFlagAXSduiSponsoredItemClickTracking

local useStore = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useStore

local WidgetConstants = require(AvatarExperienceCatalog.WidgetConstants)
local getFooterVisibilityFromItemFooters = require(AvatarExperienceCatalog.Utils.getFooterVisibilityFromItemFooters)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local selectHydratedLookType = require(AvatarExperienceCatalog.State.Selectors.selectHydratedLookType)

local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)
local useOnRequestImpressionsSignal = require(script.Parent.Parent.Hooks.useOnRequestImpressionsSignal)
local useHydrateCatalogSortOnDemandEffect = require(script.Parent.Parent.Hooks.useHydrateCatalogSortOnDemandEffect)

local useAddUnifiedLoggingToCatalogSortEffect = require(script.Parent.Parent.Hooks.useAddUnifiedLoggingToCatalogSortEffect)
local useFirstSeenImpressionFilter = require(script.Parent.Parent.Hooks.useFirstSeenImpressionFilter)
local useSessionSeenImpressionFilter = require(script.Parent.Parent.Hooks.useSessionSeenImpressionFilter)
local useDeferLooksWithoutHydrationFilter = require(script.Parent.Parent.Hooks.useDeferLooksWithoutHydrationFilter)
local useComposedImpressionFilter = require(script.Parent.Parent.Hooks.useComposedImpressionFilter)

local useOnCatalogSortImpressionsDetectedCallback = require(script.Parent.Parent.Hooks.useOnCatalogSortImpressionsDetectedCallback)
local useOpenInformationPopover = require(script.Parent.Parent.Hooks.useOpenInformationPopover)
local useCatalogSortSeeAllLogging = require(script.Parent.Parent.Hooks.useCatalogSortSeeAllLogging)

local _CatalogItemGroupSortView = require(script.Parent.CatalogItemGroupSortView)

local function computeItemWidth(rowWidth: number, itemsPerRow: number, medium: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = if itemsPerRow > 0 then itemsPerRow else 1
    return math.floor(math.max(0, rowWidth - (num1 - 1) * medium) / num1)
end

local function useCatalogItemGroupSortViewModel(tbl1)
    local widgetTileWithImpressionsTagging = useCatalogPageMonolithDependencies().WidgetTileWithImpressionsTagging

    local var1 = useTokens()

    local widgetInfo = tbl1.widgetInfo
    local widgetConfiguration = tbl1.widgetConfiguration
    local itemsPerRow = tbl1.itemsPerRow
    local rowCount = tbl1.rowCount or 1

    local containerRef = React.useRef(nil)
    local onItemsUpdatedSignal = useOnRequestImpressionsSignal()
    local var4, onSeeAll

    if FFlagAXSduiSeeAllClickLogging then
        var4, onSeeAll = useCatalogSortSeeAllLogging(tbl1.onSeeAll, tbl1.widgetAnalyticsInfo)
    else
        var4 = nil
        onSeeAll = nil
    end

    local id = widgetInfo and widgetInfo.id or ""
    local var5 = "WIDGET_ITEM_GROUP" .. "_" .. id

    local var6 = useFirstSeenImpressionFilter(id)

    if FFlagAXSduiSortSessionImpressionDedup then
        var6 = useSessionSeenImpressionFilter(id)
    end

    local var7 = useDeferLooksWithoutHydrationFilter(widgetInfo)
    local var8 = useComposedImpressionFilter({ var7, var6 })

    if FFlagAXDeferLookImpressionsForHydration then
        var6 = var8
    end

    local refCache = React.useMemo(function()
        return (setmetatable({}, {
            __index = function<T, U>(tbl2: {[T]: U}, arg1: T): U
                local ref = React.createRef()
                rawset(tbl2, arg1, ref)
                return ref
            end
        }))
    end, {})

    local var10 = useStore()

    local medium = var1.Gap.Medium
    local xOffset = computeItemWidth(tbl1.rowWidth or 0, itemsPerRow, medium)

    useHydrateCatalogSortOnDemandEffect(widgetInfo, widgetConfiguration, itemsPerRow)

    local var11 = useLocalization({
        widgetTitle = if widgetInfo and widgetInfo.template then widgetInfo.template.title else nil,
        widgetDescription = if widgetInfo and widgetInfo.template then widgetInfo.template.description else nil
    })

    local informationPopoverText = nil
    local var12, var13

    if widgetInfo and widgetInfo.template then
        if widgetInfo.template.title then
            var12 = var11.widgetTitle
        else
            var12 = widgetInfo.template.localizedTitle
        end

        if widgetInfo.template.description then
            var13 = var11.widgetDescription
        else
            var13 = widgetInfo.template.localizedDescription
        end

        if FFlagAXCatalogItemInformationPopover then
            informationPopoverText = widgetInfo.template.informationPopoverText
        end
    else
        var12 = nil
        var13 = nil
    end

    local onInformationIconActivated = if FFlagAXCatalogItemInformationPopover then useOpenInformationPopover(var12, informationPopoverText) else nil
    local itemFooters = if widgetInfo and widgetInfo.template then widgetInfo.template.itemFooters else nil
    local footerVisibilityFromItemFooters = getFooterVisibilityFromItemFooters(itemFooters)

    local itemGroup = UnifiedEventLogEnums.WidgetUiTreatment.ITEM_GROUP

    useAddUnifiedLoggingToCatalogSortEffect({
        containerRef = containerRef,
        widgetInfo = widgetInfo,
        widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo,
        widgetRow = tbl1.widgetRow,
        uiTreatmentType = itemGroup,
        seeAllRef = if FFlagAXSduiSeeAllClickLogging then var4 else nil,
        seeAllCallback = if FFlagAXSduiSeeAllClickLogging then tbl1.onSeeAll else nil
    })

    local function buildPerTileAnalyticsInfo(arg1, index: number)
        local lookType = if FFlagAXDeferLookImpressionsForHydration or arg1.type ~= ItemTypeEnum.Look then nil else selectHydratedLookType(var10:getState(), arg1.id)
        return Cryo.Dictionary.join(tbl1.widgetAnalyticsInfo, {
            itemPosition = index,
            itemId = arg1.id,
            itemType = arg1.type,
            lookType = lookType,
            themeId = widgetInfo and widgetInfo.tagId,
            gridPositionRow = tbl1.widgetRow,
            gridPositionColumn = index,
            uiTreatmentType = itemGroup
        })
    end

    local adTrackingDataByItemId = tbl1.adTrackingDataByItemId

    local function renderTile(arg1, index: number)
        local widgetAnalyticsInfo = buildPerTileAnalyticsInfo(arg1, index)

        return React.createElement(widgetTileWithImpressionsTagging, {
            size = UDim2.new(0, xOffset, 0, 0),
            cardStyle = if widgetInfo and widgetInfo.template then widgetInfo.template.cardStyle else nil,
            contentType = arg1.type or WidgetConstants.ContentType.Asset,
            tileContentType = widgetInfo and widgetInfo.type,
            contentId = arg1.id or "",
            index = index,
            refCache = refCache,
            resultsListRef = tbl1.gridRef,
            itemDetailsPeekViewRefs = tbl1.itemDetailsPeekViewRefs,
            itemsPerRow = itemsPerRow,
            analyticsItemCountPerPage = itemsPerRow,
            isCreatorNameVisible = footerVisibilityFromItemFooters.isCreatorNameVisible,
            isTitleVisible = footerVisibilityFromItemFooters.isTitleVisible,
            isPriceVisible = footerVisibilityFromItemFooters.isPriceVisible,
            impressionsTag = var5,
            widgetAnalyticsInfo = widgetAnalyticsInfo,
            onThumbnailLoaded = tbl1.onThumbnailLoaded,
            adTrackingData = if FFlagAXSduiSponsoredItemClickTracking and adTrackingDataByItemId and arg1.id then adTrackingDataByItemId[arg1.id] else nil
        })
    end

    local content = if widgetInfo then widgetInfo.content else nil

    local gridItems = React.useMemo(function()
        return Cryo.List.getRange(content or {}, 1, rowCount * itemsPerRow)
    end, { content, rowCount, itemsPerRow })

    local onImpressionsDetected = useOnCatalogSortImpressionsDetectedCallback({
        widgetInfo = widgetInfo,
        widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo,
        widgetRow = tbl1.widgetRow,
        itemsPerRow = itemsPerRow,
        uiTreatmentType = itemGroup
    })

    local tbl2 = {
        headerText = var12,
        headerDescription = var13,
        informationPopoverText = informationPopoverText,
        onInformationIconActivated = onInformationIconActivated,
        seeAllCallback = 0,
        seeAllRef = 0,
        itemsPerRow = 0,
        itemGap = 0,
        gridItems = 0,
        renderTile = 0,
        containerRef = 0,
        impressionsKey = 0,
        widgetRow = 0,
        onItemsUpdatedSignal = 0,
        onImpressionsDetected = 0,
        filterImpressionFunc = 0,
        horizontalMargin = 0,
        widgetId = 0
    }

    if not FFlagAXSduiSeeAllClickLogging then
        onSeeAll = tbl1.onSeeAll
    end

    tbl2.seeAllCallback = onSeeAll
    if not FFlagAXSduiSeeAllClickLogging then
        var4 = nil
    end

    tbl2.seeAllRef = var4
    tbl2.itemsPerRow = itemsPerRow
    tbl2.itemGap = medium
    tbl2.gridItems = gridItems
    tbl2.renderTile = renderTile
    tbl2.containerRef = containerRef
    tbl2.impressionsKey = var5
    tbl2.widgetRow = tbl1.widgetRow
    tbl2.onItemsUpdatedSignal = onItemsUpdatedSignal
    tbl2.onImpressionsDetected = onImpressionsDetected
    tbl2.filterImpressionFunc = var6
    tbl2.horizontalMargin = tbl1.horizontalMargin
    tbl2.widgetId = id
    return tbl2
end

return useCatalogItemGroupSortViewModel
