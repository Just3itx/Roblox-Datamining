-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)

local ScreenSizeImpressionsTracker = require(SduiSharedContentParent.Impressions).ScreenSizeImpressionsTracker

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local sendSduiFeedImpressions = require(SduiSharedContentParent.UnifiedLogging).sendSduiFeedImpressions

local function SduiFeedImpressionsDetector(tbl1)
    local var1 = React.useRef(tbl1.feedItems)
    var1.current = tbl1.feedItems
    local sduiContext = tbl1.sduiContext

    local sendImpressions = React.useCallback(function(tbl2)
        if not tbl2 or #tbl2 == 0 then
            return
        end

        local current = var1.current

        local tbl3 = {}
        local tbl4 = {}
        local tbl5 = {}

        for _, value in tbl2 do
            if value <= 0 then
                continue
            end

            local var2 = current and current[value]
            if var2 == nil then
                sduiContext.dependencies.logger.reportError(SduiErrorType.FailedToLogFeedImpressions, {
                    name = "SduiFeedImpressionsDetector",
                    message = `feed item index {value} detected with no matching componentConfig`
                }, sduiContext.appPage)
            else
                local var3 = findAnalyticsField("componentType", var2.analyticsData) or SduiBuilder.getComponentType(var2, sduiContext) or "unknown"

                local analyticsField = findAnalyticsField("collectionId", var2.analyticsData)
                local str1 = if analyticsField == nil then "" else tostring(analyticsField)

                table.insert(tbl3, value)
                table.insert(tbl4, str1)
                table.insert(tbl5, tostring(var3))
            end
        end
        if #tbl3 > 0 then
            sendSduiFeedImpressions(tbl3, tbl4, tbl5, sduiContext.appPage)
        end
    end, { sduiContext })

    return React.createElement(ScreenSizeImpressionsTracker, {
        pageContext = sduiContext.routeName or sduiContext.appPage,
        parentRef = tbl1.parentRef,
        impressionsTag = tbl1.impressionsTag,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        sendImpressions = sendImpressions,
        dataUpdatedTimestamp = sduiContext.dataUpdatedTimestamp
    })
end

return SduiFeedImpressionsDetector
