-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local isCanonicalNonzeroUuid = require(script.Parent.isCanonicalNonzeroUuid)

local function decodeReactions(reactions)
    if type(reactions) ~= "table" or type(reactions.counts) ~= "table" then
        return nil
    end

    local counts = {}
    local tbl2 = {}
    local countsLen = #reactions.counts
    local num1 = 0
    for k, count in reactions.counts do
        if type(k) ~= "number"
            or k % 1 ~= 0
            or k < 1
            or countsLen < k
            or type(count) ~= "table"
            or not isCanonicalNonzeroUuid(count.emoteId)
            or type(count.count) ~= "number"
            or count.count < 0
            or count.count % 1 ~= 0
            or tbl2[count.emoteId] ~= nil
        then
            return nil
        end

        num1 += 1
        tbl2[count.emoteId] = count.count
        table.insert(counts, { emoteId = count.emoteId, count = count.count })
    end

    if num1 ~= countsLen then
        return nil
    end

    local tbl3

    if reactions.userReaction == nil then
        tbl3 = nil
    else
        if type(reactions.userReaction) ~= "table"
            or not isCanonicalNonzeroUuid(reactions.userReaction.emoteId)
            or (tbl2[reactions.userReaction.emoteId] or 0) <= 0
        then
            return nil
        end
        tbl3 = {
            emoteId = reactions.userReaction.emoteId
        }
    end

    return { counts = counts, userReaction = tbl3 }
end

local function convertApiCommentToComment(arg1): {author: {userId: any}, commentId: any, createdAt: number, editedAt: nil, feedItemId: any, isAuthoredByViewer: number, reactions: number, status: string, text: any, translatedText: number}?
    if type(arg1) ~= "table" then
        return nil
    end

    if type(arg1.commentId) ~= "string" or arg1.commentId == "" then
        return nil
    end
    if type(arg1.feedItemId) ~= "string" or arg1.feedItemId == "" then
        return nil
    end
    if type(arg1.authorUserId) ~= "string" or arg1.authorUserId == "" then
        return nil
    end
    if type(arg1.text) ~= "string" then
        return nil
    end
    if type(arg1.createdAt) ~= "string" or arg1.createdAt == "" then
        return nil
    end
    if arg1.isAuthoredByViewer ~= nil and type(arg1.isAuthoredByViewer) ~= "boolean" then
        return nil
    end

    return {
        commentId = arg1.commentId,
        feedItemId = arg1.feedItemId,
        status = "Active",
        author = {
            userId = arg1.authorUserId
        },
        text = arg1.text,
        translatedText = if type(arg1.translatedText) == "string" and arg1.translatedText ~= "" and arg1.translatedText ~= arg1.text then arg1.translatedText else nil,
        createdAt = arg1.createdAt,
        editedAt = nil,
        isAuthoredByViewer = arg1.isAuthoredByViewer == true,
        reactions = if arg1.reactions == nil then nil else decodeReactions(arg1.reactions)
    }
end

return convertApiCommentToComment
