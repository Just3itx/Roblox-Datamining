-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Players = game:GetService("Players")

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local FStringMomentsPostInsightsIxpLayer = require(Moments.Flags.FStringMomentsPostInsightsIxpLayer)

local RecommendationSource = MomentsCommon.Analytics.RecommendationSource

local function logPostInsightsLayerExposure(arg1, profile: string?)
    if profile ~= RecommendationSource.Profile then
        return
    end
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil or arg1.creatorId ~= localPlayer.UserId then
        return
    end

    MomentsCommon.Utils.logMomentsLayerExposure(FStringMomentsPostInsightsIxpLayer)
end

return logPostInsightsLayerExposure
