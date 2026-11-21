-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local flaggedMutedError = require(DiscoveryAnalyticsParent.Loggers).flaggedMutedError
local t = require(DiscoveryAnalyticsParent.t)
local throttlingPercentage = if require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppAddSocialLinkClickTelemetryToEdp then game:DefineFastInt("SocialLinkClickTelemetryThrottlePermyriad", 0) else nil
local var2 = t.strictInterface({
    assignment_id = t.number,
    assignment_type = t.string,
    social_link_type = t.string,
    social_link_url = t.string,
    social_link_display_type = t.string
})

local config = {
    eventName = "socialLinkClickEvent",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 12, 9 },
    description = "Event fired from the client every time a social link is clicked",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/usercommunities/social_link_click_event.proto"
}

return function(customFields)
    local var3, var4 = var2(customFields)
    if not var3 then
        flaggedMutedError("SocialLinkClickEventInterface", var4)
    end

    TelemetryService:LogEvent(config, { standardizedFields = { "addSessionInfo" }, customFields = customFields })
end
