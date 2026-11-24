-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local function reactToFeedItemV2(body, network)
    local url, headers = constructApiUrl("content-captures-api/v2/moments/react-to-feed-item-v2")

    return HttpClient.fetch({
        method = "POST",
        url = url,
        headers = headers,
        body = body,
        analyticsKey = "moments.react-to-feed-item-v2",
        network = network,
        decode = function(arg1)
            return arg1 or {}
        end
    })
end

return reactToFeedItemV2
