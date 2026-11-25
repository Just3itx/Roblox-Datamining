-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local FFlagSduiErrorPaths = require(ServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths

local React = require(ServerDrivenUiParent.React)
local _AppCommonLib = require(ServerDrivenUiParent.AppCommonLib)
local Cryo = require(ServerDrivenUiParent.Cryo)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local CollectionViews = require(ServerDrivenUiParent.CollectionViews)
local CollectionGrid = CollectionViews.CollectionGrid
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal
local useCollectionLayout = CollectionViews.useCollectionLayout
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local WaitForPropWrapper = require(ServerDrivenUiParent.GameCollections).WaitForPropWrapper
local Impressions = require(ServerDrivenUiParent.Impressions)
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens
local usePreferredTextSizeLineBudget = require(ServerDrivenUiParent.SduiSharedUtilities).usePreferredTextSizeLineBudget

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local getImpressionsTag = require(ServerDrivenUi.Analytics.getImpressionsTag)
local sendLegacyGameImpressionsForSdui = require(ServerDrivenUi.Analytics.sendLegacyGameImpressionsForSdui)
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiCollectionAnalyticsBuilder = SduiCoreSystem.SduiCollectionAnalyticsBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

local SduiCollectionItem = require(ServerDrivenUi.Content.Collections.SduiCollectionItem)
local SduiCollectionGridRevealRows = require(ServerDrivenUi.Content.Collections.SduiCollectionGridRevealRows)
local useCollectionAnalyticsContext = require(ServerDrivenUiParent.SduiSharedContent).useCollectionAnalyticsContext
local createGameDwellObserver = require(ServerDrivenUiParent.DiscoveryAnalytics).Dwell.createGameDwellObserver

local FFlagLuaAppLayoutParamsInContext = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppLayoutParamsInContext
local FFlagLuaAppCompositionAlways = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppCompositionAlways
local FFlagSduiFixSearchTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiFixSearchTelemetry
local FFlagSduiPreferredTextSizeLineBudgets = require(ServerDrivenUiParent.SharedFlags).FFlagSduiPreferredTextSizeLineBudgets
local FFlagSduiCollectionGridRevealRows = require(ServerDrivenUiParent.SharedFlags).FFlagSduiCollectionGridRevealRows
local FFlagLuaAppSduiGameDwell = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameDwell

local function cellSizeFromSpan(spanOverride, num1: number, num2: number): UDim2 -- Luacid: Inlined by compiler; 1 call site recovered
    local colSpan = spanOverride.colSpan or 1
    local rowSpan = spanOverride.rowSpan or 1
    return UDim2.new(colSpan, num1 * (colSpan - 1), rowSpan, num2 * (rowSpan - 1))
end

local tbl1 = {}

return React.memo(function(tbl2) -- name: SduiCollectionGrid
    local var1 = FFlagLuaAppCompositionAlways or tbl2.appCompositionEnabled or tbl2.sduiContext.appCompositionEnabled

    local layoutOrder = tbl2.layoutOrder
    local sduiContext = tbl2.sduiContext

    local items = React.useMemo(function()
        if tbl2.items == nil then
            return tbl1
        end
        for _, item in tbl2.items do
            if tbl2.itemTemplateKey and item.templateKey == nil then
                item.templateKey = tbl2.itemTemplateKey
            end
        end

        return tbl2.items
    end, { tbl2.items, tbl2.itemTemplateKey })

    local var3, var4 = React.useState(nil)
    local parentRef = React.useRef(nil)
    parentRef.current = var3
    local var6

    if FFlagLuaAppCompositionAlways then
        var6 = nil
    elseif FFlagLuaAppLayoutParamsInContext then
        local var7 = React.useCallback(function(arg1)
            return sduiContext.getPageLayoutConfig(tbl2.collectionItemSize)(arg1)
        end, { tbl2.collectionItemSize, sduiContext.getPageLayoutConfig })
        var6 = SignalsReact.useSignalState(var7)
    else
        var6 = useCollectionLayoutParams(
            tbl2.collectionItemSize or CollectionItemSize.Small,
            var3,
            false,
            not tbl2.layoutOverrides and {
                overrideLoadMoreThreshold = math.huge,
                sideMargin = tbl2.pageSideMargin
            }
                or Cryo.Dictionary.join(tbl2.layoutOverrides, { overrideLoadMoreThreshold = math.huge, sideMargin = tbl2.pageSideMargin })
        )
    end

    local num1 = 0
    if items then
        for _, value in items do
            if not value.isBlank then
                num1 += 1
            end
        end
    end
    local var7 = useCollectionLayout(tbl2.collectionItemSize)
    local itemsPerRow = var7.itemsPerRow

    if not var1 then
        itemsPerRow = var6.numColumns
    end

    local var8 = if var1 then var7.gutter else var6 and var6.columnGap or 0
    local var9 = if var1 then var7.verticalGap else var6 and var6.verticalPadding or 0
    local var10 = findAnalyticsField("componentType", tbl2.analyticsContext.analyticsData or tbl1)
        or SduiBuilder.getComponentType(tbl2.componentConfig, sduiContext)

    local parentAnalyticsContext, var12 = useCollectionAnalyticsContext(
        tbl2.analyticsContext,
        var10,
        itemsPerRow,
        num1,
        sduiContext,
        tbl2.startRow,
        tbl2.componentConfig.__isClientBinding
    )

    local var13 = React.useRef({})

    local scrollViewPositionChangedSignal, var15 = useCollectionImpressionsSignal(tbl2.scrollViewPositionChangedSignal)

    local onViewableItemsChanged = React.useCallback(function(_: number, _: number)
        if tbl2.onCollectionViewabilityChanged then
            tbl2.onCollectionViewabilityChanged()
        end

        if var15 then
            var15()
        end
    end, { var15, tbl2.onCollectionViewabilityChanged })

    local impressionsTag = tbl2.impressionsTag or getImpressionsTag(tbl2.index, var12.current, sduiContext, tbl2.debugName)
    local var17

    if FFlagLuaAppSduiGameDwell then
        local current = var12.current
        local bool1 = tbl2.dwellLoggingEnabled == true
        local useMemo = React.useMemo
        local function func1()
            if not bool1 then
                return nil
            end

            return (createGameDwellObserver({
                pageContext = sduiContext.routeName or sduiContext.appPage,
                getCollectionData = function()
                    return var12.current
                end,
                getItemData = function(num2: number)
                    return var13.current[num2]
                end,
                collectionItemSize = tbl2.collectionItemSize
            }))
        end

        local routeName = sduiContext.routeName
        local appPage = sduiContext.appPage

        local collectionItemSize = tbl2.collectionItemSize
        local collectionId = if current then current.collectionId else nil
        local collectionPosition = if current then current.collectionPosition else nil
        local collectionComponentType = if current then current.collectionComponentType else nil
        local itemsPerRow2 = if current then current.itemsPerRow else nil
        local startRowNumber = if current then current.startRowNumber else nil
        var17 = useMemo(func1, {
            bool1,
            routeName,
            appPage,
            var12,
            var13,
            collectionItemSize,
            collectionId,
            collectionPosition,
            collectionComponentType,
            itemsPerRow2,
            startRowNumber
        })
    else
        var17 = nil
    end

    local sendImpressions = React.useCallback(function(tbl3)
        if items == nil or #items == 0 then
            if tbl3 and #tbl3 > 0 then
                local var18 = if parentAnalyticsContext then SduiParseHelpers.stringifyValue(parentAnalyticsContext.analyticsData) else nil
                sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogImpressions, {
                    componentType = "CollectionGrid",
                    name = impressionsTag,
                    message = `Failed to log impressions. No configs. indexes: {table.concat(tbl3, ",")} analytics: {var18}`
                }, sduiContext.appPage)
            end
            return
        end
        assert(items, "itemConfigs must exist")

        if (tbl2.impressionEventName or not var12.current or var12.current.contentType ~= "Game") and not tbl2.sendGameImpressions then
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
                tbl2.sendGameImpressions,
                var12.current.itemsPerRow,
                impressionsTag
            )
        end

        reportUnifiedLoggingImpressions(sduiContext, tbl3, var13.current, var12.current)
    end, {
        items,
        tbl2.startRow,
        sduiContext,
        var12,
        var13,
        parentAnalyticsContext,
        tbl2.sendGameImpressions,
        impressionsTag,
        tbl2.impressionEventName,
        tbl2.skipItemImpressionsLog
    })

    React.useLayoutEffect(function()
        if tbl2.setLogImpressions then
            tbl2.setLogImpressions(sendImpressions)
        end
    end, { sendImpressions, tbl2.setLogImpressions })

    local scale = useTokens().Config.UI.Scale
    local var19 = if FFlagSduiPreferredTextSizeLineBudgets then usePreferredTextSizeLineBudget(tbl2.preferredTextSizeLineCount) else nil

    local useCallback = React.useCallback
    local function func1(num2: number)
        return num2 * tbl2.itemHeightFromWidth.Scale + tbl2.itemHeightFromWidth.Offset * scale + (var19 or 0)
    end

    local itemHeightFromWidth = tbl2.itemHeightFromWidth
    local var20 = if FFlagSduiPreferredTextSizeLineBudgets then var19 else nil
    local getItemHeight = useCallback(func1, { itemHeightFromWidth, scale, var20 })

    local renderItem = React.useCallback(function(componentConfig, num2: number, size, _: number?)
        if componentConfig and componentConfig.isBlank then
            return React.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = num2 }), "blank"
        end

        if not componentConfig then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilItem, {
                componentType = "CollectionGrid",
                name = impressionsTag,
                message = `Nil item in SduiCollectionGrid.renderItem at index {num2}`
            }, sduiContext.appPage)
            return React.createElement(React.Fragment), "nil"
        end

        local var22 = findAnalyticsField("componentType", componentConfig.analyticsData or tbl1)
            or SduiBuilder.getComponentType(componentConfig, sduiContext)

        if not var22 then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, {
                componentType = "CollectionGrid",
                name = impressionsTag,
                message = `Nil componentType in CollectionGrid.renderItem at index {num2}`
            }, sduiContext.appPage)
            return React.createElement(React.Fragment), "nil"
        end

        local localAnalyticsData = {
            itemPosition = num2,
            itemComponentType = var22,
            componentType = var22,
            topicContentsIndex = componentConfig.realIndex,
            topicDataPosition = if FFlagSduiFixSearchTelemetry then componentConfig.realIndex else nil
        }

        local current = var13.current
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
            parentAnalyticsContext = if componentConfig.__isClientBinding then nil else parentAnalyticsContext,
            extraLocalProps = {
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
                index = num2,
                selectionOrder = if tbl2.disableSelectionOrder or not tbl2.selectionOrderBase then nil else tbl2.selectionOrderBase + num2,
                alignmentType = if componentConfig.spanOverride == nil then nil else componentConfig.spanOverride.alignmentType,
                cellVerticalPadding = if componentConfig.spanOverride == nil then nil else var9
            },
            debugName = `{var22}_{num2}`,
            localAnalyticsData = localAnalyticsData
        })

        return React.createElement(SduiCollectionItem, {
            index = num2,
            impressionsTag = impressionsTag,
            size = size,
            zIndex = -num2,
            innerWrapperSize = if componentConfig.spanOverride == nil then nil else cellSizeFromSpan(componentConfig.spanOverride, var8, var9)
        }, { Item = element }), var22 or "unknown"
    end, {
        sduiContext,
        tbl2.analyticsContext,
        tbl2.scrollViewPositionChangedSignal,
        tbl2.verticalScrollingFrameRef,
        parentAnalyticsContext,
        impressionsTag,
        tbl2.index,
        tbl2.disableSelectionOrder,
        tbl2.selectionOrderBase,
        var8,
        var9
    })

    local var23 = React.useMemo(function()
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

    local headerComponent = React.useMemo(function()
        if tbl2.headerComponent then
            return React.cloneElement(tbl2.headerComponent, { parentAnalyticsContext = parentAnalyticsContext })
        end

        return nil
    end, { parentAnalyticsContext, tbl2.headerComponent })

    local focusNavActions = React.useMemo(function()
        if not tbl2.focusNavActionsComponent then
            return nil
        end

        return React.cloneElement(
            tbl2.focusNavActionsComponent,
            {
                parentAnalyticsContext = parentAnalyticsContext,
                extraLocalProps = { guiObject = var3 }
            }
        )
    end, { parentAnalyticsContext, tbl2.focusNavActionsComponent, var3 })

    local gridProps = {
        collectionItemSize = if var1 then tbl2.collectionItemSize else nil,
        verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
        containerRef = var4,
        getItemHeight = getItemHeight,
        items = items,
        renderItem = renderItem,
        numColumns = if var1 then nil else var6.numColumns,
        columnGap = if var1 then nil else var6.columnGap,
        sideMargin = if var1 then nil else var6.sideMargin,
        onViewableItemsChanged = onViewableItemsChanged,
        LayoutOrder = layoutOrder,
        verticalPadding = if var1 then nil else var6.verticalPadding,
        disableRelativeGap = true,
        headerComponent = headerComponent,
        testId = if tbl2.testId then tbl2.testId else "--sdui-collection-grid",
        onReachedThresholdFromEnd = tbl2.onReachedThresholdFromEnd,
        thresholdRowsFromBottom = tbl2.thresholdRowsFromBottom,
        maxNumRows = tbl2.maxNumRows
    }

    local createElement = React.createElement
    local fragment = React.Fragment
    local var26 = nil
    local join = Cryo.Dictionary.join
    local var27 = var23 or tbl1
    local tbl4 = { CollectionGrid = 0, ImpressionDetector = 0, FocusNavActions = 0 }
    local element

    if FFlagSduiCollectionGridRevealRows
        and (tbl2.initialFeedVisibleRows ~= nil or tbl2.visibleRowsPerReveal ~= nil)
        and tbl2.setDisplayedRowCount ~= nil
        and tbl2.revealRowsComponent ~= nil
    then
        element = React.createElement(SduiCollectionGridRevealRows, {
            gridProps = gridProps,
            sduiContext = tbl2.sduiContext,
            analyticsContext = tbl2.analyticsContext,
            itemCount = #items,
            itemsPerRow = itemsPerRow,
            maxNumRows = tbl2.maxNumRows,
            initialFeedVisibleRows = tbl2.initialFeedVisibleRows,
            visibleRowsPerReveal = tbl2.visibleRowsPerReveal,
            startRow = tbl2.startRow,
            setDisplayedRowCount = tbl2.setDisplayedRowCount,
            revealRowsComponent = tbl2.revealRowsComponent,
            containerFrame = var3,
            setContainerFrame = var4
        })
    else
        element = React.createElement(CollectionGrid, gridProps)
    end

    tbl4.CollectionGrid = element
    local var28

    if tbl2.disableImpressionsDetector then
        var28 = nil
    else
        local createElement2 = React.createElement
        local var29 = WaitForPropWrapper
        local tbl5 = {
            waitForProp = tbl2.startRow,
            maxUpdatesToDelay = tbl2.numUpdatesToDelayImpressions,
            wrappedComponent = 0
        }
        local var30

        if tbl2.shouldUseFrameBoundsForImpressions then
            local createElement3 = React.createElement
            local var31 = FrameBoundsImpressionsTracker
            local tbl6 = {
                parentRef = parentRef,
                pageContext = sduiContext.routeName or sduiContext.appPage,
                impressionsTag = impressionsTag,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                sendImpressions = sendImpressions,
                dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp,
                visibilityObserver = 0
            }

            if not FFlagLuaAppSduiGameDwell then
                var17 = nil
            end

            tbl6.visibilityObserver = var17
            var30 = createElement3(var31, tbl6)
        else
            local createElement3 = React.createElement
            local var31 = ScreenSizeImpressionsTracker
            local tbl6 = {
                parentRef = parentRef,
                pageContext = sduiContext.routeName or sduiContext.appPage,
                impressionsTag = impressionsTag,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                sendImpressions = sendImpressions,
                dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp,
                visibilityObserver = 0
            }

            if not FFlagLuaAppSduiGameDwell then
                var17 = nil
            end

            tbl6.visibilityObserver = var17
            var30 = createElement3(var31, tbl6)
        end

        tbl5.wrappedComponent = var30
        var28 = createElement2(var29, tbl5)
    end

    tbl4.ImpressionDetector = var28

    tbl4.FocusNavActions = focusNavActions
    return createElement(fragment, var26, join(var27, tbl4))
end)
