-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local isCanonicalNonzeroUuid = require(DataHydration.Moments.Util.isCanonicalNonzeroUuid)

local function reactionPath(str1: string, str2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `moment-comments-api/v1/moments/{str1}/comments/{str2}/reactions`
end

local function putMomentCommentReaction(str1: string, str2: string, emoteId: string, network, statusCodeActions)
    assert(isCanonicalNonzeroUuid(str1), "putMomentCommentReaction: feedItemId must be a canonical nonzero UUID")
    assert(isCanonicalNonzeroUuid(str2), "putMomentCommentReaction: commentId must be a canonical nonzero UUID")
    assert(isCanonicalNonzeroUuid(emoteId), "putMomentCommentReaction: emoteId must be a canonical nonzero UUID")
    local url, headers = constructApiUrl((reactionPath(str1, str2)))
    return HttpClient.fetch({
        method = "PUT",
        url = url,
        headers = headers,
        body = { reactionType = "thumbsup", emoteId = emoteId },
        analyticsKey = "moments.put-comment-reaction",
        network = network,
        retry = false,
        statusCodeActions = statusCodeActions,
        decode = function(_)
            return nil
        end
    })
end

return putMomentCommentReaction
