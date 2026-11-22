-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local FoundationCloudAssets = require(MomentsParent.FoundationCloudAssets)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local CommentsListSkeletonView = require(Moments.Components.Comments.List.CommentsListSkeletonView)

local useLocalization = Localization.Hooks.useLocalization

local Button = Foundation.Button
local Empty = Foundation.Empty
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local tbl1 = {
    empty = "Feature.Moments.Label.NoCommentsYet",
    emptyInvite = "Feature.Moments.Label.FirstCommentInvite",
    disabled = "Feature.Moments.Label.CommentsDisabled",
    unavailable = "Feature.Moments.Label.CommentsUnavailable",
    retry = "Feature.Moments.Action.Retry"
}

FoundationCloudAssets.preloadAsset("pictograms/chat")

local function CommentsPanelStateView(tbl2)
    local var1 = useLocalization(tbl1)

    if tbl2.state == "loading" then
        return React.createElement(CommentsListSkeletonView, { testId = `moments-comments-state-{tbl2.state}` })
    elseif tbl2.state == "empty" then
        return React.createElement(Empty, {
            icon = {
                name = "pictograms/chat",
                size = IconSize.XXLarge
            },
            text = if tbl2.isReadOnly then var1.empty else var1.emptyInvite,
            testId = `moments-comments-state-{tbl2.state}`
        })
    end

    return React.createElement(
        View,
        {
            tag = "col gap-medium size-full-0 auto-y",
            testId = `moments-comments-state-{tbl2.state}`
        },
        {
            Message = React.createElement(FoundationText, { Text = var1[tbl2.state], tag = "auto-xy text-body-medium content-emphasis" }),
            Retry = if tbl2.onRetry == nil then nil else React.createElement(
                Button,
                {
                    text = var1.retry,
                    onActivated = tbl2.onRetry,
                    size = InputSize.Small,
                    variant = ButtonVariant.Standard
                }
            )
        }
    )
end

return CommentsPanelStateView
