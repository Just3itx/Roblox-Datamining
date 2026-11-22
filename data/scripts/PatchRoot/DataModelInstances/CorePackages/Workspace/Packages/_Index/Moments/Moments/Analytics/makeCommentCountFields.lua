-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function makeCommentCountFields(arg1)
    if arg1 == nil or arg1.count == nil then
        return {}
    end
    return {
        totalCommentCount = tostring(arg1.count)
    }
end

return makeCommentCountFields
