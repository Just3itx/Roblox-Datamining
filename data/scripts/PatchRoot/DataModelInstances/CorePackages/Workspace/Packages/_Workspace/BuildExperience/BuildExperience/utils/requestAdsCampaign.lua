-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local GetAdsCampaignDeepLinkStore = require(BuildExperience.Stores.GetAdsCampaignDeepLinkStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function requestAdsCampaign(universeId: number)
    local requestId = HttpService:GenerateGUID(false)
    GetAdsCampaignDeepLinkStore(false).begin(requestId, universeId)
    sendBuildExperienceEvent("AD_CAMPAIGN_DEEP_LINK_RECEIVED", { universeId = universeId }, { requestId = requestId })
end

return requestAdsCampaign
