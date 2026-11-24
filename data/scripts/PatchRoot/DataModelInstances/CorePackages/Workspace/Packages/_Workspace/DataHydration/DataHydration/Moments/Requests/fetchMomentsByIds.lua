-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local MomentsTypes = require(DataHydrationParent.MomentsTypes)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local convertApiMomentsToMomentItems = require(DataHydration.Moments.Util.convertApiMomentsToMomentItems)
local extractCommentsByFeedItemId = require(DataHydration.Moments.Util.extractCommentsByFeedItemId)
local extractReactionsByMomentId = require(DataHydration.Moments.Util.extractReactionsByMomentId)
local extractShareInfoByMomentId = require(DataHydration.Moments.Util.extractShareInfoByMomentId)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local bool1 = game:DefineFastFlag("MomentsFixBatchedGetMomentsQueryParams", false)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local MomentGetIdType = MomentsTypes.Enums.MomentGetIdType
local ShareLinkTargetIdType = MomentsTypes.Enums.ShareLinkTargetIdType

local function fetchMomentsByIds(ids, network, feedItemId: string?)
    local var1, headers = constructApiUrl("content-captures-api/v2/moments/get-moments")
    local tbl1 = {
        Ids = table.concat(ids, ",")
    }
    if bool1 then
        tbl1.Ids = ids
    end
    tbl1.type = if feedItemId == ShareLinkTargetIdType.FeedItemId then MomentGetIdType.FeedItemId else MomentGetIdType.MomentId

    local url = `{var1}?{Http.Url:makeQueryString(tbl1)}`

    return HttpClient.fetch({
        method = "GET",
        url = url,
        headers = headers,
        analyticsKey = "moments.get-moments",
        network = network,
        decode = function(arg1)
            return {
                moments = convertApiMomentsToMomentItems(arg1.items),
                reactionsByMomentId = extractReactionsByMomentId(arg1.items),
                shareInfoByMomentId = extractShareInfoByMomentId(arg1.items),
                commentsByFeedItemId = if FFlagMomentsComments then extractCommentsByFeedItemId(arg1.items) else nil
            }
        end
    })
end

return fetchMomentsByIds
