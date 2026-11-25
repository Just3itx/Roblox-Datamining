-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsellParent = script:FindFirstAncestor("SocialUpsell").Parent

local Cryo = require(SocialUpsellParent.Cryo)

local tbl1 = {}

return function(arg1, arg2)
    return Cryo.Dictionary.join(arg1 or tbl1, { isInExperience = if arg2 then arg2.isInExperience else false })
end
