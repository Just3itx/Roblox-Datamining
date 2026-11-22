-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

return {
    REACTED_REACTION_SIZE = require(MomentsParent.MomentsCommon).Enums.ReactionSize.Medium,
    EXPLOSION_LAYER_ZINDEX = 4,
    MAX_CONCURRENT_EXPLOSIONS = 3
}
