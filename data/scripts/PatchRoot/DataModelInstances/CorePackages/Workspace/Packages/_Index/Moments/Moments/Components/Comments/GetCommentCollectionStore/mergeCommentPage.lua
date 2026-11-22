-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _CommentCollectionTypes = require(script.Parent.CommentCollectionTypes)

local tbl1 = {
    sessionHiddenCommentIds = {},
    recentlyBlockedAuthorIds = {}
}

local function mergeCommentPage(tbl2)
    local var1 = tbl2.filters or tbl1
    local var2 = tbl2.stickyPostedCommentIds or {}
    local visibleIdsBeforeReconciliation = tbl2.visibleIdsBeforeReconciliation or {}
    local tbl3 = ({})
    local orderedCommentIds = {}

    if tbl2.pendingSentinel ~= nil then
        table.insert(orderedCommentIds, tbl2.pendingSentinel)
        tbl3[tbl2.pendingSentinel] = true
    end

    for _, value in var2 do
        if not tbl3[value] then
            table.insert(orderedCommentIds, value)
            tbl3[value] = true
        end
    end

    local pinnedCommentId = tbl2.pinnedCommentId
    if pinnedCommentId ~= nil and not tbl3[pinnedCommentId] and var1.sessionHiddenCommentIds[pinnedCommentId] ~= true then
        table.insert(orderedCommentIds, pinnedCommentId)
        tbl3[pinnedCommentId] = true
    end

    if not tbl2.replace then
        for _, existingId in tbl2.existingIds do
            if not tbl3[existingId] then
                table.insert(orderedCommentIds, existingId)
                tbl3[existingId] = true
            end
        end
    end

    local addedIds = {}
    for _, pageComment in tbl2.pageComments do
        if pageComment.status ~= "Active"
            or tbl3[pageComment.commentId]
            or var1.sessionHiddenCommentIds[pageComment.commentId] == true
        then
            continue
        end

        local userId = if pageComment.author == nil then nil else pageComment.author.userId

        if userId ~= nil and var1.recentlyBlockedAuthorIds[userId] == true then
            continue
        end

        table.insert(orderedCommentIds, pageComment.commentId)
        tbl3[pageComment.commentId] = true
        if not visibleIdsBeforeReconciliation[pageComment.commentId] then
            table.insert(addedIds, pageComment.commentId)
        end
    end

    return {
        orderedCommentIds = orderedCommentIds,
        addedIds = addedIds,
        visibleCount = #addedIds,
        shouldContinuePaging = tbl2.hasMore == true and #addedIds == 0
    }
end

return mergeCommentPage
