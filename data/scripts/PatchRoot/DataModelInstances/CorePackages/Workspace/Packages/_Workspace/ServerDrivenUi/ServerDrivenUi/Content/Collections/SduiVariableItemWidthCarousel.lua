-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local FFlagSduiErrorPaths = require(ServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths

local React = require(ServerDrivenUiParent.React)
local _AppCommonLib = require(ServerDrivenUiParent.AppCommonLib)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local CollectionViews = require(ServerDrivenUiParent.CollectionViews)
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local VariableItemWidthCarousel = require(ServerDrivenUiParent.VariableItemWidthCarousel).VariableItemWidthCarousel
local WaitForPropWrapper = require(ServerDrivenUiParent.GameCollections).WaitForPropWrapper
local Impressions = require(ServerDrivenUiParent.Impressions)
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local ScrollDetector = require(ServerDrivenUiParent.ScrollTelemetry).ScrollDetector
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiCollectionAnalyticsBuilder = SduiCoreSystem.SduiCollectionAnalyticsBuilder
local SduiComponentType = SduiCoreSystem.SduiComponentType
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local SduiCollectionItem = require(ServerDrivenUi.Content.Collections.SduiCollectionItem)
local getImpressionsTag = require(ServerDrivenUi.Analytics.getImpressionsTag)
local useCollectionAnalyticsContext = require(ServerDrivenUiParent.SduiSharedContent).useCollectionAnalyticsContext
local useScrollTelemetryCallback = require(ServerDrivenUi.Analytics.useScrollTelemetryCallback)

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagLuaAppCompositionAlways = SharedFlags.FFlagLuaAppCompositionAlways
local FFlagLuaAppLayoutParamsInContext = SharedFlags.FFlagLuaAppLayoutParamsInContext
local FFlagLuaAppRespectClipAncestorImpressions = SharedFlags.FFlagLuaAppRespectClipAncestorImpressions
local FFlagLuaAppUseFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseFrameBoundsImpressions
local FFlagSduiOptionSelectorHeaderComponent = SharedFlags.FFlagSduiOptionSelectorHeaderComponent
local FFlagSduiOptionSelectorAnchorTag = SharedFlags.FFlagSduiOptionSelectorAnchorTag

local tbl1 = {}

return React.memo(function(tbl2) -- name: SduiVariableItemWidthCarousel
    local sduiContext = tbl2.sduiContext
    local var1 = FFlagLuaAppCompositionAlways or tbl2.appCompositionEnabled or sduiContext.appCompositionEnabled

    local items = tbl2.items or tbl1
    local num1 = #items

    local var3 = useTokens()
    local itemHeight = tbl2.itemHeight or var3.Size.Size_800
    local itemPadding = tbl2.itemPadding or var3.Padding.XSmall

    local var5, ref = React.useState(nil)

    local tbl3 = {
        sideMargin = tbl2.pageSideMargin
    }
    local var7

    if FFlagLuaAppCompositionAlways then
        var7 = nil
    elseif FFlagLuaAppLayoutParamsInContext then
        local var8 = React.useCallback(function(arg1)
            return sduiContext.getPageLayoutConfig("Small")(arg1)
        end, { sduiContext.getPageLayoutConfig })
        var7 = SignalsReact.useSignalState(var8)
    else
        var7 = useCollectionLayoutParams("Small", var5, false, tbl3)
    end

    local sideMargin = if tbl2.sideMargin ~= nil then tbl2.sideMargin elseif var1 then 0 else var7.sideMargin
    local var9 = findAnalyticsField("componentType", tbl2.analyticsContext.analyticsData or tbl1)
        or SduiBuilder.getComponentType(tbl2.componentConfig, sduiContext)
        or SduiComponentType.VariableItemWidthCarousel

    local var10, var11 = useCollectionAnalyticsContext(
        tbl2.analyticsContext,
        var9,
        num1,
        num1,
        sduiContext,
        tbl2.startRow,
        tbl2.componentConfig.__isClientBinding
    )

    local var12 = React.useRef({})
    local var13, var14 = React.useState({})
    local var15 = React.useRef(nil)

    local var2, onCanvasPositionChanged = useCollectionImpressionsSignal(tbl2.scrollViewPositionChangedSignal)

    local impressionsTag = getImpressionsTag(tbl2.index, var11.current, sduiContext, tbl2.debugName)

    local onItemSizeChanged = React.useCallback(function(num2: number, arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X

        if absoluteSizeX <= 0 then
            return
        end

        var14(function(arg2)
            if arg2[num2] == absoluteSizeX then
                return arg2
            end

            local var18 = table.clone(arg2)
            var18[num2] = absoluteSizeX
            return var18
        end)
    end, {})

    local calculateItemWidth = React.useCallback(function(num2: number)
        return var13[num2] or 0
    end, { var13 })

    local sendImpressions = React.useCallback(function(tbl4)
        if num1 ~= 0 then
            reportUnifiedLoggingImpressions(
                sduiContext,
                tbl4,
                var12.current,
                var11.current,
                tbl2.startRow,
                tbl2.impressionEventName,
                tbl2.skipItemImpressionsLog
            )
            return
        end

        if not tbl4 or not (#tbl4 > 0) then
            return
        end

        local var20 = if var10 then SduiParseHelpers.stringifyValue(var10.analyticsData) else nil
        sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogImpressions, {
            componentType = "VariableItemWidthCarousel",
            name = impressionsTag,
            message = `Failed to log impressions. No configs. indexes: {table.concat(tbl4, ",")} analytics: {var20}`
        }, sduiContext.appPage)
    end, {
        num1,
        sduiContext,
        var12,
        var11,
        tbl2.startRow,
        tbl2.impressionEventName,
        tbl2.skipItemImpressionsLog,
        var10,
        impressionsTag
    })

    local sendScrollEvent = useScrollTelemetryCallback(var15, var11, sduiContext)

    local useCallback = React.useCallback
    local function func1(componentConfig, num2: number)
        if not componentConfig then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilItem, {
                componentType = "VariableItemWidthCarousel",
                name = impressionsTag,
                message = `Nil item in VariableItemWidthCarousel.renderItem at index {num2}`
            }, sduiContext.appPage)
            return React.createElement(React.Fragment)
        end

        local var22 = findAnalyticsField("componentType", componentConfig.analyticsData or tbl1)
            or SduiBuilder.getComponentType(componentConfig, sduiContext)

        if not var22 then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, {
                componentType = "VariableItemWidthCarousel",
                name = impressionsTag,
                message = `Nil componentType in VariableItemWidthCarousel.renderItem at index {num2}`
            }, sduiContext.appPage)
            return React.createElement(React.Fragment)
        end

        local localAnalyticsData = {
            itemPosition = num2,
            itemComponentType = var22,
            componentType = var22
        }

        local current = var12.current
        current[num2] = SduiCollectionAnalyticsBuilder.buildAndValidateItemAnalyticsData(
            sduiContext,
            componentConfig.analyticsData,
            nil,
            localAnalyticsData,
            var22,
            nil,
            if FFlagSduiErrorPaths then componentConfig.errorContext else nil
        )

        local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)
        local element = React.createElement(sduiComponentWrapper, {
            componentConfig = componentConfig,
            sduiContext = sduiContext,
            parentAnalyticsContext = if componentConfig.__isClientBinding then nil else var10,
            extraLocalProps = {
                index = num2,
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
                selectionOrder = if tbl2.selectionOrderBase then tbl2.selectionOrderBase + num2 else nil
            },
            debugName = `{var22}_{num2}`,
            localAnalyticsData = localAnalyticsData
        })

        return React.createElement(SduiCollectionItem, {
            index = num2,
            impressionsTag = impressionsTag,
            automaticSize = Enum.AutomaticSize.X,
            size = UDim2.new(0, 0, 0, itemHeight),
            onItemSizeChanged = onItemSizeChanged,
            tag = if FFlagSduiOptionSelectorAnchorTag and tbl2.itemTags then tbl2.itemTags[num2] else nil
        }, { Item = element })
    end

    local scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal
    local verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef
    local selectionOrderBase = tbl2.selectionOrderBase
    local itemTags = if FFlagSduiOptionSelectorAnchorTag then tbl2.itemTags else nil
    local renderItem = useCallback(func1, {
        sduiContext,
        var10,
        impressionsTag,
        itemHeight,
        onItemSizeChanged,
        scrollViewPositionChangedSignal,
        verticalScrollingFrameRef,
        selectionOrderBase,
        itemTags
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var23 = nil
    local tbl4 = {
        Carousel = React.createElement(VariableItemWidthCarousel, {
            ref = ref,
            LayoutOrder = tbl2.layoutOrder,
            Position = tbl2.position,
            title = tbl2.title or "",
            subtitle = tbl2.subtitle,
            headerComponent = if FFlagSduiOptionSelectorHeaderComponent then tbl2.headerComponent else nil,
            calculateItemWidth = calculateItemWidth,
            scrollButtonsEnabled = tbl2.scrollButtonsEnabled,
            scrollSpeed = tbl2.scrollSpeed,
            items = items,
            itemHeight = itemHeight,
            itemPadding = itemPadding,
            onCanvasPositionChanged = onCanvasPositionChanged,
            renderItem = renderItem,
            scrollingFrameRef = var15,
            sideMargin = sideMargin
        }),
        ImpressionDetector = 0,
        ScrollDetector = 0
    }
    local createElement2 = React.createElement
    local var24 = WaitForPropWrapper
    local tbl5 = {
        waitForProp = tbl2.startRow,
        maxUpdatesToDelay = tbl2.numUpdatesToDelayImpressions,
        wrappedComponent = React.createElement(
            if FFlagLuaAppUseFrameBoundsImpressions or tbl2.shouldUseFrameBoundsForImpressions then FrameBoundsImpressionsTracker else ScreenSizeImpressionsTracker,
            {
                parentRef = var15,
                pageContext = sduiContext.routeName or sduiContext.appPage,
                impressionsTag = impressionsTag,
                scrollViewPositionChangedSignal = var2,
                sendImpressions = sendImpressions,
                dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp,
                respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then tbl2.respectClipAncestors else nil
            }
        )
    }
    tbl4.ImpressionDetector = createElement2(var24, tbl5)

    tbl4.ScrollDetector = React.createElement(ScrollDetector, { scrollingFrameRef = var15, sendScrollEvent = sendScrollEvent })
    return createElement(fragment, var23, tbl4)
end)
