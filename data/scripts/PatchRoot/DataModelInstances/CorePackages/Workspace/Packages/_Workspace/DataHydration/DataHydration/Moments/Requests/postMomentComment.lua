-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local convertApiCommentToComment = require(DataHydration.Moments.Util.convertApiCommentToComment)

local function commentsPath(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `moment-comments-api/v1/moments/{str1}/comments`
end

local function postMomentComment(str1: string, body, network, statusCodeActions)
    local url, headers = constructApiUrl((commentsPath(str1)))

    return HttpClient.fetch({
        method = "POST",
        url = url,
        headers = headers,
        body = body,
        analyticsKey = "moments.post-comment",
        network = network,
        statusCodeActions = statusCodeActions,
        decode = function(arg1)
            local var3 = convertApiCommentToComment(arg1)
            assert(var3 ~= nil, "postMomentComment: response was not a Comment")
            return var3
        end
    })
end

return postMomentComment
