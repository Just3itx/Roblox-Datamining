-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalytics = script:FindFirstAncestor("SocialLuaAnalytics")

local _telemetryNewConfig = require(script.Parent.telemetryNewConfig)
local fireTelemetry = require(SocialLuaAnalytics.Analytics.FireEvent.fireTelemetry)

local function telemetrySetup(tbl1)
    local shouldUseTelemetryService = tbl1.shouldUseTelemetryService == nil or tbl1.shouldUseTelemetryService

    local function emitTelemetry(arg1, arg2)
        return fireTelemetry({
            telemetryImpl = tbl1.telemetryImpl,
            eventList = {
                defaults = tbl1.defaultTelemetryConfig,
                [arg1.name] = arg1
            },
            loggerImpl = tbl1.loggerImpl,
            shouldUseTelemetryService = shouldUseTelemetryService,
            telemetryServiceImpl = tbl1.telemetryServiceImpl
        })(
            arg1.name,
            arg2,
            not tbl1.getSharedInfo and {} or tbl1.getSharedInfo(),
            arg1.eventStreamCtx
        )
    end

    return {
        emit = emitTelemetry,
        fireAnalyticsEvent = emitTelemetry,
        getSharedInfo = tbl1.getSharedInfo
    }
end

return telemetrySetup
