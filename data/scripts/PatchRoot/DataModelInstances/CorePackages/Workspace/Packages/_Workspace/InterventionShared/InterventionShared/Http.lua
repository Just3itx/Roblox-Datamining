-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

return {
    GetModerationDetail = require(InterventionSharedParent.UniversalFeatureRestrictions.GetModerationDetail),
    PostDismissIntervention = require(script.PostDismissIntervention)
}
