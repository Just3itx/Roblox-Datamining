-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local EventIngestService = game:GetService("EventIngestService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local Analytics = dependencies.Analytics
local analytics = Analytics.Analytics.new(RbxAnalyticsService)
local getPlatformTarget = Analytics.getPlatformTarget

return {
    Diag = analytics.Diag,
    EventStream = {
        setRBXEventStream = function(_, eventContext: string, eventName: string, tbl1)
            EventIngestService:SetRBXEventStream(getPlatformTarget(), eventContext, eventName, tbl1 or {})
        end
    }
}
