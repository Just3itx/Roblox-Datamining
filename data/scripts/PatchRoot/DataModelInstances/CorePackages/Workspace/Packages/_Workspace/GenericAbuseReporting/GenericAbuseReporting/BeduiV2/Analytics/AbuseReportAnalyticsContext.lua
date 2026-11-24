-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local _analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)

local AbuseReportAnalyticsContext = React.createContext(nil)

return {
    AbuseReportAnalyticsContext = AbuseReportAnalyticsContext,
    AbuseReportAnalyticsProvider = function(tbl1)
        return React.createElement(AbuseReportAnalyticsContext.Provider, { value = tbl1.analytics }, tbl1.children)
    end,
    useAbuseReportAnalytics = function()
        local var1 = React.useContext(AbuseReportAnalyticsContext)

        if not var1 then
            error(
                "Invalid use of `useAbuseReportAnalytics` hook. Ensure your component has an ancestor wrapped in `AbuseReportAnalyticsProvider`"
            )
        end

        return var1
    end,
    useOptionalAbuseReportAnalytics = function()
        return React.useContext(AbuseReportAnalyticsContext)
    end
}
