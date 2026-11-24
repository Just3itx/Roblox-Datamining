-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local isCanonicalNonzeroUuid = require(DataHydration.Moments.Util.isCanonicalNonzeroUuid)
local CommentFixtures = require(script.Parent.CommentFixtures)
local MockCommentsPages = require(script.Parent.MockCommentsPages)

local function parseQuery(url: string)
    local result = ({})
    local var1 = string.find(url, "?", 1, true)
    if var1 == nil then
        return result
    end
    local gmatch = string.gmatch
    local var2 = var1 + 1

    for value in gmatch(string.sub(url, var2), "[^&]+") do
        local var3, var4 = string.match(value, "([^=]+)=?(.*)")
        if var3 ~= nil then
            result[var3] = var4 or ""
        end
    end
    return result
end

local function feedItemIdFromCommentsUrl(url: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return string.match(url, "/moments/([^/]+)/comments") or "feed-1"
end

local function commentIdFromDeleteUrl(url: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.match(url, "/comments/([^/?]+)$")
end

local function reactionIdsFromUrl(url: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(url, "/moments/([^/]+)/comments/([^/]+)/reactions$")
end

local function commentKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 11 call sites recovered
    return `{str1}:{str2}`
end

local function decodeBody(body)
    if type(body) ~= "string" or body == "" then
        return {}
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, body)
    return if success then result else {}
end

local function json(statusCode: number, input, headers) -- Luacid: Inlined by compiler; 16 call sites recovered
    return {
        statusCode = statusCode,
        headers = headers,
        responseBody = if input == nil then nil else HttpService:JSONEncode(input)
    }
end

local function toApiComment(arg1)
    return {
        commentId = arg1.commentId,
        feedItemId = arg1.feedItemId,
        authorUserId = if arg1.author == nil then nil else arg1.author.userId,
        text = arg1.text,
        translatedText = arg1.translatedText,
        createdAt = arg1.createdAt,
        isAuthoredByViewer = arg1.isAuthoredByViewer,
        reactions = arg1.reactions
    }
end

local function cloneReactions(arg1)
    local counts = table.create(#arg1.counts)
    for _, count in arg1.counts do
        table.insert(counts, table.clone(count))
    end
    return {
        counts = counts,
        userReaction = if arg1.userReaction == nil then nil else table.clone(arg1.userReaction)
    }
end

local function scheduleDelay(num1: number, func1: (...any) -> (...any))
    local var1 = task.delay(num1, func1)
    return function()
        if coroutine.status(var1) == "suspended" then
            task.cancel(var1)
        end
    end
end

local function createCommentsMockNetwork(tbl1)
    local tbl2 = tbl1 or {}
    local unixTimestamp = DateTime.now().UnixTimestamp
    local tbl3 = ({})
    local tbl4 = ({})
    local tbl5 = ({})
    local tbl6 = {}
    local tbl7 = ({})

    local function indexVisibleComment(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        local tbl8 = tbl6[arg1.feedItemId]
        if tbl8 == nil then
            tbl8 = {}
            tbl6[arg1.feedItemId] = tbl8
        end
        tbl8[arg1.commentId] = arg1
    end

    local function visibleComment(str1: string, str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = tbl6[str1]
        return if var1 == nil or tbl5[commentKey(str1, str2)] then nil else var1[str2]
    end

    for _, value in { CommentFixtures.REACTION_IDS.feedItemId, CommentFixtures.REACTION_IDS.otherFeedItemId } do
        for _, comment in MockCommentsPages.reactionPage(value, unixTimestamp).comments do
            indexVisibleComment(comment)
        end
    end

    local function findComment(str1: string, commentId: string)
        if tbl5[commentKey(str1, commentId)] then
            return nil
        end

        local var1 = visibleComment(str1, commentId)

        if var1 ~= nil then
            return var1
        end
        for _, value in { "", MockCommentsPages.EMPTY_HAS_MORE_CURSOR, MockCommentsPages.PAGE_3_CURSOR } do
            for _, comment in MockCommentsPages.pageForCursor(str1, value, unixTimestamp).comments do
                if comment.commentId == commentId then
                    return comment
                end
            end
        end
        return nil
    end

    local function pageWithMutations(str1: string, cursor: string?, arg1)
        local tbl8 = {}

        if cursor == nil or cursor == "" then
            local var1 = tbl4[str1]
            if var1 ~= nil then
                for _, value in var1 do
                    if not tbl5[commentKey(value.feedItemId, value.commentId)] then
                        table.insert(tbl8, value)
                    end
                end
            end
        end

        for _, comment in arg1.comments do
            if not tbl5[commentKey(comment.feedItemId, comment.commentId)] then
                table.insert(tbl8, comment)
            end
        end

        local comments = {}
        for _, value in tbl8 do
            indexVisibleComment(value)
            local tbl10 = toApiComment(value)
            local var1 = tbl7[commentKey(value.feedItemId, value.commentId)] or (tbl2.reactionProjectionsByCommentId or {})[value.commentId]
            if var1 ~= nil then
                tbl10.reactions = cloneReactions(var1)
            end
            table.insert(comments, tbl10)
        end

        return {
            comments = comments,
            nextCursor = arg1.nextCursor,
            hasMore = arg1.hasMore
        }
    end

    local mockNetwork = HttpClient.createMockNetwork({
        routes = {
            {
                pattern = "/reactions",
                respond = function(arg1)
                    local var1, var2 = reactionIdsFromUrl(arg1.url)
                    local var3 = decodeBody(arg1.body)
                    if var1 == nil
                        or var2 == nil
                        or not isCanonicalNonzeroUuid(var1)
                        or not isCanonicalNonzeroUuid(var2)
                        or var3.reactionType ~= "thumbsup"
                        or not isCanonicalNonzeroUuid(var3.emoteId)
                    then
                        return json(400, { errorCode = "InvalidRequest", message = "invalid reaction request" }, nil)
                    end

                    local var4 = visibleComment(var1, var2)

                    if var4 == nil then
                        return json(404, { errorCode = "CommentNotFound", message = "comment was not found for the requested moment" }, nil)
                    end

                    local reactionOutcome = tbl2.reactionOutcome or "success"
                    if reactionOutcome == "timeout" then
                        error("createCommentsMockNetwork: simulated reaction timeout")
                    end
                    if reactionOutcome == "ViewerNotEligibleToReact" then
                        return json(403, CommentFixtures.ERRORS.ViewerNotEligibleToReact, nil)
                    elseif reactionOutcome == "RateLimited" then
                        return json(429, CommentFixtures.ERRORS.RateLimited, { ["retry-after"] = tbl2.reactionRetryAfter or "10" })
                    end

                    local str1 = commentKey(var1, var2)

                    local var5 = tbl7[str1] or (tbl2.reactionProjectionsByCommentId or {})[var2] or var4.reactions or {
                        counts = {}
                    }
                    local tbl8 = cloneReactions(var5)
                    local emoteId = if tbl8.userReaction == nil then nil else tbl8.userReaction.emoteId

                    if arg1.method == "PUT" then
                        if emoteId ~= nil and emoteId ~= var3.emoteId then
                            return json(409, { errorCode = "ReactionTypeConflict", message = "a different reaction is selected" }, nil)
                        end

                        if emoteId == nil then
                            local bool1 = false
                            for _, count in tbl8.counts do
                                if count.emoteId == var3.emoteId then
                                    count.count += 1
                                    bool1 = true
                                end
                            end

                            if not bool1 then
                                table.insert(tbl8.counts, { emoteId = var3.emoteId, count = 1 })
                            end

                            tbl8.userReaction = {
                                emoteId = var3.emoteId
                            }
                        end
                    else
                        if arg1.method ~= "DELETE" then
                            return json(405, { errorCode = "CommentsUnavailable", message = `unsupported reaction method {arg1.method}` }, nil)
                        end

                        if emoteId == var3.emoteId then
                            for _, count in tbl8.counts do
                                if count.emoteId == var3.emoteId then
                                    local var6 = count.count - 1
                                    count.count = math.max(0, var6)
                                end
                            end
                            tbl8.userReaction = nil
                        end
                    end

                    tbl7[str1] = tbl8
                    return { statusCode = 204, responseBody = nil }
                end
            },
            {
                pattern = "/comments",
                respond = function(arg1)
                    local method = arg1.method
                    if method == "GET" then
                        local var1 = feedItemIdFromCommentsUrl(arg1.url)
                        local commentId = commentIdFromDeleteUrl(arg1.url)
                        if commentId == nil then
                            local tbl8 = parseQuery(arg1.url)
                            local var2 = MockCommentsPages.pageForCursor(var1, tbl8.cursor, unixTimestamp)
                            return json(200, pageWithMutations(var1, tbl8.cursor, var2), nil)
                        end

                        local comment = findComment(var1, commentId)
                        if comment == nil then
                            return json(404, { errorCode = "CommentNotFound", message = "comment was not found for the requested moment" }, nil)
                        end

                        indexVisibleComment(comment)
                        local tbl8 = toApiComment(comment)
                        local var2 = tbl7[commentKey(var1, commentId)] or (tbl2.reactionProjectionsByCommentId or {})[commentId]
                        if var2 ~= nil then
                            tbl8.reactions = cloneReactions(var2)
                        end

                        return json(200, tbl8, nil)
                    elseif method == "POST" then
                        local var1 = decodeBody(arg1.body)
                        local clientRequestId = var1.clientRequestId
                        local feedItemId = feedItemIdFromCommentsUrl(arg1.url)
                        local var3 = if type(clientRequestId) == "string" then commentKey(feedItemId, clientRequestId) else nil
                        local postOutcome = tbl2.postOutcome or "success"
                        if postOutcome == "timeout" then
                            error("createCommentsMockNetwork: simulated timeout")
                        end
                        if postOutcome == "TextFilterRejected" then
                            return json(422, CommentFixtures.ERRORS.TextFilterRejected, nil)
                        elseif postOutcome == "RateLimited" then
                            return json(429, CommentFixtures.ERRORS.RateLimited, nil)
                        elseif var3 ~= nil and tbl3[var3] ~= nil then
                            return json(200, toApiComment(tbl3[var3]), nil)
                        else
                            local author = table.clone(CommentFixtures.AUTHORS.roblox)
                            author.userId = tbl2.postAuthorUserId or author.userId
                            local comment = CommentFixtures.makeComment({
                                commentId = `posted-{feedItemId}-{clientRequestId or HttpService:GenerateGUID(false)}`,
                                feedItemId = feedItemId,
                                text = if type(var1.text) ~= "string" then "" else var1.text,
                                createdAt = DateTime.now():ToIsoDate(),
                                isAuthoredByViewer = true,
                                author = author
                            })
                            if var3 ~= nil then
                                tbl3[var3] = comment
                            end
                            local var5 = tbl4[feedItemId] or {}
                            table.insert(var5, 1, comment)
                            tbl4[feedItemId] = var5
                            indexVisibleComment(comment)

                            if postOutcome == "replay" then
                                return json(200, toApiComment(comment), nil)
                            end
                            return json(201, toApiComment(comment), nil)
                        end
                    else
                        if method ~= "DELETE" then
                            return json(405, { errorCode = "CommentsUnavailable", message = `unsupported method {method}` }, nil)
                        end

                        local var1 = feedItemIdFromCommentsUrl(arg1.url)
                        local var2 = commentIdFromDeleteUrl(arg1.url)
                        if var2 == nil then
                            return json(405, { errorCode = "CommentsUnavailable", message = "invalid author-comment DELETE path" }, nil)
                        end

                        local str1 = commentKey(var1, var2)

                        tbl5[str1] = true
                        local var3 = tbl6[var1]
                        if var3 ~= nil then
                            var3[var2] = nil
                        end
                        return { statusCode = 204, responseBody = nil }
                    end
                end
            }
        }
    })

    local function latencyForRequest(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        if string.find(arg1.url, "/reactions", 1, true) then
            return tbl2.reactionLatencySeconds or tbl2.latencySeconds
        end
        local method = arg1.method

        if method == "GET" then
            return tbl2.fetchLatencySeconds or tbl2.latencySeconds
        elseif method == "POST" then
            return tbl2.postLatencySeconds or tbl2.latencySeconds
        end

        return tbl2.latencySeconds
    end

    return {
        request = function(arg1, func1: (...any) -> (...any))
            local var1 = latencyForRequest(arg1)

            if type(var1) ~= "number" or var1 <= 0 then
                return mockNetwork.request(arg1, func1)
            end

            local bool1 = false
            local var2 = nil
            local var3 = (tbl2.schedule or scheduleDelay)(var1, function()
                if not bool1 then
                    var2 = mockNetwork.request(arg1, func1)
                end
            end)

            return function()
                if bool1 then
                    return
                end
                bool1 = true
                var3()
                if var2 ~= nil then
                    var2()
                end
            end
        end
    }
end

return createCommentsMockNetwork
