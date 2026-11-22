-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local MomentType = require(MomentsCreation.Enums.MomentType)

return function(arg1): boolean
    return type(arg1) == "table" and arg1.MomentType == MomentType.Avatar
end
