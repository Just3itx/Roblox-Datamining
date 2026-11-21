-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:40Z
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

local _CatalogItemCarouselSortView = require(script.Parent.CatalogItemCarouselSortView)

local num1 = game:DefineFastInt("AXCarouselLoadingBuffer", 1)
local num2 = game:DefineFastInt("AXCarouselPeakFraction", 33)
local num3 = game:DefineFastInt("AXCarouselItemsBasedOnFrameSize", 3)

local carouselArrowStyleProps = { leftPosition = 28, rightPosition = 15 }

local function computeItemWidth(rowWidth: number, num4: number, medium: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num5 = if num4 > 0 then num4 else 1
    return math.floor(math.max(0, rowWidth - (num5 - 1) * medium) / num5)
end

local function useCatalogItemCarouselSortViewModel(tbl2, ref)
    local widgetTileWithImpressionsTagging = useCatalogPageMonolithDependencies().WidgetTileWithImpressionsTagging

    local var1 = useTokens()

    local widgetInfo = tbl2.widgetInfo
    local widgetConfiguration = tbl2.widgetConfiguration
    local itemsPerRow = tbl2.itemsPerRow

    local containerRef = React.useRef(nil)
    local onItemsUpdatedSignal = useOnRequestImpressionsSignal()
    local var4, onSeeAll

    if FFlagAXSduiSeeAllClickLogging then
        var4, onSeeAll = useCatalogSortSeeAllLogging(tbl2.onSeeAll, tbl2.widgetAnalyticsInfo)
    else
        var4 = nil
        onSeeAll = nil
    end

    local id = widgetInfo and widgetInfo.id or ""
    local var5 = "WIDGET_CAROUSEL" .. "_" .. id

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
            __index = function<T, U>(tbl3: {[T]: U}, arg1: T): U
                local ref2 = React.createRef()
                rawset(tbl3, arg1, ref2)
                return ref2
            end
        }))
    end, {})

    local var10 = useStore()

    local num4 = math.min(widgetInfo and widgetInfo.content and #widgetInfo.content or 0, itemsPerRow * num3 - num3 + 1)

    local medium = var1.Gap.Medium
    local itemWidth = computeItemWidth(tbl2.rowWidth or 0, itemsPerRow + num2 / 100, medium)
    local canvasWidth = num4 * itemWidth + math.max(0, num4 - 1) * medium

    local var12, var13 = React.useState({ cardWindowStart = 1, cardWindowIndex = 1 })

    useHydrateCatalogSortOnDemandEffect(widgetInfo, widgetConfiguration, itemsPerRow)

    local onScrollChanged = React.useCallback(function(arg1)
        if not arg1 then
            return
        end
        local canvasPositionX = arg1.CanvasPosition.X
        local num5 = math.max(1, itemWidth + medium)
        local cardWindowStart = math.max(1, math.floor(canvasPositionX / num5))
        local cardWindowIndex = math.max(0, math.floor(canvasPositionX / num5)) + 1

        if cardWindowStart == var12.cardWindowStart and cardWindowIndex == var12.cardWindowIndex then
            return
        end

        var13({ cardWindowStart = cardWindowStart, cardWindowIndex = cardWindowIndex })
        onItemsUpdatedSignal:fire()
    end, {
        var12,
        itemWidth,
        medium,
        onItemsUpdatedSignal
    })
    local var15 = useLocalization({
        widgetTitle = if widgetInfo and widgetInfo.template then widgetInfo.template.title else nil,
        widgetDescription = if widgetInfo and widgetInfo.template then widgetInfo.template.description else nil
    })

    local informationPopoverText = nil
    local var16, var17

    if widgetInfo and widgetInfo.template then
        if widgetInfo.template.title then
            var16 = var15.widgetTitle
        else
            var16 = widgetInfo.template.localizedTitle
        end

        if widgetInfo.template.description then
            var17 = var15.widgetDescription
        else
            var17 = widgetInfo.template.localizedDescription
        end

        if FFlagAXCatalogItemInformationPopover then
            informationPopoverText = widgetInfo.template.informationPopoverText
        end
    else
        var16 = nil
        var17 = nil
    end

    local onInformationIconActivated = if FFlagAXCatalogItemInformationPopover then useOpenInformationPopover(var16, informationPopoverText) else nil
    local itemFooters = if widgetInfo and widgetInfo.template then widgetInfo.template.itemFooters else nil
    local footerVisibilityFromItemFooters = getFooterVisibilityFromItemFooters(itemFooters)

    local carousel = UnifiedEventLogEnums.WidgetUiTreatment.CAROUSEL

    useAddUnifiedLoggingToCatalogSortEffect({
        containerRef = containerRef,
        widgetInfo = widgetInfo,
        widgetAnalyticsInfo = tbl2.widgetAnalyticsInfo,
        widgetRow = tbl2.widgetRow,
        uiTreatmentType = carousel,
        seeAllRef = if FFlagAXSduiSeeAllClickLogging then var4 else nil,
        seeAllCallback = if FFlagAXSduiSeeAllClickLogging then tbl2.onSeeAll else nil
    })

    local function buildPerTileAnalyticsInfo(arg1, index: number)
        local lookType = if FFlagAXDeferLookImpressionsForHydration or arg1.type ~= ItemTypeEnum.Look then nil else selectHydratedLookType(var10:getState(), arg1.id)
        return Cryo.Dictionary.join(tbl2.widgetAnalyticsInfo, {
            itemPosition = index,
            itemId = arg1.id,
            itemType = arg1.type,
            lookType = lookType,
            themeId = widgetInfo and widgetInfo.tagId,
            gridPositionRow = tbl2.widgetRow,
            gridPositionColumn = index,
            uiTreatmentType = carousel
        })
    end

    local function renderTile(arg1, index: number)
        local widgetAnalyticsInfo = buildPerTileAnalyticsInfo(arg1, index)

        return React.createElement(widgetTileWithImpressionsTagging, {
            size = UDim2.new(0, itemWidth, 0, 0),
            cardStyle = if widgetInfo and widgetInfo.template then widgetInfo.template.cardStyle else nil,
            contentType = arg1.type or WidgetConstants.ContentType.Asset,
            tileContentType = widgetInfo and widgetInfo.type,
            contentId = arg1.id or "",
            index = index,
            refCache = refCache,
            resultsListRef = tbl2.gridRef,
            itemDetailsPeekViewRefs = tbl2.itemDetailsPeekViewRefs,
            itemsPerRow = itemsPerRow,
            analyticsItemCountPerPage = itemsPerRow,
            isCreatorNameVisible = footerVisibilityFromItemFooters.isCreatorNameVisible,
            isTitleVisible = footerVisibilityFromItemFooters.isTitleVisible,
            isPriceVisible = footerVisibilityFromItemFooters.isPriceVisible,
            impressionsTag = var5,
            widgetAnalyticsInfo = widgetAnalyticsInfo,
            onThumbnailLoaded = tbl2.onThumbnailLoaded
        })
    end

    local num5 = math.min(num4, var12.cardWindowStart + itemsPerRow + num1)
    local content = if widgetInfo then widgetInfo.content else nil

    local visibleItems = React.useMemo(function()
        local var19 = content or {}
        local result = {}
        for i = 1, num5 do
            local var20 = var19[i]
            table.insert(result, {
                id = if var20 then var20.id else nil,
                type = if var20 then var20.type else nil,
                absoluteIndex = i,
                gridInformation = { row = 1, column = i }
            })
        end
        return result
    end, { content, num5 })

    local onImpressionsDetected = useOnCatalogSortImpressionsDetectedCallback({
        widgetInfo = widgetInfo,
        widgetAnalyticsInfo = tbl2.widgetAnalyticsInfo,
        widgetRow = tbl2.widgetRow,
        itemsPerRow = itemsPerRow,
        uiTreatmentType = carousel
    })

    local tbl3 = {
        headerText = var16,
        headerDescription = var17,
        informationPopoverText = informationPopoverText,
        onInformationIconActivated = onInformationIconActivated,
        seeAllCallback = 0,
        seeAllRef = 0,
        itemsPerRow = 0,
        itemGap = 0,
        itemWidth = 0,
        canvasWidth = 0,
        carouselItemCount = 0,
        carouselIndex = 0,
        visibleItems = 0,
        renderTile = 0,
        onScrollChanged = 0,
        containerRef = 0,
        impressionsKey = 0,
        widgetRow = 0,
        onItemsUpdatedSignal = 0,
        onImpressionsDetected = 0,
        filterImpressionFunc = 0,
        carouselMargin = 0,
        carouselArrowStyleProps = 0,
        horizontalMargin = 0,
        widgetId = 0,
        ref = 0
    }

    if not FFlagAXSduiSeeAllClickLogging then
        onSeeAll = tbl2.onSeeAll
    end

    tbl3.seeAllCallback = onSeeAll
    if not FFlagAXSduiSeeAllClickLogging then
        var4 = nil
    end

    tbl3.seeAllRef = var4
    tbl3.itemsPerRow = itemsPerRow
    tbl3.itemGap = medium
    tbl3.itemWidth = itemWidth
    tbl3.canvasWidth = canvasWidth
    tbl3.carouselItemCount = math.max(1, num4)
    tbl3.carouselIndex = var12.cardWindowIndex
    tbl3.visibleItems = visibleItems
    tbl3.renderTile = renderTile
    tbl3.onScrollChanged = onScrollChanged
    tbl3.containerRef = containerRef
    tbl3.impressionsKey = var5
    tbl3.widgetRow = tbl2.widgetRow
    tbl3.onItemsUpdatedSignal = onItemsUpdatedSignal
    tbl3.onImpressionsDetected = onImpressionsDetected
    tbl3.filterImpressionFunc = var6
    tbl3.carouselMargin = var1.Margin.Large
    tbl3.carouselArrowStyleProps = carouselArrowStyleProps
    tbl3.horizontalMargin = tbl2.horizontalMargin
    tbl3.widgetId = id
    tbl3.ref = ref
    return tbl3
end

return useCatalogItemCarouselSortViewModel
