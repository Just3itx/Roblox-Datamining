-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("SocialLinksImpressionsEventHundredthsPercent", 10000)

local var1 = t.strictInterface({
    item_positions = t.string,
    social_link_urls = t.string,
    social_link_types = t.string,
    social_link_display_type = t.string,
    assignment_id = t.number,
    assignment_type = t.string,
    page = t.string
})

local config = {
    eventName = "EdpSocialLinksImpressions",
    description = "Impressions for social links on EDP",
    lastUpdated = { 25, 12, 10 },
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage
}

return function(customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("SocialLinksImpressionsEventInterface", var3)
    end

    TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = { "addSessionInfo" } })
end
