-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local SignalsReact = require(BuildExperienceParent.SignalsReact)

local AdCampaigns = require(BuildExperienceParent.DataHydration.AdCampaigns)

local useSignalState = SignalsReact.useSignalState

local function useGetAdCampaigns(arg1)
    local var1 = (arg1 or AdCampaigns.getAdCampaignsStore(false)).getAndFetchAdCampaigns()

    return useSignalState(var1.data), (useSignalState(var1.status))
end

return useGetAdCampaigns
