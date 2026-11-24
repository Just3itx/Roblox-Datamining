-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local FFlagArgusUseMockFeedItems = require(DataHydration.Moments.FFlagArgusUseMockFeedItems)
local MockTrendingMoments = require(DataHydration.Moments.MockTrendingMoments)
local convertApiMomentsToMomentItems = require(DataHydration.Moments.Util.convertApiMomentsToMomentItems)
local extractCommentsByFeedItemId = require(DataHydration.Moments.Util.extractCommentsByFeedItemId)
local extractReactionsByMomentId = require(DataHydration.Moments.Util.extractReactionsByMomentId)
local extractShareInfoByMomentId = require(DataHydration.Moments.Util.extractShareInfoByMomentId)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local mockNetwork = HttpClient.createMockNetwork({
    fallback = function()
        return {
            statusCode = 200,
            responseBody = HttpService:JSONEncode({})
        }
    end
})

local function fetchTrendingMoments(momentsSessionId: string, paginationContext: string?, network, input)
    local var1, headers = constructApiUrl("content-captures-api/v2/moments/get-moment-recommendations")
    local url = Http.Url
    local tbl1 = {
        momentsSessionId = momentsSessionId,
        paginationContext = paginationContext,
        signals = if input then HttpService:JSONEncode(input) else nil
    }
    local str1 = `{var1}?{url:makeQueryString(tbl1)}`
    local var3 = FFlagArgusUseMockFeedItems()

    local fetch = HttpClient.fetch
    local tbl2 = {
        method = "GET",
        url = str1,
        headers = headers,
        analyticsKey = "moments.get-moment-recommendations",
        network = 0,
        decode = 0
    }
    if var3 then
        network = mockNetwork
    end

    tbl2.network = network
    function tbl2.decode(arg2)
        if not var3 then
            return {
                moments = convertApiMomentsToMomentItems(arg2.items),
                nextCursor = arg2.paginationContext or paginationContext,
                reactionsByMomentId = extractReactionsByMomentId(arg2.items),
                shareInfoByMomentId = extractShareInfoByMomentId(arg2.items),
                commentsByFeedItemId = if FFlagMomentsComments then extractCommentsByFeedItemId(arg2.items) else nil
            }
        end

        return {
            moments = MockTrendingMoments,
            nextCursor = nil,
            reactionsByMomentId = {},
            shareInfoByMomentId = {},
            commentsByFeedItemId = FFlagMomentsComments and {} or nil
        }
    end

    return fetch(tbl2)
end

return fetchTrendingMoments
