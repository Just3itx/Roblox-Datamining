-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local ArgCheck = require(ServerDrivenUiParent.ArgCheck)
local OmniFeedPropsKey = require(ServerDrivenUiParent.DiscoveryTypes).OmniFeedPropsKey
local SduiFeatureEntryPoint = require(ServerDrivenUiParent.SduiSharedUtilities).SduiFeatureEntryPoint

local FIntLuaAppDelayImpressionsMaxUpdates = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppDelayImpressionsMaxUpdates

local SduiV2OmniFeedConstants = require(ServerDrivenUi.Migration.SduiV2OmniFeedConstants)

return React.memo(function(tbl1) -- name: SduiV2OmniFeedItem
    local var1 = tbl1[OmniFeedPropsKey]
    local appPage = var1.appPage
    ArgCheck.assert(appPage ~= nil, "appPage must exist")
    ArgCheck.assert(tbl1.sortIndex ~= nil, "sortIndex must exist")
    ArgCheck.assert(
        not (tbl1.feedItemKey == nil) and tbl1.feedItemKey ~= "",
        "feedItemKey must exist for V2 SDUI omni feed item"
    )

    local additionalAnalyticsData = React.useMemo(function()
        return {
            collectionPosition = tbl1.sortIndex
        }
    end, { tbl1.sortIndex })

    local extraLocalProps = React.useMemo(function()
        return {
            scrollViewPositionChangedSignal = var1.scrollViewPositionChangedSignal,
            verticalScrollingFrameRef = var1.verticalScrollingFrameRef,
            startRow = var1.feedItemStartRow,
            numUpdatesToDelayImpressions = FIntLuaAppDelayImpressionsMaxUpdates,
            selectionOrderBase = var1.selectionOrderBase,
            videoPlaybackContext = var1.videoPlaybackContext,
            index = tbl1.sortIndex,
            collectionPosition = tbl1.sortIndex
        }
    end, {
        var1.scrollViewPositionChangedSignal,
        var1.verticalScrollingFrameRef,
        var1.feedItemStartRow,
        var1.selectionOrderBase,
        var1.videoPlaybackContext,
        tbl1.sortIndex
    })

    return React.createElement(SduiFeatureEntryPoint, {
        appPage = appPage,
        configKey = SduiV2OmniFeedConstants.HomeConfigKey,
        identifier = tbl1.feedItemKey,
        additionalAnalyticsData = additionalAnalyticsData,
        extraLocalProps = extraLocalProps,
        appCompositionEnabledOverride = var1.appCompositionEnabled == true,
        LayoutOrder = tbl1.sortIndex,
        shouldDisplayError = false,
        shouldDisplayLoading = false
    })
end)
