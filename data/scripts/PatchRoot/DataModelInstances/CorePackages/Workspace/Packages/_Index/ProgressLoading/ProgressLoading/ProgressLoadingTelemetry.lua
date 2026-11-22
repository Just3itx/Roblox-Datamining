-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local TelemetryService = game:GetService("TelemetryService")

local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local default = require(ProgressLoadingParent.LoggingProtocol).default

local throttlingPercentage = game:DefineFastInt("ProgressLoadingTelemetryThrottleHundredthsPercent", 10000)

local config = {
    eventName = "progress_loading_assets_activated",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 4, 8 },
    description = "Counter for deferred asset loading screen activations"
}

local config2 = {
    eventName = "progress_loading_assets_deactivated",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 4, 8 },
    description = "Counter for deferred asset loading screen deactivations"
}

local config3 = {
    eventName = "progress_loading_assets_duration_ms",
    backends = { "RobloxTelemetryStat" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 4, 8 },
    description = "Duration in ms that the deferred asset loading screen was shown"
}

local var1 = nil

local module = {}

function module.logLoadingAssetsActivated()
    var1 = os.clock()
    TelemetryService:LogCounter(config, {}, 1)
    default:logEvent("progress_loading_assets_activated")
end

function module.logLoadingAssetsDeactivated()
    assert(var1 ~= nil, "logLoadingAssetsDeactivated called without a prior logLoadingAssetsActivated")
    local num2 = math.floor((os.clock() - var1) * 1000)
    var1 = nil
    TelemetryService:LogCounter(config2, {}, 1)
    TelemetryService:LogStat(config3, {}, num2)
    default:logEvent("progress_loading_assets_deactivated")
end

return module
