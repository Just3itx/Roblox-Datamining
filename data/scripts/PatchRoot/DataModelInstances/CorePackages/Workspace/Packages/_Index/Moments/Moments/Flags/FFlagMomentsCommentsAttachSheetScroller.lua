-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local SharedFlags = require(MomentsParent.SharedFlags)

return game:DefineFastFlag("MomentsCommentsAttachSheetScroller", false) and SharedFlags.FFlagMomentsComments
