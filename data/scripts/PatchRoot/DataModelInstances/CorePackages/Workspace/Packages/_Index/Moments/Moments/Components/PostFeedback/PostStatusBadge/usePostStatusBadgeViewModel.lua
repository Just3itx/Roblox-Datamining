-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")

local _PostStatusBadgeView = require(script.Parent.PostStatusBadgeView)
local usePendingMomentRecord = require(Moments.Components.PostFeedback.usePendingMomentRecord)
local usePostFeedbackStrings = require(Moments.Components.PostFeedback.usePostFeedbackStrings)

local function usePostStatusBadgeViewModel(tbl1)
    local var1 = usePendingMomentRecord(tbl1.momentId)
    local status = if var1 == nil then nil else var1.status or "Posting"
    local var2 = usePostFeedbackStrings()

    if status == "Moderated" then
        return {
            label = var2.moderatedBadge,
            ZIndex = tbl1.ZIndex
        }
    elseif status == "Posting" then
        return {
            label = var2.postingBadge,
            ZIndex = tbl1.ZIndex
        }
    end

    return nil
end

return usePostStatusBadgeViewModel
