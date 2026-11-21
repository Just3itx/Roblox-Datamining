-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local dependencies = require(AuthCommon.dependencies)
local KeystoreEventConstants = require(script.Parent.KeystoreEventConstants)
local EventIngestService = game:GetService("EventIngestService")
local eventIngest = dependencies.Analytics.AnalyticsReporters.EventIngest.new(EventIngestService)

return {
    sendPageLoadEvent = function(origin: string, state: string?)
        eventIngest:sendEventDeferred(
            KeystoreEventConstants.ctx.keystoreLogin,
            KeystoreEventConstants.eventNames.pageLoad,
            {
                origin = origin,
                state = state or ""
            }
        )
    end
}
