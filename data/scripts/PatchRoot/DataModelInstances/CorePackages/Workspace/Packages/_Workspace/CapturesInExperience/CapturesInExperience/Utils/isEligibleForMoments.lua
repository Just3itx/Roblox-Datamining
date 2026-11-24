-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _MomentsEligibility = require(scriptParentParent.installReducer.MomentsEligibility)

local FFlagMomentsCreationFeatureGate = require(scriptParentParentParent.SharedFlags).FFlagMomentsCreationFeatureGate
local GetMomentsCapabilities = require(scriptParentParentParent.MomentsCommon).Stores.GetMomentsCapabilities

local engineFeature = game:GetEngineFeature("CaptureServiceEnableXExperiencePostingApis")

local function isEligibleForMoments(arg1): boolean
    return if engineFeature then not (FFlagMomentsCreationFeatureGate and not GetMomentsCapabilities(false).getCanCreateMoments(false))
        and arg1.byUniverseId[game.GameId] == true else false
end

return isEligibleForMoments
