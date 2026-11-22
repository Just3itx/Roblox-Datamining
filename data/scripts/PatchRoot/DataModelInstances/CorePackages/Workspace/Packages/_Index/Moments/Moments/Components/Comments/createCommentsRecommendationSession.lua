-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)

local function createCommentsRecommendationSession(callback: (...any) -> (...any), arg1, momentsSessionId: string, func1: ((...any) -> (...any))?)
    local var1 = func1 or os.clock
    local var2 = table.clone(arg1)
    local var3 = nil
    local bool1 = false

    return {
        startView = function()
            if not bool1 and var3 == nil then
                var3 = var1()
            end
        end,
        finishView = function()
            local var4 = var3
            var3 = nil
            if var4 == nil or bool1 then
                return
            end
            callback(
                "CommentSectionOpen",
                var2,
                {
                    momentsSessionId = momentsSessionId,
                    commentSectionOpenDurationSeconds = math.max(0, var1() - var4)
                }
            )
        end,
        cancel = function()
            bool1 = true
            var3 = nil
        end,
        logComment = function(commentText: string?)
            if not bool1 then
                callback("Comment", var2, { momentsSessionId = momentsSessionId, commentText = commentText })
            end
        end,
        logCommentDelete = function()
            if not bool1 then
                callback("CommentDelete", var2, { momentsSessionId = momentsSessionId })
            end
        end
    }
end

return createCommentsRecommendationSession
