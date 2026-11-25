-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        Diag = {
            reportCounter = arg1.fn(),
            reportStats = arg1.fn()
        },
        EventStream = {
            setRBXEventStream = arg1.fn(),
            sendEventDeferred = arg1.fn()
        },
        Telemetry = {
            logRobloxTelemetryCounter = arg1.fn(),
            logRobloxTelemetryEvent = arg1.fn(),
            logRobloxTelemetryStat = arg1.fn(),
            TelemetryBackends = {
                Points = "Points",
                Stats = "RobloxTelemetryStat",
                Counters = "RobloxTelemetryCounter",
                EventIngest = "EventIngest"
            }
        }
    }
end
