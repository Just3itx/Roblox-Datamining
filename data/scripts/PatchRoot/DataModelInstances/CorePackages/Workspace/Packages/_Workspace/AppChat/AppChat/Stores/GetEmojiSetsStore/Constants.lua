-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local ReactionType = require(AppChatParent.Reactions).Enums.ReactionType

return {
    PICKER_REACTION_ORDER = {
        ReactionType.ThumbsUp,
        ReactionType.Heart,
        ReactionType.LaughJoy,
        ReactionType.Wow,
        ReactionType.Cry,
        ReactionType.Fire,
        ReactionType.Skull
    }
}
