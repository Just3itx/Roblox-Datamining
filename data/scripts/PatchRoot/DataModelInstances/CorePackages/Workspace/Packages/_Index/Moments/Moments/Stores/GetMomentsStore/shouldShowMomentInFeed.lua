-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentStatus = require(MomentsParent.MomentsTypes).Enums.MomentStatus

local function shouldShowMomentInFeed(arg1): boolean
    return not (arg1.status == MomentStatus.Deleted) and arg1.isModerated ~= true
end

return shouldShowMomentInFeed
