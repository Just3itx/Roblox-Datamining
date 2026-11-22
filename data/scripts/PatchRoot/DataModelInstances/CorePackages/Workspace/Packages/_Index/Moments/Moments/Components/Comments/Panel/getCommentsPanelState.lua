-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local LoadStatus = require(Moments.Components.Comments.GetCommentCollectionStore.CommentCollectionTypes).LoadStatus

local tbl1 = {
    MomentUnavailable = true,
    MomentNotFound = true,
    MomentNotVisible = true,
    ViewerNotEligibleToRead = true
}

local tbl2 = {
    CommentsDisabledByCreator = true,
    MomentUnavailable = true,
    MomentNotFound = true,
    MomentNotVisible = true,
    ViewerNotEligibleToRead = true,
    ViewerNotEligibleToWrite = true
}

local function getCommentsPanelState(arg1, arg2)
    local errorCode = arg2.errorCode
    local bool1 = arg1 ~= nil and arg1.viewerCanWrite == false or errorCode == "ViewerNotEligibleToWrite"
    local bool2 = arg2.initialLoadStatus == LoadStatus.Success
    local canCompose = not bool1
        and (arg1 == nil or arg1.creatorEnabled and arg1.viewerCanRead)
        and (errorCode == nil or tbl2[errorCode] ~= true)

    local bool3 = false
    local bool4 = false
    local str1

    if (bool2 or arg1 == nil or arg1.viewerCanRead ~= false) and (errorCode == nil or tbl1[errorCode] ~= true) then
        if errorCode == "CommentsDisabledByCreator" or not bool2 and arg1 ~= nil and arg1.creatorEnabled == false then
            str1 = "disabled"
            bool1 = false
        elseif arg1 == nil and arg2.initialLoadStatus ~= LoadStatus.Failed and not bool2 then
            str1 = "loading"
        elseif #arg2.orderedCommentIds > 0 or arg2.pendingSubmission ~= nil and arg2.initialLoadStatus ~= LoadStatus.Failed then
            str1 = "list"
        elseif arg2.loadMoreStatus == LoadStatus.Failed then
            str1 = "unavailable"
            bool4 = true
        elseif bool2 then
            if arg2.hasMore then
                str1 = "loading"
            else
                str1 = "empty"
            end
        elseif arg2.initialLoadStatus == LoadStatus.Failed then
            str1 = "unavailable"
            bool4 = true
        else
            str1 = "loading"
        end
    else
        str1 = "unavailable"
        bool3 = true
    end

    return {
        contentState = str1,
        isReadOnly = bool1,
        shouldClose = bool3,
        canRetryInitial = bool4,
        canCompose = canCompose
    }
end

return getCommentsPanelState
