-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local useLocalization = require(MomentsParent.Localization).Hooks.useLocalization

local tbl1 = {
    postingSnackbar = "Feature.Moments.Label.PostFeedbackPostingSnackbar",
    postingTitle = "Feature.Moments.Label.PostFeedbackPostingTitle",
    postingBody = "Feature.Moments.Label.PostFeedbackPostingBody",
    postingBadge = "Feature.Moments.Label.PostFeedbackPostingBadge",
    moderatedBadge = "Feature.Moments.Label.PostFeedbackModeratedBadge",
    liveTitle = "Notifications.Moments.Title.MomentPostSuccess",
    liveBody = "Notifications.Moments.Body.MomentPostSuccess",
    failedTitle = "Notifications.Moments.Title.MomentPostFailed",
    failedBody = "Notifications.Moments.Body.MomentPostFailed",
    moderatedTitle = "Notifications.Moments.Title.MomentPostModerated",
    moderatedBody = "Notifications.Moments.Body.MomentPostModerated",
    share = "Feature.SocialShare.Action.Share",
    dismiss = "CommonUI.Messages.Action.Dismiss"
}

local function usePostFeedbackStrings()
    local var1 = useLocalization(tbl1)
    return {
        postingSnackbar = var1.postingSnackbar,
        postingTitle = var1.postingTitle,
        postingBody = var1.postingBody,
        moderatedTitle = var1.moderatedTitle,
        moderatedBody = var1.moderatedBody,
        postingBadge = var1.postingBadge,
        moderatedBadge = var1.moderatedBadge,
        liveTitle = var1.liveTitle,
        liveBody = var1.liveBody,
        failedTitle = var1.failedTitle,
        failedBody = var1.failedBody,
        share = var1.share,
        dismiss = var1.dismiss
    }
end

return usePostFeedbackStrings
