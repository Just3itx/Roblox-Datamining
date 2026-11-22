-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local shallowEqual = require(MomentsParent.Dash).shallowEqual
local CommentCollectionTypes = require(Moments.Components.Comments.GetCommentCollectionStore.CommentCollectionTypes)
local _CommentRowTypes = require(script.Parent.CommentRowTypes)

local function reusePreviousRows(previousRows, tbl1)
    local tbl2 = {}
    for _, previousRow in previousRows do
        tbl2[previousRow.key] = previousRow
    end
    local bool1 = #tbl1 == #previousRows
    for value, value2 in tbl1 do
        local var1 = tbl2[value2.key]
        if var1 ~= nil and shallowEqual(var1, value2) then
            tbl1[value] = var1
        end
        bool1 = bool1 and tbl1[value] == previousRows[value]
    end
    return if bool1 then previousRows else tbl1
end

local function buildCommentRows(tbl1)
    local state = tbl1.state
    local resolveComment = tbl1.resolveComment
    local previousRows = tbl1.previousRows
    local expandedCommentIds = tbl1.expandedCommentIds
    local translation = tbl1.translation
    local var1 = table.create(#state.orderedCommentIds + (if state.pendingSubmission == nil then 0 else 1))
    local pendingSubmission = state.pendingSubmission
    if pendingSubmission ~= nil then
        table.insert(var1, {
            type = "pending",
            key = CommentCollectionTypes.pendingSentinel(pendingSubmission.clientRequestId),
            text = pendingSubmission.text,
            status = pendingSubmission.status
        })
    end

    for _, commentId in state.orderedCommentIds do
        if CommentCollectionTypes.isPendingSentinel(commentId) then
            continue
        end

        local var2 = resolveComment(commentId)
        local var3 = if var2 == nil then "" else var2.text or ""
        local translatedText = if var2 == nil then nil else var2.translatedText
        local var4

        if translation == nil or translatedText == nil then
            var4 = nil
        elseif translation.toggledCommentIds[commentId] == true == translation.showsTranslationByDefault then
            var4 = "Original"
        else
            var3 = translatedText
            var4 = "Translated"
        end

        table.insert(var1, {
            type = "comment",
            key = `comment:{commentId}`,
            commentId = commentId,
            text = var3,
            createdAt = if var2 == nil then "" else var2.createdAt,
            isExpanded = not (expandedCommentIds == nil) and expandedCommentIds[commentId] == true,
            translationState = var4
        })
    end

    if previousRows ~= nil then
        return (reusePreviousRows(previousRows, var1))
    end
    return var1
end

return buildCommentRows
