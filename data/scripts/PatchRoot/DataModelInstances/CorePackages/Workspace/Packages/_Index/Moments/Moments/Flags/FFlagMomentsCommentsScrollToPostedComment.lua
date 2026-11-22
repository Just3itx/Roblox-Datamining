-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

return game:DefineFastFlag("MomentsCommentsScrollToPostedComment", false)
    and require(MomentsParent.SharedFlags).FFlagMomentsComments
