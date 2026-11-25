-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local ArgCheck = require(ServerDrivenUiParent.ArgCheck)
local React = require(ServerDrivenUiParent.React)
local tutils = require(ServerDrivenUiParent.tutils)
local useSelector = require(ServerDrivenUiParent.RoactUtils).Hooks.RoactRodux.useSelector

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiComponentType = SduiCoreSystem.SduiComponentType
local SduiConfigReducer = require(ServerDrivenUi.Rodux.SduiConfigReducer)
local SduiComponent = SduiCoreSystem.SduiComponent
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParsers = SduiCoreSystem.SduiParsers
local useSduiContext = require(ServerDrivenUi.System.useSduiContext)
local useCollectionLayoutConfig = require(ServerDrivenUiParent.CollectionViews).useCollectionLayoutConfig

local FIntLuaAppDelayImpressionsMaxUpdates = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppDelayImpressionsMaxUpdates
local FFlagLuaAppLayoutParamsInContext = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppLayoutParamsInContext

return React.memo(function(tbl1) -- name: SduiSeeAllGrid
    local layoutOrder = tbl1.layoutOrder

    local verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef
    local scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal

    ArgCheck.assert(tbl1.collectionId ~= nil, "collectionId id must exist")
    ArgCheck.assert(tbl1.collectionIndex ~= nil, "collectionIndex id must exist")

    local var1 = useSelector(function(arg1)
        local result = {}
        local var1 = arg1.Personalization[SduiConfigReducer.key][tbl1.appPage]
        if var1 then
            for _, feedItemData in var1.itemCollections do
                local analyticsData = feedItemData.sduiConfig.analyticsData
                if tostring(tbl1.collectionId) == tostring(analyticsData.collectionId) then
                    result.feedItemData = feedItemData
                    break
                end
            end

            result.templates = var1.rootConfig and var1.rootConfig.templates or nil
        end

        return result
    end, tutils.shallowEqual)

    local var2 = if FFlagLuaAppLayoutParamsInContext then useCollectionLayoutConfig(tbl1.contentFrame, 0) else nil
    local var3 = useSduiContext
    local tbl2 = {
        appPage = tbl1.appPage,
        templates = var1.templates,
        dataUpdatedTimestamp = var1.feedItemData and var1.feedItemData.dataUpdatedTimestamp,
        pageLayoutConfig = 0
    }

    if not FFlagLuaAppLayoutParamsInContext then
        var2 = nil
    end

    tbl2.pageLayoutConfig = var2
    local sduiContext = var3(tbl2)

    local feedItemData = var1.feedItemData

    local componentConfig = React.useMemo(function()
        if not (feedItemData and feedItemData.sduiConfig) then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentConfig, {
                name = "SduiSeeAllGrid",
                message = `Missing component config client-driven SDUI grid for see-all. CollectionId: {tbl1.collectionId}`
            }, sduiContext.appPage)
            return nil
        end

        if not feedItemData.sduiConfig.props then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.InvalidComponentConfig, {
                name = "SduiSeeAllGrid",
                message = `Missing props for component config for client-driven SDUI grid for see-all. CollectionId: {tbl1.collectionId}`
            }, sduiContext.appPage)
            return nil
        end

        local sduiConfig = feedItemData.sduiConfig
        local itemHeightFromWidth

        if sduiConfig.props.items and #sduiConfig.props.items > 0 and sduiConfig.props.itemHeightFromWidth == nil then
            local item = sduiConfig.props.items[1]
            if sduiConfig.props.itemTemplateKey and item.templateKey == nil then
                item.templateKey = sduiConfig.props.itemTemplateKey
            end
            if not SduiBuilder.getComponentType(item, sduiContext) then
                sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, {
                    name = "SduiSeeAllGrid",
                    message = `Missing componentType for first item. CollectionId: {tbl1.collectionId}`
                }, sduiContext.appPage)
                return nil
            end

            local var5 = nil
            if item then
                local var6 = item.props and item.props.imageAspectRatio and SduiParsers.safeParseNumber(item.props.imageAspectRatio, sduiContext, {})
                if var6 and var6 > 0 then
                    var5 = 1 / var6
                end
            end

            local scale = var5
                or (if sduiConfig.props.collectionItemSize == "Medium" or sduiConfig.props.collectionItemSize == "Large" then 0.5625 else 1)
            local offset = if item then (item.props and item.props.titleLines or 1) * 20 + 20 + 8 else nil
            itemHeightFromWidth = UDim.new(scale, offset)
        else
            itemHeightFromWidth = sduiConfig.props.itemHeightFromWidth
        end

        return {
            componentType = SduiComponentType.CollectionGrid,
            props = {
                items = sduiConfig.props.items,
                impressionEventName = sduiConfig.props.impressionEventName,
                skipItemImpressionsLog = sduiConfig.props.skipItemImpressionsLog,
                collectionItemSize = sduiConfig.props.collectionItemSize,
                itemTemplateKey = sduiConfig.props.itemTemplateKey,
                itemHeightFromWidth = itemHeightFromWidth
            },
            analyticsData = sduiConfig.analyticsData
        }
    end, { feedItemData and feedItemData.sduiConfig, sduiContext })

    return (React.useMemo(function()
        if componentConfig == nil then
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentConfig, {
                name = "SduiSeeAllGrid",
                message = `Unable to generate component config for client-driven SDUI grid for see-all. CollectionId: {tbl1.collectionId}`
            }, sduiContext.appPage)
            return nil
        end
        return React.createElement(SduiComponent, {
            debugName = "SeeAllGrid",
            componentConfig = componentConfig,
            sduiContext = sduiContext,
            extraLocalProps = {
                dataUpdatedTimestamp = feedItemData.dataUpdatedTimestamp,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = verticalScrollingFrameRef,
                index = tbl1.collectionIndex,
                collectionPosition = tbl1.collectionIndex,
                pageSideMargin = 0,
                startRow = 1,
                numUpdatesToDelayImpressions = FIntLuaAppDelayImpressionsMaxUpdates,
                layoutOrder = layoutOrder,
                layoutOverrides = not FFlagLuaAppLayoutParamsInContext
                    and {
                        sideMargin = 0,
                        fractionalItemAmount = 0,
                        overrideLoadMoreThreshold = math.huge
                    }
                    or nil,
                disableImpressionsDetector = true,
                impressionsTag = tbl1.impressionsTag,
                setLogImpressions = tbl1.setLogImpressions,
                sendGameImpressions = tbl1.sendGameImpressions,
                onCollectionViewabilityChanged = tbl1.onCollectionViewabilityChanged
            },
            localAnalyticsData = {
                collectionPosition = tbl1.collectionIndex,
                seeAllFlag = 1
            }
        })
    end, {
        componentConfig,
        layoutOrder,
        feedItemData and feedItemData.dataUpdatedTimestamp or nil,
        1,
        tbl1.collectionId,
        tbl1.collectionIndex,
        scrollViewPositionChangedSignal,
        verticalScrollingFrameRef,
        sduiContext,
        tbl1.impressionsTag,
        tbl1.setLogImpressions,
        tbl1.sendGameImpressions,
        tbl1.onCollectionViewabilityChanged
    }))
end)
