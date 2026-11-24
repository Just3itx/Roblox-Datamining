-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local decodeMomentsUsage = require(DataHydration.Moments.Util.decodeMomentsUsage)

local function postMomentsUsageHeartbeat(network)
    local url, headers = constructApiUrl("content-captures-api/v2/moments/usage/heartbeat")

    return HttpClient.fetch({
        method = "POST",
        url = url,
        headers = headers,
        body = {},
        analyticsKey = "moments.post-moments-usage-heartbeat",
        network = network,
        retry = false,
        decode = decodeMomentsUsage
    })
end

return postMomentsUsageHeartbeat
