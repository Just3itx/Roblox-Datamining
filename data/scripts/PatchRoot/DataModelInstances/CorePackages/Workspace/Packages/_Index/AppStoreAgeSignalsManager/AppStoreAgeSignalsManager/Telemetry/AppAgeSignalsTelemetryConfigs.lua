-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local bool1 = game:DefineFastFlag("EnableAppAgeSignalsErrorTelemetry", false)

local tbl1 = {
    ErrorCounter = {
        eventName = "AppAgeSignalsErrorCounter",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 3, 4 },
        description = "Error counter for app age signals collection flow"
    },
    ErrorEvent = {
        eventName = "AppAgeSignalsError",
        backends = { "EventIngest" },
        throttlingPercentage = 10000,
        lastUpdated = { 2026, 3, 4 },
        description = "Error event for app age signals collection flow"
    }
}

local module = {}

function module.reportError(tbl2)
    if not bool1 then
        return
    end

    TelemetryService:LogCounter(
        tbl1.ErrorCounter,
        {
            customFields = {
                error = tbl2.error,
                signalSource = tbl2.signalSource
            }
        },
        1
    )
    TelemetryService:LogEvent(tbl1.ErrorEvent, {
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            error = tbl2.error,
            signalSource = tbl2.signalSource
        }
    })
end

return module
