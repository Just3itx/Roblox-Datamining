-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local _CommentRowView = require(script.Parent.CommentRowView)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    report = "Feature.Moments.Action.Report",
    block = "Feature.Moments.Action.Block",
    delete = "Feature.Moments.Action.Delete"
}

local function useCommentActionsMenu(tbl2)
    local var1 = useLocalization(tbl1)
    local report = var1.report
    local block = var1.block
    local delete = var1.delete

    local var2, var3 = React.useState(nil)
    local var4, var5 = React.useState(nil)
    local commentId = tbl2.commentId

    React.useLayoutEffect(function()
        var3(nil)
        var5(nil)
    end, { commentId })
    local authorUserId = tbl2.authorUserId
    local onReportComment = tbl2.onReportComment
    local onBlockCommentAuthor = tbl2.onBlockCommentAuthor
    local onDeleteComment = tbl2.onDeleteComment
    local bool1 = not tbl2.isAuthoredByViewer

    if bool1 then
        if authorUserId == nil then
            bool1 = false
        else
            bool1 = onReportComment ~= nil
        end
    end

    local bool2 = not tbl2.isAuthoredByViewer

    if bool2 then
        if authorUserId == nil then
            bool2 = false
        else
            bool2 = onBlockCommentAuthor ~= nil
        end
    end

    local var6 = tbl2.isAuthoredByViewer and onDeleteComment ~= nil

    local openMenu = React.useCallback(function()
        var3(commentId)
    end, { commentId })
    local closeMenu = React.useCallback(function()
        var3(nil)
    end, {})
    local toggleMenu = React.useCallback(function()
        var3(function(str1: string?)
            return if str1 == commentId then nil else commentId
        end)
    end, { commentId })
    local onActivated = React.useCallback(function()
        var3(nil)
        if onReportComment ~= nil and authorUserId ~= nil then
            onReportComment(commentId, authorUserId)
        end
    end, { onReportComment, commentId, authorUserId })
    local var7 = React.useCallback(function()
        var3(nil)
        if onBlockCommentAuthor ~= nil and authorUserId ~= nil then
            onBlockCommentAuthor(commentId, authorUserId)
        end
    end, { onBlockCommentAuthor, commentId, authorUserId })
    local var8 = React.useCallback(function()
        var3(nil)
        var5(commentId)
    end, { commentId })
    local onConfirm = React.useCallback(function()
        var5(nil)
        if onDeleteComment ~= nil and var4 ~= nil then
            onDeleteComment(var4)
        end
    end, { onDeleteComment, var4 })
    local onCancel = React.useCallback(function()
        var5(nil)
    end, {})

    return {
        items = React.useMemo(function()
            local result = {}
            if bool1 then
                table.insert(result, { id = "report", text = report, onActivated = onActivated })
            end

            if bool2 then
                table.insert(result, { id = "block", text = block, onActivated = var7 })
            end

            if var6 then
                table.insert(result, { id = "delete", text = delete, onActivated = var8 })
            end

            return result
        end, {
            bool1,
            bool2,
            var6,
            onActivated,
            var7,
            var8,
            report,
            block,
            delete
        }),
        isOpen = var2 == commentId,
        openMenu = openMenu,
        closeMenu = closeMenu,
        toggleMenu = toggleMenu,
        deleteConfirmation = if var6 then var4 == commentId and {
            onConfirm = onConfirm,
            onCancel = onCancel
        } or nil else nil
    }
end

return useCommentActionsMenu
