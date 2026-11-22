-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local MomentsTTSCoachmarkImpressionCache = require(MomentsCreation.Storage.MomentsTTSCoachmarkImpressionCache)

local function makeVoiceCoachmarkConfig(bool1: boolean, bool2: boolean): {impressionCache: any, kind: string, textKey: string, titleKey: string}?
    return if bool1 and bool2 then {
        kind = "voice",
        titleKey = "Feature.Moments.Label.VoiceCoachmarkTitle",
        textKey = "Feature.Moments.Label.VoiceCoachmarkBody",
        impressionCache = MomentsTTSCoachmarkImpressionCache
    } else nil
end

return makeVoiceCoachmarkConfig
