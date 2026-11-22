-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")

local _PostStatusRowView = require(script.Parent.PostStatusRowView)
local usePendingMomentRecord = require(Moments.Components.PostFeedback.usePendingMomentRecord)
local usePostingProgress = require(Moments.Components.PostFeedback.usePostingProgress)
local usePostFeedbackStrings = require(Moments.Components.PostFeedback.usePostFeedbackStrings)

local function usePostStatusRowViewModel(tbl1)
    local var1 = usePendingMomentRecord(tbl1.momentId)
    local status = if var1 == nil then nil else var1.status or "Posting"
    local var2 = usePostFeedbackStrings()
    local progress = usePostingProgress(if var1 == nil then nil else var1.startedAtClock)

    if status == "Moderated" then
        return {
            variant = "moderated",
            title = var2.moderatedTitle,
            body = var2.moderatedBody,
            LayoutOrder = tbl1.LayoutOrder
        }
    elseif status == "Posting" then
        return {
            variant = "posting",
            title = var2.postingTitle,
            body = var2.postingBody,
            progress = progress,
            LayoutOrder = tbl1.LayoutOrder
        }
    end

    return nil
end

return usePostStatusRowViewModel
