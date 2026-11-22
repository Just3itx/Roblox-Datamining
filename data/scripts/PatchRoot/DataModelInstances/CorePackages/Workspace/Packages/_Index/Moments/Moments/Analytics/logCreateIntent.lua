-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Analytics = require(MomentsParent.MomentsCommon).Analytics
local FunnelEventNames = Analytics.FunnelEventNames

local function logCreateIntent(source: string)
    local creationSessionId = Analytics.SessionManager.startSession(FunnelEventNames.FunnelTypes.CreationFlow)
    Analytics.fireFunnelAnalyticsEvent(
        FunnelEventNames.FunnelTypes.CreationFlow,
        FunnelEventNames.CreationFlowSteps.CreateIntent,
        creationSessionId,
        { source = source }
    )

    local tbl1 = { source = source }
    tbl1.creationSessionId = creationSessionId
    Analytics.fireAnalyticsEvent(Analytics.EventNames.MomentCreationStarted, tbl1)
    Analytics.reportMomentsCreationStep("create_intent")
end

return logCreateIntent
