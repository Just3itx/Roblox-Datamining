-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local standardizedFields = {
    "addPlaceId",
    "addUniverseId",
    "addSessionId",
    "addOSInfo",
    "addSessionInfo"
}
local tbl1 = { "addPlaceId", "addUniverseId", "addOSInfo" }

local config = {
    eventName = "InExperienceClickoutToggled",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("InExperienceClickoutToggledTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 1, 28 },
    description = "        This is fired when the in-experience clickout webview is opened or closed.\n\t\thttps://github.rbx.com/Roblox/proto-schemas/pull/9488\n    "
}

local config2 = {
    eventName = "InExperienceClickoutToggledCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 28 },
    description = "\t\tCounter for InExperienceClickoutToggled events.\n\t"
}

local module = {}

function module.logWebviewToggled(bool1: boolean, flowId: string, targetUrl: string)
    local customFields = {
        is_opened = tostring(bool1),
        flow_id = flowId,
        target_url = targetUrl
    }

    TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(config2, { standardizedFields = tbl1, customFields = { is_opened = tostring(bool1) } }, 1)
end

return module
