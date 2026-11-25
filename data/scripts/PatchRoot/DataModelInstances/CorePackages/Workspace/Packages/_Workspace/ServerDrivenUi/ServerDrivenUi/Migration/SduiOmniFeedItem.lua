-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local ArgCheck = require(ServerDrivenUiParent.ArgCheck)
local React = require(ServerDrivenUiParent.React)
local OmniFeedPropsKey = require(ServerDrivenUiParent.DiscoveryTypes).OmniFeedPropsKey
local usePageSideMargin = require(ServerDrivenUiParent.CollectionViews).usePageSideMargin
local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

local FIntLuaAppDelayImpressionsMaxUpdates = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppDelayImpressionsMaxUpdates
local FFlagLuaAppCompositionAlways = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppCompositionAlways

local num1 = game:DefineFastInt("SduiOmniFeedItemLogDelayMs", 500) / 1000

local useSduiItemCollectionSignal = require(ServerDrivenUi.DataStore.useSduiItemCollectionSignal)

return React.memo(function(tbl1) -- name: SduiOmniFeedItem
    local appPage = tbl1[OmniFeedPropsKey].appPage
    local feedItemStartRow = tbl1[OmniFeedPropsKey].feedItemStartRow
    local verticalScrollingFrameRef = tbl1[OmniFeedPropsKey].verticalScrollingFrameRef
    local scrollViewPositionChangedSignal = tbl1[OmniFeedPropsKey].scrollViewPositionChangedSignal
    local sduiContext = tbl1[OmniFeedPropsKey].sduiContext
    local selectionOrderBase = tbl1[OmniFeedPropsKey].selectionOrderBase
    local appCompositionEnabled = if FFlagLuaAppCompositionAlways then true else tbl1[OmniFeedPropsKey].appCompositionEnabled

    ArgCheck.assert(appPage ~= nil, "appPage must exist")
    ArgCheck.assert(tbl1.topicId ~= nil, "topicId id must exist")
    ArgCheck.assert(tbl1.sortIndex ~= nil, "sortIndex id must exist")

    local var2 = React.useRef(false)
    React.useEffect(function()
        var2.current = true
        return function()
            var2.current = false
        end
    end, {})

    local var3 = if FFlagLuaAppCompositionAlways then nil else usePageSideMargin(verticalScrollingFrameRef.current)

    local var4 = React.useMemo(function()
        if appPage == AppPage.SearchPage and tbl1.searchUuid then
            return `{appPage}_{tbl1.searchUuid}`
        end

        return nil
    end, { appPage, tbl1.searchUuid })
    local var5 = useSduiItemCollectionSignal(appPage, tbl1.topicId, tbl1.sortIndex, var4)

    local sduiConfig = var5 and var5.sduiConfig or nil
    local localAnalyticsData = React.useMemo(function()
        return {
            collectionPosition = tbl1.sortIndex
        }
    end, { tbl1.sortIndex })
    local str1 = `SduiOmniFeedItem-{tbl1.topicId}`

    local var7 = React.useRef(sduiConfig)
    var7.current = sduiConfig
    if sduiConfig == nil then
        task.delay(num1, function()
            if var2.current and var7.current == nil then
                sduiContext.dependencies.logger.reportError(
                    SduiErrors.SduiErrorType.NilComponentConfig,
                    {
                        name = str1,
                        message = `Unable to render omni feed item for sdui. CollectionId: {tbl1.topicId}`
                    },
                    sduiContext.appPage
                )
            end
        end)
    end
    return (React.useMemo(function()
        if sduiConfig == nil then
            return nil
        end
        local sduiComponentWrapper = getSduiComponentWrapper(sduiConfig)
        return React.createElement(sduiComponentWrapper, {
            debugName = str1,
            componentConfig = sduiConfig,
            sduiContext = sduiContext,
            extraLocalProps = {
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = verticalScrollingFrameRef,
                index = tbl1.sortIndex,
                collectionPosition = tbl1.sortIndex,
                pageSideMargin = if appCompositionEnabled then nil else var3,
                startRow = feedItemStartRow,
                numUpdatesToDelayImpressions = FIntLuaAppDelayImpressionsMaxUpdates,
                selectionOrderBase = selectionOrderBase,
                appCompositionEnabled = appCompositionEnabled
            },
            localAnalyticsData = localAnalyticsData
        })
    end, {
        sduiConfig,
        str1,
        localAnalyticsData,
        feedItemStartRow,
        var3,
        tbl1.topicId,
        tbl1.sortIndex,
        scrollViewPositionChangedSignal,
        verticalScrollingFrameRef,
        sduiContext,
        selectionOrderBase
    }))
end)
