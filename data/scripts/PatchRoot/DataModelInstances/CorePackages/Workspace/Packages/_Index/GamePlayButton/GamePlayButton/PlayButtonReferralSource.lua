-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
return {
    ExperienceDetailsLink = "ExperienceDetailsLink",
    ExperienceAffiliateLink = "ExperienceAffiliateLink",
    PlayWithReward = if require(GamePlayButtonParent.SharedFlags).FFlagEnablePlayWithRewardComponent then "PlayWithReward" else nil
}
