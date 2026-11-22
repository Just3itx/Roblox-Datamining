-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local EventIngestService = game:GetService("EventIngestService")

local var1 = require(ProfileQRCodeParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService"))
return {
    EventStream = {
        setRBXEventStream = require(script.Parent.setupSetRbxEventStream)(EventIngestService)
    },
    Diag = var1.Diag
}
