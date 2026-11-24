-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local decodeMomentsUsage = require(DataHydration.Moments.Util.decodeMomentsUsage)

local function getMomentsUsage(network)
    local url, headers = constructApiUrl("content-captures-api/v2/moments/usage")

    return HttpClient.fetch({
        method = "GET",
        url = url,
        headers = headers,
        analyticsKey = "moments.get-moments-usage",
        network = network,
        decode = decodeMomentsUsage
    })
end

return getMomentsUsage
