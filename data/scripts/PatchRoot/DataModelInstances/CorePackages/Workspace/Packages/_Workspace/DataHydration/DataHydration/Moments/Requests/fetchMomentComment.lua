-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local convertApiCommentToComment = require(DataHydration.Moments.Util.convertApiCommentToComment)

local function commentPath(str1: string, str2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `moment-comments-api/v1/moments/{str1}/comments/{str2}`
end

local function fetchMomentComment(str1: string, str2: string, network)
    local url, headers = constructApiUrl((commentPath(str1, str2)))

    return HttpClient.fetch({
        method = "GET",
        url = url,
        headers = headers,
        analyticsKey = "moments.get-comment",
        network = network,
        decode = function(arg1)
            return convertApiCommentToComment(arg1)
        end
    })
end

return fetchMomentComment
