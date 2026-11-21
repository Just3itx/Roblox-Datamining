-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EdpStoreAnalytics = script:FindFirstAncestor("EdpStoreAnalytics")
local EdpStoreAnalyticsParent = EdpStoreAnalytics.Parent
local React = require(EdpStoreAnalyticsParent.React)
local AppCommonLib = require(EdpStoreAnalyticsParent.AppCommonLib)
local Constants = require(EdpStoreAnalytics.Constants)
local EdpStoreAnalyticsLogger = require(EdpStoreAnalytics.EdpStoreAnalyticsLogger)
local Signal = AppCommonLib.Signal
local ScreenSizeImpressionsDetector = require(EdpStoreAnalyticsParent.Impressions).ScreenSizeImpressionsDetector

return function(tbl1)
    local var1 = React.useRef(Signal.new())
    local var2 = React.useRef(false)

    React.useEffect(function()
        if tbl1.scrollViewPositionChangedSignal.current then
            tbl1.scrollViewPositionChangedSignal.current:connect(function()
                var1.current:fire()
            end)
        end
    end, { tbl1.scrollViewPositionChangedSignal })

    local onImpressionsDetected = React.useCallback(function(tbl2)
        if #tbl2 == 0 or var2.current or tbl1.parameters == nil then
            return
        end

        var2.current = true

        local var3 = tbl2[1]
        local tbl3 = {
            universeId = tonumber(tbl1.parameters.universeId),
            productType = tbl1.parameters.productType,
            actionType = Constants.StoreEnums.ActionType.Impression,
            locationType = tbl1.parameters.locationType,
            layoutOrder = tonumber(var3)
        }
        EdpStoreAnalyticsLogger.logImpression(tbl3)
        EdpStoreAnalyticsLogger.logExperienceStoreExposure()
    end, { tbl1.parameters })

    return React.createElement(ScreenSizeImpressionsDetector, {
        parentRef = tbl1.parentRef,
        onRequestImpressionsSignal = var1.current,
        onImpressionsDetected = onImpressionsDetected,
        impressionsTag = tbl1.impressionsTag
    })
end
