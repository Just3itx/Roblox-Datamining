-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local FFlagSduiErrorPaths = require(SduiSharedContentParent.SharedFlags).FFlagSduiErrorPaths

local React = require(SduiSharedContentParent.React)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)

local Impressions = require(SduiSharedContentParent.Impressions)
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker
local ImpressionsTagUtility = Impressions.ImpressionsTagUtility

local _UnifiedLogging = require(SduiSharedContentParent.UnifiedLogging)

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiCollectionAnalyticsBuilder = SduiCoreSystem.SduiCollectionAnalyticsBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local addSduiErrorContextFields = SduiCoreSystem.addSduiErrorContextFields

local SduiFeedContext = require(script.Parent.SduiFeedContext)
local SduiView = require(script.Parent.SduiView)
local useCollectionAnalyticsContext = require(script.Parent.useCollectionAnalyticsContext)

local SharedFlags = require(SduiSharedContentParent.SharedFlags)
local FFlagLuaAppRespectClipAncestorImpressions = SharedFlags.FFlagLuaAppRespectClipAncestorImpressions
local FFlagSduiCarouselUseNestedImpressionsFeedContext = SharedFlags.FFlagSduiCarouselUseNestedImpressionsFeedContext

local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local var1 = table.freeze({})

local function ImpressionTaggedSduiItem(tbl1)
    local var2 = React.useRef(nil)

    React.useEffect(function()
        if tbl1.impressionsTag then
            ImpressionsTagUtility.AddTag(var2, tbl1.impressionsTag, tbl1.index)
            return function()
                ImpressionsTagUtility.RemoveTag(var2, tbl1.impressionsTag, tbl1.index)
            end
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local ref = React.useCallback(function(current)
        var2.current = current
        if current and tbl1.impressionsTag then
            ImpressionsTagUtility.AddTag(var2, tbl1.impressionsTag, tbl1.index)
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local sduiComponentWrapper = getSduiComponentWrapper(tbl1.item)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        ref = ref,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.index,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = {
        Item = React.createElement(sduiComponentWrapper, {
            componentConfig = tbl1.item,
            sduiContext = tbl1.sduiContext,
            parentAnalyticsContext = if tbl1.item.__isClientBinding then nil else tbl1.collectionAnalyticsContext,
            extraLocalProps = {
                index = tbl1.index,
                layoutOrder = tbl1.index,
                scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef
            },
            debugName = if tbl1.debugName then `{tbl1.debugName}.Item_{tbl1.index}` else `Item_{tbl1.index}`,
            localAnalyticsData = tbl1.localAnalyticsData
        })
    }
    return createElement(str1, tbl2, tbl3)
end

local function resolveImpressionsTag(tbl1, arg1, str1: string?, name: string?, index: number, sduiContext)
    local current = tbl1.current
    if not current then
        sduiContext.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionData,
            { name = name },
            sduiContext.appPage
        )
        return nil
    end

    local collectionComponentType = current.collectionComponentType
    if collectionComponentType then
        arg1 = collectionComponentType
    else
        sduiContext.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionComponentType,
            { name = name },
            sduiContext.appPage
        )
    end

    local collectionId = current.collectionId

    if collectionId ~= nil and collectionId ~= -1 then
        return `{name}_{arg1}_{str1}_{collectionId}_{index}`
    end

    sduiContext.dependencies.logger.reportError(
        SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionId,
        { name = name },
        sduiContext.appPage
    )
    return nil
end

return React.memo(function(tbl1) -- name: SduiVerticalListWithImpressions
    local sduiContext = tbl1.sduiContext
    local var2 = tbl1.items or var1
    local num1 = #var2
    local var3 = React.useContext(SduiFeedContext)

    local scrollViewPositionChangedSignal = var3.scrollViewPositionChangedSignal or tbl1.scrollViewPositionChangedSignal
    local verticalScrollingFrameRef = var3.verticalScrollingFrameRef or tbl1.verticalScrollingFrameRef

    local containerRef = React.useRef(nil)

    local parentRef = (if FFlagSduiCarouselUseNestedImpressionsFeedContext then var3.impressionsParentScrollingFrameRef else nil)
        or containerRef

    local componentType = findAnalyticsField("componentType", tbl1.analyticsContext.analyticsData or var1)
        or SduiBuilder.getComponentType(tbl1.componentConfig, sduiContext)

    local collectionAnalyticsContext, var8 = useCollectionAnalyticsContext(
        tbl1.analyticsContext,
        componentType,
        1,
        num1,
        sduiContext,
        tbl1.startRow,
        tbl1.componentConfig.__isClientBinding
    )

    local var9 = React.useRef({})

    local pageContext = sduiContext.routeName or sduiContext.appPage
    local index = tbl1.index or 0

    local var11 = resolveImpressionsTag(var8, componentType, pageContext, tbl1.debugName, index, sduiContext)

    local sendImpressions = React.useCallback(function(tbl2)
        if #var2 ~= 0 then
            reportUnifiedLoggingImpressions(
                sduiContext,
                tbl2,
                var9.current,
                var8.current,
                tbl1.startRow,
                tbl1.impressionEventName,
                tbl1.skipItemImpressionsLog,
                var11
            )
            return
        end

        if not tbl2 or not (#tbl2 > 0) then
            return
        end

        local var12 = if collectionAnalyticsContext then SduiParseHelpers.stringifyValue(collectionAnalyticsContext.analyticsData) else nil
        sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogImpressions, {
            componentType = componentType,
            name = var11,
            message = `Failed to log impressions. No configs. indexes: {table.concat(tbl2, ",")} analytics: {var12}`
        }, sduiContext.appPage)
    end, {
        var2,
        sduiContext,
        var9,
        var8,
        collectionAnalyticsContext,
        componentType,
        var11,
        tbl1.startRow,
        tbl1.impressionEventName,
        tbl1.skipItemImpressionsLog
    })

    local children = React.useMemo(function()
        local result = ({})

        local current = ({})
        for value, value2 in var2 do
            if not value2 then
                sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilItem, {
                    componentType = componentType,
                    name = var11,
                    message = `Nil item in SduiVerticalListWithImpressions at index {value}`
                }, sduiContext.appPage)
            else
                local var13 = findAnalyticsField("componentType", value2.analyticsData or var1) or SduiBuilder.getComponentType(value2, sduiContext)

                if not var13 then
                    local tbl3 = {
                        componentType = componentType,
                        name = var11,
                        message = `Nil componentType in SduiVerticalListWithImpressions at index {value}`
                    }
                    if FFlagSduiErrorPaths then
                        addSduiErrorContextFields(tbl3, value2.errorContext)
                    end
                    sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, tbl3, sduiContext.appPage)
                else
                    local localAnalyticsData = {
                        itemPosition = value,
                        itemComponentType = var13,
                        componentType = var13
                    }

                    local buildAndValidateItemAnalyticsData = SduiCollectionAnalyticsBuilder.buildAndValidateItemAnalyticsData
                    local var14 = sduiContext
                    local analyticsData = value2.analyticsData
                    local var15 = nil

                    local var16 = nil
                    local errorContext = if FFlagSduiErrorPaths then value2.errorContext else nil
                    current[value] = buildAndValidateItemAnalyticsData(var14, analyticsData, var15, localAnalyticsData, var13, var16, errorContext)

                    local str1 = `Item_{value}`
                    result[str1] = React.createElement(ImpressionTaggedSduiItem, {
                        item = value2,
                        index = value,
                        debugName = tbl1.debugName,
                        impressionsTag = var11,
                        sduiContext = sduiContext,
                        collectionAnalyticsContext = collectionAnalyticsContext,
                        localAnalyticsData = localAnalyticsData,
                        scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                        verticalScrollingFrameRef = verticalScrollingFrameRef
                    })
                end
            end
        end

        var9.current = current
        return result
    end, {
        var2,
        sduiContext,
        collectionAnalyticsContext,
        componentType,
        scrollViewPositionChangedSignal,
        verticalScrollingFrameRef,
        var11,
        tbl1.debugName
    })

    local element

    if tbl1.view then
        local sduiComponentWrapper = getSduiComponentWrapper(tbl1.view)
        element = React.createElement(sduiComponentWrapper, {
            componentConfig = tbl1.view,
            sduiContext = sduiContext,
            parentAnalyticsContext = if tbl1.view.__isClientBinding then nil else collectionAnalyticsContext,
            debugName = if tbl1.debugName then `{tbl1.debugName}.View` else "View",
            extraLocalProps = {
                containerRef = containerRef,
                children = children,
                layoutOrder = tbl1.layoutOrder
            }
        })
    else
        element = React.createElement(SduiView, { containerRef = containerRef, layoutOrder = tbl1.layoutOrder }, children)
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var14 = nil
    local tbl2 = {
        Content = element,
        ImpressionDetector = if var11 then React.createElement(FrameBoundsImpressionsTracker, {
            parentRef = parentRef,
            pageContext = pageContext,
            impressionsTag = var11,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            sendImpressions = sendImpressions,
            dataUpdatedTimestamp = sduiContext.dataUpdatedTimestamp,
            respectClipAncestors = if FFlagLuaAppRespectClipAncestorImpressions then tbl1.respectClipAncestors else nil
        }) else nil
    }
    return createElement(fragment, var14, tbl2)
end)
