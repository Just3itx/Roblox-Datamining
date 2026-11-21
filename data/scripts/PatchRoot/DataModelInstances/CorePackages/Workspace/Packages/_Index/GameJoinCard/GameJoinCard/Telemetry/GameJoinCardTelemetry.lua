-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:00:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local LoggingProtocol = require(GameJoinCardParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("MobileGameJoinCardBannerLoadCounterThrottleHundredthsPercent", 10000)

local tbl1 = {
    eventName = "mobileGameJoinCardBannerLoad",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 5, 14 },
    description = "MobileGameJoinCard banner image resolution outcomes; status custom field is one of Success / NotFound / Fallback / Failed."
}

local tbl2 = { Success = true, NotFound = true, Fallback = true, Failed = true }

local num1 = game:DefineFastInt("GameJoinCardActionsResolveStatThrottleHundredthsPercent", 10000)

local tbl3 = {
    eventName = "gameJoinCardActionsResolve",
    backends = { LoggingProtocol.TelemetryBackends.Stats },
    throttlingPercentage = num1,
    lastUpdated = { 2026, 10, 5 },
    links = "",
    description = "Milliseconds a visible join card waited on JoinUserActions. status is Ready or Failed. surface is mobile or desktop."
}

local tbl4 = { Ready = true, Failed = true }

return {
    logBannerLoadResult = function(status: string)
        if not tbl2[status] then
            return
        end

        LoggingProtocol.default:logRobloxTelemetryCounter(tbl1, nil, { status = status })
    end,
    logActionsResolved = function(num3: number, status: string, surface: string)
        if not tbl4[status] then
            return
        end

        LoggingProtocol.default:logRobloxTelemetryStat(
            tbl3,
            math.max(0, math.floor(num3)),
            { status = status, surface = surface }
        )
    end
}
