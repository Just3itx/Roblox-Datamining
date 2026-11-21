-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoverabilityModalParent = script:FindFirstAncestor("DiscoverabilityModal").Parent
local EventIngestService = game:GetService("EventIngestService")

local var1 = require(DiscoverabilityModalParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService"))
return {
    EventStream = {
        setRBXEventStream = require(script.Parent.setupSetRbxEventStream)(EventIngestService)
    },
    Diag = var1.Diag
}
