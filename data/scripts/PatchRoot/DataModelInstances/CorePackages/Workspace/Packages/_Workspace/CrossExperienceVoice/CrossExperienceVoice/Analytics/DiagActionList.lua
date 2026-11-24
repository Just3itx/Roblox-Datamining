-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CrossExperienceVoiceParent = script:FindFirstAncestor("CrossExperienceVoice").Parent

local EventNames = require(script.Parent.EventNames)
local DiagEventTypes = require(CrossExperienceVoiceParent.SocialLuaAnalytics).Analytics.Enums.DiagEventTypes

return {
    [EventNames.PartyVoiceConnectedParticipantsOnJoin] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("PartyVoiceConnectedParticipantsOnJoinCounter", "PartyVoiceConnectedParticipantsOnJoin")
    }
}
