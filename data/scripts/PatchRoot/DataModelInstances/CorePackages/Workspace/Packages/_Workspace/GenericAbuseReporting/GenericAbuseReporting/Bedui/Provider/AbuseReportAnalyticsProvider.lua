-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.Bedui.Provider.AbuseReportAnalyticsContext)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local _BeduiAnalytics = require(GenericAbuseReporting.Bedui.Utils.BeduiAnalytics)

local function AbuseReportAnalyticsProvider(tbl1)
    local isReportSubmitted, setIsReportSubmitted = React.useState(false)

    return React.createElement(AbuseReportAnalyticsContext.Provider, {
        value = {
            abuseVector = tbl1.abuseVector,
            isReportSubmitted = isReportSubmitted,
            setIsReportSubmitted = setIsReportSubmitted
        }
    }, tbl1.children)
end

return AbuseReportAnalyticsProvider
