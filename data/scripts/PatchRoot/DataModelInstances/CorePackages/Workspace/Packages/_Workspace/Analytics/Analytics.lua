-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    Analytics = require(script.Analytics),
    AnalyticsReporters = require(script.AnalyticsReporters),
    getPlatformTarget = require(script.getPlatformTarget),
    ReportToDiagByCountryCode = require(script.ReportToDiagByCountryCode),
    RequestTimeDiag = require(script.RequestTimeDiag),
    Events = {
        pageHeartbeat = require(script.Events.pageHeartbeat),
        userInteractions = require(script.Events.userInteractions)
    }
}
