-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local LoggingProtocol = require(DataHydrationParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("JoinUserActionsFetchCounterThrottleHundredthsPercent", 10000)

local tbl1 = {
    eventName = "joinUserActionsFetch",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 9, 30 },
    description = "JoinUserActions request outcomes; status custom field is Success or Failed."
}

local tbl2 = { Success = true, Failed = true }

return {
    logFetchResult = function(status: string)
        if not tbl2[status] then
            return
        end

        LoggingProtocol.default:logRobloxTelemetryCounter(tbl1, nil, { status = status })
    end
}
