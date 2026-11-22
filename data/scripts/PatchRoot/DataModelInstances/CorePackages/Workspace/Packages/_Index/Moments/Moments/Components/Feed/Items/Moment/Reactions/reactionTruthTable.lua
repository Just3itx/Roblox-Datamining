-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local ThumbsUp = require(MomentsParent.MomentsCommon).Enums.ReactionType.ThumbsUp

return {
    DEFAULT_REACTION = ThumbsUp,
    decide = function(effectReaction, str1: string, arg1)
        local bool1 = effectReaction ~= nil

        if str1 == "tapButton" then
            return if bool1 then { action = "clear", reaction = nil, effectReaction = nil } else {
                action = "commit",
                reaction = ThumbsUp,
                effectReaction = ThumbsUp
            }
        elseif str1 == "doubleTap" then
            return if bool1 then {
                action = "none",
                reaction = nil,
                effectReaction = effectReaction
            } else { action = "commit", reaction = ThumbsUp, effectReaction = ThumbsUp }
        end

        local var1 = arg1 or ThumbsUp
        return if bool1 and var1 == effectReaction then {
            action = "clear",
            reaction = nil,
            effectReaction = nil
        } else { action = "commit", reaction = var1, effectReaction = var1 }
    end
}
