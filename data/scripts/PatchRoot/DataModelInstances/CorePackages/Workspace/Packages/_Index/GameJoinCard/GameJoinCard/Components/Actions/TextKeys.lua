-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagJoinabilityCTAContextCopy = SharedFlags.FFlagJoinabilityCTAContextCopy
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor

return {
    [UserCtaAction.JoinExperience] = "Feature.Profile.Action.JoinGame",
    [UserCtaAction.PlayExperience] = if FFlagJoinabilityCTAContextCopy then "Feature.ExperienceDetails.PlayButtonText.Play" elseif FFlagJoinabilityCTARefactor then "Feature.Profile.Action.JoinGame" else nil,
    [UserCtaAction.Chat] = "Feature.Profile.Action.Chat",
    [UserCtaAction.ViewProfile] = "Feature.Profile.Action.ViewProfile",
    [UserCtaAction.UnlockExperience] = "Feature.ExperienceDetails.PlayButtonText.Unlock"
}
