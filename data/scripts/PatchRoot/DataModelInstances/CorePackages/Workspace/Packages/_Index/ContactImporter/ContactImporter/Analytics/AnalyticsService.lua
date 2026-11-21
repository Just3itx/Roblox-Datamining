-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:30Z
-- Luau bytecode version: 14 | Luau type version: 3
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent
local EventIngestService = game:GetService("EventIngestService")

local var1 = require(ContactImporterParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService"))
return {
    EventStream = {
        setRBXEventStream = require(script.Parent.setupSetRbxEventStream)(EventIngestService)
    },
    Diag = var1.Diag
}
