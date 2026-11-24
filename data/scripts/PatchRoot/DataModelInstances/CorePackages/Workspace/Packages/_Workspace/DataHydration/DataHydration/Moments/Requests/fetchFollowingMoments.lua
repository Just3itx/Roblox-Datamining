-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local convertApiMomentsToMomentItems = require(DataHydration.Moments.Util.convertApiMomentsToMomentItems)
local extractCommentsByFeedItemId = require(DataHydration.Moments.Util.extractCommentsByFeedItemId)
local extractReactionsByMomentId = require(DataHydration.Moments.Util.extractReactionsByMomentId)
local extractShareInfoByMomentId = require(DataHydration.Moments.Util.extractShareInfoByMomentId)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local FFlagMomentsComments = SharedFlags.FFlagMomentsComments

local function fetchFollowingMoments(paginationContext: string?, network)
    local var1, headers = constructApiUrl("content-captures-api/v2/moments/get-following-moments")
    local var3 = Http.Url:makeQueryString({ paginationContext = paginationContext })

    if var3 ~= "" then
        var1 = `{var1}?{var3}`
    end
    return HttpClient.fetch({
        method = "GET",
        url = var1,
        headers = headers,
        analyticsKey = "moments.get-following-moments",
        network = network,
        decode = function(arg1)
            local paginationContext2 = arg1.paginationContext
            local tbl1 = {
                moments = convertApiMomentsToMomentItems(arg1.items),
                nextCursor = 0,
                reactionsByMomentId = 0,
                shareInfoByMomentId = 0,
                commentsByFeedItemId = 0
            }

            if paginationContext2 == nil or paginationContext2 == "" then
                paginationContext2 = nil
            end

            tbl1.nextCursor = paginationContext2
            tbl1.reactionsByMomentId = extractReactionsByMomentId(arg1.items)
            tbl1.shareInfoByMomentId = extractShareInfoByMomentId(arg1.items)
            tbl1.commentsByFeedItemId = if FFlagMomentsComments then extractCommentsByFeedItemId(arg1.items) else nil
            return tbl1
        end
    })
end

return fetchFollowingMoments
