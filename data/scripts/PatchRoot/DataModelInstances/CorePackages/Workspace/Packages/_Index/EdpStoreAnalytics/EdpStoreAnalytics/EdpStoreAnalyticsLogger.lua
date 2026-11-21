-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local IXPService = game:GetService("IXPService")

local EdpStoreAnalytics = script:FindFirstAncestor("EdpStoreAnalytics")
local EdpStoreAnalyticsParent = EdpStoreAnalytics.Parent

local AppUserLayers = require(EdpStoreAnalyticsParent.ExperimentLayers).AppUserLayers
local Constants = require(EdpStoreAnalytics.Constants)

local FFlagEnableDynamicEdpStorePreviewExposureLogging = require(EdpStoreAnalytics.Flags.FFlagEnableDynamicEdpStorePreviewExposureLogging)
local FStringEdpStorePreviewIXPLayersCommaSeparated = require(EdpStoreAnalytics.Flags.FStringEdpStorePreviewIXPLayersCommaSeparated)

local throttlingPercentage = game:DefineFastInt("EdpStoreClicksDetectorThrottlingHundredthsPercent", 0)

local num1 = game:DefineFastInt("EdpStoreImpressionsDetectorThrottlingHundredthsPercent", 0)

local module = {}

local function sendLogEvent(customFields)
    TelemetryService:LogEvent({
        eventName = "experienceStoreProducts",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 10, 23 },
        description = "Event fired from the lua app for click events on the EDP store"
    }, { customFields = customFields })
end

local function sendImpressionLogEvent(customFields)
    local config = {
        eventName = Constants.ExperienceStoreEventName,
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 25, 10, 23 },
        description = "Event fired from the lua app for every impression on the EDP store or preview"
    }

    TelemetryService:LogEvent(config, { customFields = customFields })
end

function module.logEvent(actionType: string, productType: string, locationType: string?, universeId: number?, productId: number?, itemId: string?, _)
    sendLogEvent({
        actionType = actionType,
        productType = productType,
        locationType = locationType,
        universeId = universeId,
        productId = productId,
        itemId = itemId
    })
end

function module.logImpression(customFields)
    sendImpressionLogEvent(customFields)
end

function module.logExperienceStoreExposure()
    if not FFlagEnableDynamicEdpStorePreviewExposureLogging then
        IXPService:LogUserLayerExposure(AppUserLayers.EconomyDeveloperMonetizationEdpVirtualProductsRanking)
        return
    end

    for _, value in string.split(FStringEdpStorePreviewIXPLayersCommaSeparated, ",") do
        local layerName = string.match(value, "^%s*(.-)%s*$")
        if layerName ~= nil and layerName ~= "" then
            IXPService:LogUserLayerExposure(layerName)
        end
    end
end

return module
