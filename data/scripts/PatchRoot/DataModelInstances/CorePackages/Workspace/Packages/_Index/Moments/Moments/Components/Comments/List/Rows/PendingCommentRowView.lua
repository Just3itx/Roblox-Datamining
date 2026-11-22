-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local CommentRowView = require(script.Parent.CommentRow.CommentRowView)

local useLocalization = Localization.Hooks.useLocalization

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local tbl1 = {
    retry = "Feature.Moments.Action.Retry",
    edit = "Feature.Moments.Action.Edit",
    sending = "Feature.Moments.Label.CommentSending",
    sendStatusUnknown = "Feature.Moments.Label.CommentSendStatusUnknown"
}

local function PendingCommentRowView(tbl2)
    local var1 = useLocalization(tbl1)
    local num1 = if tbl2.status == "Sending" then 0.5 else 0
    local groupTransparency, var3 = React.useBinding(num1)
    React.useEffect(function()
        var3(num1)
    end, { num1 })

    local element

    if tbl2.status == "OutcomeUnknown" and tbl2.onEdit ~= nil then
        element = React.createElement(Foundation.View, {
            tag = "row align-y-center gap-small auto-xy"
        }, {
            Retry = if tbl2.onRetry == nil then nil else React.createElement(Foundation.Button, {
                LayoutOrder = 1,
                text = var1.retry,
                size = InputSize.XSmall,
                variant = ButtonVariant.Link,
                onActivated = tbl2.onRetry,
                testId = `moments-comment-retry-{tbl2.rowKey}`
            }),
            Edit = React.createElement(Foundation.Button, {
                LayoutOrder = 2,
                text = var1.edit,
                size = InputSize.XSmall,
                variant = ButtonVariant.Link,
                onActivated = tbl2.onEdit,
                testId = `moments-comment-edit-{tbl2.rowKey}`
            })
        })
    else
        element = nil
    end

    local createElement = React.createElement
    local var4 = CommentRowView
    local tbl3 = {
        LayoutOrder = tbl2.LayoutOrder,
        commentId = tbl2.rowKey,
        avatarUserId = nil,
        authorLabel = tbl2.viewerUsername,
        isAuthorLoading = false,
        text = tbl2.text,
        metadataLabel = if tbl2.status == "Sending" then var1.sending else var1.sendStatusUnknown,
        avatarBackgroundStyle = tbl2.avatarBackgroundStyle,
        GroupTransparency = groupTransparency,
        headerAction = 0
    }

    if element == nil then
        if tbl2.status == "OutcomeUnknown" and tbl2.onRetry ~= nil then
            element = React.createElement(Foundation.Button, {
                text = var1.retry,
                size = InputSize.XSmall,
                variant = ButtonVariant.Link,
                onActivated = tbl2.onRetry,
                testId = `moments-comment-retry-{tbl2.rowKey}`
            })
        else
            element = nil
        end
    end

    tbl3.headerAction = element
    return createElement(var4, tbl3)
end

return PendingCommentRowView
