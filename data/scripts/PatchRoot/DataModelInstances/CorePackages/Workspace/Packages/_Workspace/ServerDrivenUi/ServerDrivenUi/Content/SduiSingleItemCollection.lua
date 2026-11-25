-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local FFlagSduiErrorPaths = require(ServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths
local _AppCommonLib = require(ServerDrivenUiParent.AppCommonLib)
local Cryo = require(ServerDrivenUiParent.Cryo)
local React = require(ServerDrivenUiParent.React)
local _UnifiedLogging = require(ServerDrivenUiParent.UnifiedLogging)

local SendGameImpressions = require(ServerDrivenUiParent.GameCollections).SendGameImpressions
local WaitForPropWrapper = require(ServerDrivenUiParent.GameCollections).WaitForPropWrapper

local Impressions = require(ServerDrivenUiParent.Impressions)
local ImpressionsTagUtility = Impressions.ImpressionsTagUtility
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local getImpressionsTag = require(ServerDrivenUi.Analytics.getImpressionsTag)
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiCollectionAnalyticsBuilder = SduiCoreSystem.SduiCollectionAnalyticsBuilder

local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiParsers = SduiCoreSystem.SduiParsers
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

local tbl1 = {}

return React.memo(function(tbl2) -- name: SduiSingleItemCollection
    local layoutOrder = tbl2.layoutOrder
    local anchorPoint = tbl2.anchorPoint
    local automaticSize = tbl2.automaticSize
    local size = tbl2.size
    local position = tbl2.position

    local sduiContext = tbl2.sduiContext
    local children = tbl2.children

    local var1 = React.useRef(nil)

    local var2 = React.useRef({})

    local getCollectionData = React.useCallback(function()
        return var1.current
    end, { var1 })

    local parentAnalyticsContext = React.useMemo(function()
        if tbl2.componentConfig.__isClientBinding then
            tbl2.analyticsContext.getCollectionData = getCollectionData
        end
        return Cryo.Dictionary.join(tbl2.analyticsContext or tbl1, { getCollectionData = getCollectionData })
    end, { getCollectionData, tbl2.analyticsContext, tbl2.componentConfig.__isClientBinding })

    var1.current = React.useMemo(function()
        local var5 = findAnalyticsField("componentType", tbl2.analyticsContext.analyticsData or tbl1)
            or SduiBuilder.getComponentType(tbl2.componentConfig, sduiContext)

        return SduiCollectionAnalyticsBuilder.buildAndValidateCollectionAnalyticsData(
            sduiContext,
            tbl2.analyticsContext.ancestorAnalyticsData,
            tbl2.analyticsContext.analyticsData,
            var5,
            1,
            1,
            nil,
            `SingleItemCollection_{tbl2.index}`,
            tbl2.startRow
        )
    end, {
        sduiContext,
        tbl2.analyticsContext,
        tbl2.componentConfig,
        tbl2.index,
        tbl2.startRow
    })

    local impressionsTag = getImpressionsTag(tbl2.index, var1.current, sduiContext, tbl2.debugName)

    local ref = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, impressionsTag, 1)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, impressionsTag, 1)
        end
    end, { ref, impressionsTag })

    local sendImpressions = React.useCallback(function(tbl3)
        if tbl2.item == nil then
            return
        end
        assert(tbl2.item, "props.item must exist")

        if tbl2.impressionEventName or not var1.current or var1.current.contentType ~= "Game" then
            reportUnifiedLoggingImpressions(
                sduiContext,
                tbl3,
                var2.current,
                var1.current,
                tbl2.startRow,
                tbl2.impressionEventName,
                tbl2.skipItemImpressionsLog,
                impressionsTag
            )
            return
        end

        if var1.current
            and (var1.current.contentType == "HeroUnit" or var1.current.contentType == "Game")
            and tbl2.item.analyticsData
            and tbl2.item.analyticsData.universeId ~= nil
        then
            local tbl4 = {}
            for _, value in var2.current or tbl1 do
                table.insert(
                    tbl4,
                    (Cryo.Dictionary.join(
                        value,
                        {
                            isSponsored = SduiParsers.safeParseBoolean(value.adFlag, sduiContext, parentAnalyticsContext)
                        }
                    ))
                )
            end

            SendGameImpressions.sendFromTopicContents(
                sduiContext.dependencies.eventIngest,
                sduiContext.dependencies.appAnalytics,
                tbl3,
                tbl4,
                sduiContext.appPage,
                tostring(var1.current.collectionId),
                tbl2.index,
                tbl2.startRow,
                nil,
                nil,
                1,
                false,
                "HeroUnit",
                nil
            )
        end

        reportUnifiedLoggingImpressions(sduiContext, tbl3, var2.current, var1.current)
    end, {
        tbl2.item,
        tbl2.index,
        tbl2.startRow,
        sduiContext,
        var1,
        var2,
        parentAnalyticsContext,
        tbl2.impressionEventName,
        tbl2.skipItemImpressionsLog,
        impressionsTag
    })

    local var7 = React.useMemo(function()
        local result = ({})

        if tbl2.children then
            for k, child in tbl2.children do
                result[k] = React.cloneElement(child, { parentAnalyticsContext = parentAnalyticsContext })
            end
        end

        assert(result, "result must exist")

        if tbl2.item then
            local itemComponentType = findAnalyticsField("componentType", tbl2.item.analyticsData or tbl1)
                or SduiBuilder.getComponentType(tbl2.componentConfig, sduiContext)

            local debugName = `SingleItemCollection_{itemComponentType}`

            local localAnalyticsData = { itemPosition = 1, itemComponentType = itemComponentType }

            local current = var2.current
            current[1] = SduiCollectionAnalyticsBuilder.buildAndValidateItemAnalyticsData(
                sduiContext,
                tbl2.item.analyticsData,
                nil,
                localAnalyticsData,
                itemComponentType,
                nil,
                if FFlagSduiErrorPaths then tbl2.item.errorContext else nil
            )

            local sduiComponentWrapper = getSduiComponentWrapper(tbl2.item)

            result[debugName] = React.createElement(sduiComponentWrapper, {
                componentConfig = tbl2.item,
                sduiContext = sduiContext,
                parentAnalyticsContext = if tbl2.item.__isClientBinding then nil else parentAnalyticsContext,
                extraLocalProps = {
                    scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                    verticalScrollingFrameRef = tbl2.verticalScrollingFrameRef,
                    index = 1,
                    pageSideMargin = tbl2.pageSideMargin,
                    selectionOrder = if tbl2.disableSelectionOrder then nil else tbl2.selectionOrderBase
                },
                debugName = debugName,
                localAnalyticsData = localAnalyticsData
            })
        end
        return result
    end, {
        tbl2.item,
        tbl2.scrollViewPositionChangedSignal,
        tbl2.verticalScrollingFrameRef,
        var1,
        children,
        sduiContext,
        tbl2.pageSideMargin,
        tbl2.disableSelectionOrder,
        tbl2.selectionOrderBase
    })

    local wrappedComponent = React.createElement(ScreenSizeImpressionsTracker, {
        parentRef = tbl2.verticalScrollingFrameRef,
        pageContext = sduiContext.routeName or sduiContext.appPage,
        impressionsTag = impressionsTag,
        scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
        sendImpressions = sendImpressions,
        dataUpdatedTimestamp = tbl2.sduiContext.dataUpdatedTimestamp
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl3 = {
        Content = React.createElement("Frame", {
            ref = ref,
            Position = position,
            Size = size or UDim2.new(1, 0, 0, 0),
            AutomaticSize = automaticSize or Enum.AutomaticSize.Y,
            LayoutOrder = layoutOrder,
            AnchorPoint = anchorPoint,
            BackgroundTransparency = 1,
            [React.Tag] = "data-testid=--sdui-single-item-collection"
        }, var7),
        ImpressionDetector = React.createElement(WaitForPropWrapper, {
            waitForProp = tbl2.startRow,
            maxUpdatesToDelay = tbl2.numUpdatesToDelayImpressions,
            wrappedComponent = wrappedComponent
        })
    }
    return createElement(fragment, nil, tbl3)
end)
