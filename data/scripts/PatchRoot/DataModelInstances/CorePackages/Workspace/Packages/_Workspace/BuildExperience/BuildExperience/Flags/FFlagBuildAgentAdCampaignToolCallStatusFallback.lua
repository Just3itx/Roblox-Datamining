-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagBuildAgentAdCampaignCard = require(script.Parent.FFlagBuildAgentAdCampaignCard)

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

return require(BuildExperienceParent.SharedFlags).FFlagBuildAgentAdCampaignToolCallStatusFallback
    and FFlagBuildAgentAdCampaignCard
