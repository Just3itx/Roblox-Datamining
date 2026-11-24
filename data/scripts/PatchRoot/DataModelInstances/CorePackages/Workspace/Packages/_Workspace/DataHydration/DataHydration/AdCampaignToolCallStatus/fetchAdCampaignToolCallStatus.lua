-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local CreatorAgentChat = require(DataHydrationParent.DataHydration.CreatorAgentChat)
local _AdCampaignToolCallStatusStoreTypes = require(script.Parent.AdCampaignToolCallStatusStoreTypes)

local function fetchAdCampaignToolCallStatus(toolCallId: string, _: number)
    local creatorAgentChatStore = CreatorAgentChat.getCreatorAgentChatStore(false)
    return HttpClient.asPromise(creatorAgentChatStore.adCampaignToolCallStatus({ toolCallId = toolCallId }))
end

return fetchAdCampaignToolCallStatus
