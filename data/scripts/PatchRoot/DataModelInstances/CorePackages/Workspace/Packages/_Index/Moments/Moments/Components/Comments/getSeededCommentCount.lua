-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function getSeededCommentCount(arg1)
    return if arg1 == nil then nil else arg1.count
end

return getSeededCommentCount
