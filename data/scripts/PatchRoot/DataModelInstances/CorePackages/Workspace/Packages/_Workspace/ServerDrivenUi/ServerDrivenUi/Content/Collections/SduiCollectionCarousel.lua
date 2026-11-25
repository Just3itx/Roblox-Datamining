-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local FFlagSduiErrorPaths = require(ServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths

local React = require(ServerDrivenUiParent.React)
local _AppCommonLib = require(ServerDrivenUiParent.AppCommonLib)
local Cryo = require(ServerDrivenUiParent.Cryo)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local usePreferredTextSizeLineBudget = require(ServerDrivenUiParent.SduiSharedUtilities).usePreferredTextSizeLineBudget
local CollectionViews = require(ServerDrivenUiParent.CollectionViews)
local CollectionCarousel = CollectionViews.CollectionCarousel
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local WaitForPropWrapper = require(ServerDrivenUiParent.GameCollections).WaitForPropWrapper
local Impressions = require(ServerDrivenUiParent.Impressions)
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local HoverTileCoordinator = require(ServerDrivenUiParent.GameTile).HoverTileCoordinator
local ScrollDetector = require(ServerDrivenUiParent.ScrollTelemetry).ScrollDetector
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens
local _VideoUtils = require(ServerDrivenUiParent.VideoUtils)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local getImpressionsTag = require(ServerDrivenUi.Analytics.getImpressionsTag)
local sendLegacyGameImpressionsForSdui = require(ServerDrivenUi.Analytics.sendLegacyGameImpressionsForSdui)
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiCollectionAnalyticsBuilder = SduiCoreSystem.SduiCollectionAnalyticsBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local addSduiErrorContextFields = SduiCoreSystem.addSduiErrorContextFields
local SduiCollectionItem = require(ServerDrivenUi.Content.Collections.SduiCollectionItem)
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

local useCollectionAnalyticsContext = require(ServerDrivenUiParent.SduiSharedContent).useCollectionAnalyticsContext
local SduiFeedContext = require(ServerDrivenUiParent.SduiSharedContent).SduiFeedContext
local useScrollTelemetryCallback = require(ServerDrivenUi.Analytics.useScrollTelemetryCallback)
local useUniformItemHeight = require(ServerDrivenUi.Content.Collections.useUniformItemHeight)
local ItemHeightMode = require(ServerDrivenUi.Content.Collections.ItemHeightMode)

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagLuaAppLayoutParamsInContext = SharedFlags.FFlagLuaAppLayoutParamsInContext
local FFlagLuaAppRespectClipAncestorImpressions = SharedFlags.FFlagLuaAppRespectClipAncestorImpressions
local FFlagLuaAppCompositionAlways = SharedFlags.FFlagLuaAppCompositionAlways
local FFlagLuaAppUseFrameBoundsImpressions = SharedFlags.FFlagLuaAppUseFrameBoundsImpressions
local FFlagSduiCarouselUseNestedImpressionsFeedContext = SharedFlags.FFlagSduiCarouselUseNestedImpressionsFeedContext
local FFlagLuaAppSduiVideoThumbnail = SharedFlags.FFlagLuaAppSduiVideoThumbnail
local FFlagSduiPreferredTextSizeLineBudgets = SharedFlags.FFlagSduiPreferredTextSizeLineBudgets

local tbl1 = {}

return React.memo(function(tbl2) -- name: SduiCollectionCarousel
    local appCompositionEnabled = FFlagLuaAppCompositionAlways or tbl2.appCompositionEnabled or tbl2.sduiContext.appCompositionEnabled
    local layoutOrder = tbl2.layoutOrder
    local sduiContext = tbl2.sduiContext
    local videoPlaybackContext = if FFlagLuaAppSduiVideoThumbnail then sduiContext.videoPlaybackContext else nil

    local items = React.useMemo(function()
        if not tbl2.items then
            return {}
        end
        for _, item in tbl2.items do
            if tbl2.itemTemplateKey and item.templateKey == nil then
                item.templateKey = tbl2.itemTemplateKey
            end
        end

        if not (tbl2.maxItemsToShow and #tbl2.items > tbl2.maxItemsToShow) then
            return tbl2.items
        end

        local result = {}
        for k, item in tbl2.items do
            if k == tbl2.maxItemsToShow + 1 then
                if tbl2.overflowItem then
                    table.insert(result, tbl2.overflowItem)

                    return result
                end

                break
            end
            table.insert(result, item)
        end
        return result
    end, {
        tbl2.items,
        tbl2.itemTemplateKey,
        tbl2.maxItemsToShow,
        tbl2.overflowItem
    })

    local guiObject, containerRef = React.useState(nil)

    local var5 = React.useRef(nil)
    local var6, var7

    if FFlagLuaAppSduiVideoThumbnail then
        local viewportVideoAutoplayController = if videoPlaybackContext then videoPlaybackContext.viewportVideoAutoplayController else nil

        var6 = React.useCallback(function()
            if viewportVideoAutoplayController then
                viewportVideoAutoplayController:onScrollStart()
            end
        end, { viewportVideoAutoplayController })
        var7 = React.useCallback(function(num1: number)
            if viewportVideoAutoplayController then
                viewportVideoAutoplayController:onScrollSettled("X", num1, { current = var5.current })
            end
        end, { viewportVideoAutoplayController, var5 })
    else
        var6 = nil
        var7 = nil
    end

    local var8 = not tbl2.layoutOverrides and {
        sideMargin = tbl2.pageSideMargin
    }
        or Cryo.Dictionary.join(tbl2.layoutOverrides, { sideMargin = tbl2.pageSideMargin })
    local var9

    if FFlagLuaAppCompositionAlways then
        var9 = nil
    elseif FFlagLuaAppLayoutParamsInContext then
        local var10 = React.useCallback(function(arg1)
            return sduiContext.getPageLayoutConfig(tbl2.collectionItemSize)(arg1)
        end, { tbl2.collectionItemSize, sduiContext.getPageLayoutConfig })
        var9 = SignalsReact.useSignalState(var10)
    else
        var9 = useCollectionLayoutParams(tbl2.collectionItemSize or CollectionItemSize.Small, guiObject, false, var8)
    end

    local num1 = items and #items or 0

    local var10 = findAnalyticsField("componentType", tbl2.analyticsContext.analyticsData or tbl1)
        or SduiBuilder.getComponentType(tbl2.componentConfig, sduiContext)

    local parentAnalyticsContext, var12 = useCollectionAnalyticsContext(
        tbl2.analyticsContext,
        var10,
        num1,
        num1,
        sduiContext,
        tbl2.startRow,
        tbl2.componentConfig.__isClientBinding
    )

    local var13 = React.useRef({})

    local scrollViewPositionChangedSignal, var15 = useCollectionImpressionsSignal(tbl2.scrollViewPositionChangedSignal)

    local value = if FFlagSduiCarouselUseNestedImpressionsFeedContext then React.useMemo(function()
        return {
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
            impressionsParentScrollingFrameRef = var5
        }
    end, { scrollViewPositionChangedSignal, tbl2.verticalScrollingFrameRef, var5 }) else nil

    local impressionsTag = getImpressionsTag(tbl2.index, var12.current, sduiContext, tbl2.debugName)

    local sendImpressions = React.useCallback(function(tbl3)
        if items == nil or #items == 0 then
            if tbl3 and #tbl3 > 0 then
                local var17 = if parentAnalyticsContext then SduiParseHelpers.stringifyValue(parentAnalyticsContext.analyticsData) else nil
                sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogImpressions, {
                    componentType = "CollectionCarousel",
                    name = impressionsTag,
                    message = `Failed to log impressions. No configs. indexes: {table.concat(tbl3, ",")} analytics: {var17}`
                }, sduiContext.appPage)
            end
            return
        end
        assert(items, "itemConfigs must exist")

        if tbl2.impressionEventName or not var12.current or var12.current.contentType ~= "Game" then
            reportUnifiedLoggingImpressions(
                sduiContext,
                tbl3,
                var13.current,
                var12.current,
                tbl2.startRow,
                tbl2.impressionEventName,
                tbl2.skipItemImpressionsLog,
                impressionsTag
            )
            return
        end

        if var12.current and var12.current.contentType == "Game" then
            sendLegacyGameImpressionsForSdui(
                tbl3,
                var13.current,
                items,
                parentAnalyticsContext,
                var12.current,
                tbl2.startRow,
                sduiContext,
                nil,
                nil,
                impressionsTag
            )
        end

        reportUnifiedLoggingImpressions(sduiContext, tbl3, var13.current, var12.current, tbl2.startRow)
    end, {
        items,
        tbl2.startRow,
        sduiContext,
        var12,
        var13,
        parentAnalyticsContext,
        impressionsTag,
        tbl2.impressionEventName,
        tbl2.skipItemImpressionsLog
    })

    local scale = useTokens().Config.UI.Scale
    local var18 = if FFlagSduiPreferredTextSizeLineBudgets then usePreferredTextSizeLineBudget(tbl2.preferredTextSizeLineCount) else nil

    local bool1 = tbl2.itemHeightMode == ItemHeightMode.Uniform
    local var19 = useUniformItemHeight(bool1)
    local onItemSizeChanged = var19.onItemSizeChanged
    local bool2 = if var19 then var19.measuredMaxHeight ~= nil else false
    local var20 = nil
    if bool1 then
        local measuredMaxHeight = var19.measuredMaxHeight
        if measuredMaxHeight and measuredMaxHeight > 0 then
            var20 = UDim.new(0, measuredMaxHeight / scale)
        end
    elseif tbl2.itemHeightMode ~= ItemHeightMode.Auto then
        var20 = tbl2.itemHeightFromWidth
    end

    local bool3 = var20 == nil and #items > 0
    local useCallback = React.useCallback
    local function func1(num2: number)
        if not bool1 then
            if var20 then
                return num2 * var20.Scale + var20.Offset * scale + (var18 or 0)
            end

            return 0
        end

        local measuredMaxHeight = var19.measuredMaxHeight
        return if measuredMaxHeight and measuredMaxHeight > 0 then measuredMaxHeight else 0
    end

    local var21 = var20
    local measuredMaxHeight = var19.measuredMaxHeight
    local var22 = if FFlagSduiPreferredTextSizeLineBudgets then var18 else nil
    local getItemHeight = useCallback(func1, { bool1, var21, measuredMaxHeight, scale, var22 })

    local renderItem = React.useCallback(function(componentConfig, num2: number, size, _)
        if not componentConfig then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilItem, {
                componentType = "CollectionCarousel",
                name = impressionsTag,
                message = `Nil item in CollectionCarousel.renderItem at index {num2}`
            }, sduiContext.appPage)
            return React.createElement(React.Fragment), "nil"
        end

        local var24 = findAnalyticsField("componentType", componentConfig.analyticsData or tbl1)
            or SduiBuilder.getComponentType(componentConfig, sduiContext)

        if not var24 then
            local tbl3 = {
                componentType = "CollectionCarousel",
                name = impressionsTag,
                message = `Nil componentType in CollectionCarousel.renderItem at index {num2}`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl3, componentConfig.errorContext)
            end
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, tbl3, sduiContext.appPage)

            return React.createElement(React.Fragment), "nil"
        end

        local localAnalyticsData = {
            itemPosition = num2,
            itemComponentType = var24,
            componentType = var24
        }

        local current = var13.current
        current[num2] = SduiCollectionAnalyticsBuilder.buildAndValidateItemAnalyticsData(
            sduiContext,
            componentConfig.analyticsData,
            nil,
            localAnalyticsData,
            var24,
            nil,
            if FFlagSduiErrorPaths then componentConfig.errorContext else nil
        )

        local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)
        local element = React.createElement(sduiComponentWrapper, {
            componentConfig = componentConfig,
            sduiContext = sduiContext,
            parentAnalyticsContext = if componentConfig.__isClientBinding then nil else parentAnalyticsContext,
            extraLocalProps = {
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
                index = num2,
                selectionOrder = if tbl2.disableSelectionOrder or not tbl2.selectionOrderBase then nil else tbl2.selectionOrderBase + num2,
                size = if bool1 and bool2 then UDim2.new(1, 0, 1, 0) else nil
            },
            debugName = `{var24}_{num2}`,
            localAnalyticsData = localAnalyticsData
        })

        return React.createElement(SduiCollectionItem, {
            index = num2,
            impressionsTag = impressionsTag,
            automaticSize = if bool3 or bool1 then Enum.AutomaticSize.Y else nil,
            size = size,
            onItemSizeChanged = if bool1 then onItemSizeChanged else nil,
            minHeightBinding = if bool1 then var19.measuredMaxHeightBinding else nil
        }, { Item = element }), var24 or "unknown"
    end, {
        sduiContext,
        tbl2.analyticsContext,
        tbl2.scrollViewPositionChangedSignal,
        tbl2.verticalScrollingFrameRef,
        parentAnalyticsContext,
        bool3,
        impressionsTag,
        tbl2.index,
        tbl2.disableSelectionOrder,
        tbl2.selectionOrderBase,
        bool1,
        onItemSizeChanged,
        bool2,
        var19.measuredMaxHeightBinding
    })

    local var25 = React.useMemo(function()
        local tbl3

        if tbl2.children then
            tbl3 = {}
            for k, child in tbl2.children do
                tbl3[k] = React.cloneElement(child, { parentAnalyticsContext = parentAnalyticsContext })
            end
        else
            tbl3 = nil
        end

        return tbl3
    end, { parentAnalyticsContext, tbl2.children })

    local onScrollButtonEnter = React.useCallback(function()
        HoverTileCoordinator.default:reset()
    end, {})

    local sendScrollEvent = useScrollTelemetryCallback(var5, var12, sduiContext)

    local headerComponent = React.useMemo(function()
        if not tbl2.headerComponent then
            return nil
        end

        return React.cloneElement(tbl2.headerComponent, {
            parentAnalyticsContext = parentAnalyticsContext,
            extraLocalProps = {
                sideMargin = 0,
                appCompositionEnabled = appCompositionEnabled,
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
                startRow = tbl2.startRow,
                numUpdatesToDelayImpressions = tbl2.numUpdatesToDelayImpressions,
                index = tbl2.index
            }
        })
    end, {
        parentAnalyticsContext,
        tbl2.headerComponent,
        appCompositionEnabled,
        tbl2.scrollViewPositionChangedSignal,
        tbl2.verticalScrollingFrameRef,
        tbl2.startRow,
        tbl2.numUpdatesToDelayImpressions,
        tbl2.index
    })

    local focusNavActions = React.useMemo(function()
        if not tbl2.focusNavActionsComponent then
            return nil
        end

        return React.cloneElement(
            tbl2.focusNavActionsComponent,
            {
                parentAnalyticsContext = parentAnalyticsContext,
                extraLocalProps = { guiObject = guiObject }
            }
        )
    end, { parentAnalyticsContext, tbl2.focusNavActionsComponent, guiObject })

    local element = React.createElement(CollectionCarousel, {
        collectionItemSize = if appCompositionEnabled then tbl2.collectionItemSize else nil,
        onReachedThresholdFromEnd = tbl2.onScrollToEnd,
        thresholdFromEnd = tbl2.scrollThresholdFromEnd,
        containerRef = containerRef,
        scrollingFrameRef = var5,
        getItemHeight = getItemHeight,
        items = items,
        renderItem = renderItem,
        numColumns = if appCompositionEnabled then tbl2.numColumnsOverride else var9.numColumns,
        fractionalItemAmount = if appCompositionEnabled then nil else var9.fractionalItemAmount,
        columnGap = if appCompositionEnabled then nil else var9.columnGap,
        sideMargin = if appCompositionEnabled then nil else var9.sideMargin,
        onViewableItemsChanged = var15,
        onChangeCanvasPosition = var15,
        LayoutOrder = layoutOrder,
        scrollingEnabledOverride = tbl2.scrollingEnabledOverride,
        AutomaticSize = if bool3 or bool1 then Enum.AutomaticSize.Y else nil,
        headerComponent = headerComponent,
        backgroundMuralUrl = tbl2.backgroundMuralUrl,
        onScrollButtonEnter = onScrollButtonEnter,
        numItemsToRenderOffScreen = tbl2.numItemsToRenderOffScreen,
        enableHoverOverflow = tbl2.enableHoverOverflow,
        testId = if tbl2.testId then tbl2.testId else "--sdui-collection-carousel"
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var30 = nil
    local join = Cryo.Dictionary.join
    local var31 = var25 or tbl1
    local tbl3 = {
        CollectionCarousel = 0,
        ImpressionDetector = 0,
        ScrollDetector = 0,
        FocusNavActions = 0
    }

    if FFlagSduiCarouselUseNestedImpressionsFeedContext and value then
        element = React.createElement(SduiFeedContext.Provider, { value = value }, element)
    end

    tbl3.CollectionCarousel = element

    local createElement2 = React.createElement
    local var32 = WaitForPropWrapper
    local tbl4 = {
        waitForProp = tbl2.startRow,
        maxUpdatesToDelay = tbl2.numUpdatesToDelayImpressions,
        wrappedComponent = 0
    }
    local element2

    if FFlagLuaAppUseFrameBoundsImpressions or tbl2.shouldUseFrameBoundsForImpressions then
        element2 = React.createElement(FrameBoundsImpressionsTracker, {
            parentRef = var5,
            pageContext = sduiContext.routeName or sduiContext.appPage,
            impressionsTag = impressionsTag,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            sendImpressions = sendImpressions,
            dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp,
            respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then tbl2.respectClipAncestors else nil
        })
    else
        element2 = React.createElement(ScreenSizeImpressionsTracker, {
            parentRef = var5,
            pageContext = sduiContext.routeName or sduiContext.appPage,
            impressionsTag = impressionsTag,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            sendImpressions = sendImpressions,
            dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp
        })
    end

    tbl4.wrappedComponent = element2
    tbl3.ImpressionDetector = createElement2(var32, tbl4)

    local createElement3 = React.createElement
    local var33 = ScrollDetector
    local tbl5 = {
        scrollingFrameRef = var5,
        sendScrollEvent = sendScrollEvent,
        onScrollStart = 0,
        onScrollSettled = 0
    }

    if not FFlagLuaAppSduiVideoThumbnail then
        var6 = nil
    end

    tbl5.onScrollStart = var6
    if not FFlagLuaAppSduiVideoThumbnail then
        var7 = nil
    end

    tbl5.onScrollSettled = var7
    tbl3.ScrollDetector = createElement3(var33, tbl5)

    tbl3.FocusNavActions = focusNavActions
    return createElement(fragment, var30, join(var31, tbl3))
end)
