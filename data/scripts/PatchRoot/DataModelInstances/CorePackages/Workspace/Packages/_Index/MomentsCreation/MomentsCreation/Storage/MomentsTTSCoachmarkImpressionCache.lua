-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

return require(MomentsCreationParent.MomentsCommon.createCoachmarkImpressionCache)(
    { coachmarkId = "tts", dismissedValue = -1 }
)
