-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Game = require(BuildExperienceParent.DataHydration).Game
local refreshPublishEligibility = require(script.Parent.refreshPublishEligibility)
local refreshAdCampaignEligibility = require(script.Parent.refreshAdCampaignEligibility)
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)

local function rehydrateGameMetadata(num1: number)
    local str1 = tostring(num1)

    Game.getGameInfoStore().fetchGameInfo(str1)
    Game.getGameMediaStore().fetchGameMedia(str1)
    refreshPublishEligibility(num1)
    if FFlagEnableBuildAdPromotion then
        refreshAdCampaignEligibility(num1)
    end
end

return rehydrateGameMetadata
