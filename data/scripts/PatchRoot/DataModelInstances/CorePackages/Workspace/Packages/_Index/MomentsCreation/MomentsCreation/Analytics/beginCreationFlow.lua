-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Analytics = require(MomentsCreationParent.MomentsCommon).Analytics
local FunnelEventNames = Analytics.FunnelEventNames

local function beginCreationFlow(source: string)
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
end

return beginCreationFlow
