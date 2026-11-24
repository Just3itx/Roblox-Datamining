-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)

local CreatorAgentChat = require(DataHydration.CreatorAgentChat)
local _AdCampaignEligibilityStoreTypes = require(script.Parent.AdCampaignEligibilityStoreTypes)

local function fetchAdCampaignEligibility(universeId: number)
    local creatorAgentChatStore = CreatorAgentChat.getCreatorAgentChatStore(false)
    return HttpClient.asPromise(creatorAgentChatStore.adCampaignEligibility({ universeId = universeId }))
end

return fetchAdCampaignEligibility
