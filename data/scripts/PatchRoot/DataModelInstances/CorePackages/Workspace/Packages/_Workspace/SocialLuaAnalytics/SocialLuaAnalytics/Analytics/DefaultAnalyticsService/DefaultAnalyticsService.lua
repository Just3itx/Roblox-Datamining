-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent
local LoggingProtocol = require(SocialLuaAnalyticsParent.LoggingProtocol)
local EventIngestService = game:GetService("EventIngestService")

local var1 = require(SocialLuaAnalyticsParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService"))
local setupSetRbxEventStream = require(script.Parent.setupSetRbxEventStream)
local setupSendEventDeferred = require(script.Parent.setupSendEventDeferred)
local default = LoggingProtocol.default

return {
    EventStream = {
        setRBXEventStream = setupSetRbxEventStream(EventIngestService),
        sendEventDeferred = setupSendEventDeferred(EventIngestService)
    },
    Diag = var1.Diag,
    Telemetry = default
}
