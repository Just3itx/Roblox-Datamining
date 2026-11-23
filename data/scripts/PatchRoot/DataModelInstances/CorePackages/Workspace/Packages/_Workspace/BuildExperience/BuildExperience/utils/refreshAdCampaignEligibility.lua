-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)

local function refreshAdCampaignEligibility(num1: number)
    AdCampaignEligibility.getAdCampaignEligibilityStore(false).fetchEligibility(num1)
end

return refreshAdCampaignEligibility
