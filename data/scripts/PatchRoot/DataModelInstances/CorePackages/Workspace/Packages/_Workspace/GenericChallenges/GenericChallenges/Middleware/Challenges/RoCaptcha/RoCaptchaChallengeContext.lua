-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local ChallengeLifecycleEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants).ChallengeLifecycleEventConstants

return {
    ChallengeInitialized = ChallengeLifecycleEventConstants.ChallengeInitialized,
    ChallengeDisplayed = ChallengeLifecycleEventConstants.ChallengeDisplayed,
    ChallengeInvalidated = ChallengeLifecycleEventConstants.ChallengeInvalidated,
    ChallengeAbandoned = ChallengeLifecycleEventConstants.ChallengeAbandoned,
    ChallengeLaunched = "challengeLaunched"
}
