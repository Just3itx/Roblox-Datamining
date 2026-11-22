-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local createSignal = require(MomentsParent.Signals).createSignal

local function createDeepLinkStore()
    local getDeepLinkedMomentId, var2 = createSignal(nil)

    local getDeepLinkedMomentTargetIdType, var4 = createSignal(nil)

    local getPendingCommentsTarget, var6 = createSignal(nil)

    return {
        getDeepLinkedMomentId = getDeepLinkedMomentId,
        getDeepLinkedMomentTargetIdType = getDeepLinkedMomentTargetIdType,
        getPendingCommentsTarget = getPendingCommentsTarget,
        setDeepLinkedMomentId = function(str1: string?)
            var2(str1)
            var4(nil)

            if str1 ~= nil then
                var6(nil)
            end
        end,
        setDeepLinkedMoment = function(deepLinkId: string?, str1: string?, tbl1)
            var2(deepLinkId)
            local var7 = var4

            if deepLinkId == nil then
                str1 = nil
            end

            var7(str1)

            if deepLinkId == nil then
                return
            end

            var6(tbl1 ~= nil and { deepLinkId = deepLinkId, feedItemId = nil, commentId = tbl1.commentId } or nil)
        end,
        resolvePendingCommentsTarget = function(deepLinkId: string, feedItemId: string?)
            local var7 = getPendingCommentsTarget(false)
            if var7 == nil or var7.deepLinkId ~= deepLinkId then
                return
            end
            var6(
                feedItemId ~= nil
                    and feedItemId ~= ""
                    and {
                        deepLinkId = deepLinkId,
                        feedItemId = feedItemId,
                        commentId = var7.commentId
                    }
                    or nil
            )
        end,
        takeCommentsTarget = function(feedItemId: string)
            local var7 = getPendingCommentsTarget(false)
            if var7 == nil or var7.feedItemId == nil or var7.feedItemId ~= feedItemId then
                return nil
            end
            var6(nil)
            return {
                commentId = var7.commentId
            }
        end
    }
end

return createDeepLinkStore
