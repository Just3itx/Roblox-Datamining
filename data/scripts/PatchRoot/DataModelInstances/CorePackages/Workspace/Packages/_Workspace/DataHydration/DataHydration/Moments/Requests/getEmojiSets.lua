-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local decodeEmojiSets = require(DataHydration.Moments.Util.decodeEmojiSets)

local function getEmojiSets(network)
    local url, headers = constructApiUrl("emoji-api/v1/get-emoji-sets?product=Moments")

    return HttpClient.fetch({
        method = "GET",
        url = url,
        headers = headers,
        analyticsKey = "moments.get-emoji-sets",
        network = network,
        decode = function(arg1)
            return decodeEmojiSets.decodeGetEmojiSetsResponse(arg1)
        end
    })
end

return getEmojiSets
