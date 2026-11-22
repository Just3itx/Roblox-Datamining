-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local TelemetryService = game:GetService("TelemetryService")

local QueueExperimentation = require(ProgressLoadingParent.SocialExperiments).QueueExperimentation
local var1 = QueueExperimentation.getIsJoinNewServerButtonEnabled() or QueueExperimentation.getIsAutoJoinNewServerEnabled()

local standardizedFields = { "addPlaceId", "addUniverseId", "addOSInfo" }
local config = {
    eventName = "loadingScreenQueuedStateButtonClick",
    backends = { "EventIngest" },
    throttlingPercentage = require(ProgressLoadingParent.SharedFlags).FIntLoadingScreenQueuedStateButtonClickThrottleHundredthsPercent,
    lastUpdated = { 2026, 4, 8 },
    description = "Event fired when the user clicks a queued-state action button on the loading screen.",
    links = "https://docs.google.com/document/d/1vbUe9xu9Hi6P7wpRpBC3jKHLXel03wCB-ezb9eJFCBc/edit?usp=sharing"
}

return {
    countPlayerLocalizationChoiceNotReady = function()
        TelemetryService:LogCounter({
            eventName = "PlayerLocalizationChoiceNotReady",
            backends = { "RobloxTelemetryCounter" },
            lastUpdated = { 2026, 2, 24 },
            description = "Counter to track when the auto translate badge doesn't mount before the API response arrived.",
            links = "https://grafana.rbx.com/goto/cfe9j31p1wge8a?orgId=1"
        }, { standardizedFields = standardizedFields }, 1)
    end,
    countPlayerLocalizationChoiceFailed = function(tbl2)
        TelemetryService:LogCounter({
            eventName = "PlayerLocalizationChoiceFailed",
            backends = { "RobloxTelemetryCounter" },
            lastUpdated = { 2026, 2, 24 },
            description = "Counter to track when the player localization choice API returns an error.",
            links = "https://grafana.rbx.com/goto/cfe9j31p1wge8a?orgId=1"
        }, {
            standardizedFields = standardizedFields,
            customFields = {
                responseCode = tbl2.responseCode,
                errorType = tbl2.errorType
            }
        }, 1)
    end,
    countAutoTranslateZeroUniverseId = function()
        TelemetryService:LogCounter({
            eventName = "AutoTranslateZeroUniverseId",
            backends = { "RobloxTelemetryCounter" },
            lastUpdated = { 2026, 3, 11 },
            description = "Counter to track when AutoTranslateBadge skips the API request because universeId is 0.",
            links = "https://grafana.rbx.com/goto/cfe9j31p1wge8a?orgId=1"
        }, { standardizedFields = standardizedFields }, 1)
    end,
    logQueuedStateButtonClick = function(customFields)
        if var1 then
            TelemetryService:LogEvent(config, { customFields = customFields or {} })
        end
    end
}
