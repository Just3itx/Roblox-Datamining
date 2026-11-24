-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:50Z
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

local function deleteMomentCommentReaction(str1: string, str2: string, emoteId: string, network, statusCodeActions)
    assert(isCanonicalNonzeroUuid(str1), "deleteMomentCommentReaction: feedItemId must be a canonical nonzero UUID")

    assert(isCanonicalNonzeroUuid(str2), "deleteMomentCommentReaction: commentId must be a canonical nonzero UUID")
    assert(isCanonicalNonzeroUuid(emoteId), "deleteMomentCommentReaction: emoteId must be a canonical nonzero UUID")
    local url, headers = constructApiUrl((reactionPath(str1, str2)))
    return HttpClient.fetch({
        method = "DELETE",
        url = url,
        headers = headers,
        body = { reactionType = "thumbsup", emoteId = emoteId },
        analyticsKey = "moments.delete-comment-reaction",
        network = network,
        retry = false,
        statusCodeActions = statusCodeActions,
        decode = function(_)
            return nil
        end
    })
end

return deleteMomentCommentReaction
