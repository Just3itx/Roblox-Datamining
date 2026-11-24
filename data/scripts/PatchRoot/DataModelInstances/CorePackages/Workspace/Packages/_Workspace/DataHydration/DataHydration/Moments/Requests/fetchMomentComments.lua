-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)
local convertApiCommentToComment = require(DataHydration.Moments.Util.convertApiCommentToComment)
local FFlagEnableMomentsCommentReporting = require(DataHydrationParent.SharedFlags).FFlagEnableMomentsCommentReporting

local function commentsPath(feedItemId: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `moment-comments-api/v1/moments/{feedItemId}/comments`
end

local function decodeCommentsPage(arg1)
    local comments = {}
    if type(arg1) == "table" and type(arg1.comments) == "table" then
        for _, comment in arg1.comments do
            local var1 = convertApiCommentToComment(comment)
            if var1 ~= nil then
                table.insert(comments, var1)
            end
        end
    end

    return {
        comments = comments,
        channelId = if FFlagEnableMomentsCommentReporting
            and type(arg1) == "table"
            and type(arg1.channelId) == "string"
            and arg1.channelId ~= "" then arg1.channelId else nil,
        nextCursor = if type(arg1) == "table" and type(arg1.nextCursor) == "string" then arg1.nextCursor else nil,
        hasMore = type(arg1) == "table" and arg1.hasMore == true
    }
end

local function fetchMomentComments(tbl1, network)
    local var1, headers = constructApiUrl((commentsPath(tbl1.feedItemId)))
    local var3 = Http.Url:makeQueryString({ cursor = tbl1.cursor, limit = tbl1.limit, sort = tbl1.sort })

    if var3 ~= "" then
        var1 = `{var1}?{var3}`
    end
    return HttpClient.fetch({
        method = "GET",
        url = var1,
        headers = headers,
        analyticsKey = "moments.get-comments",
        network = network,
        decode = decodeCommentsPage
    })
end

return fetchMomentComments
