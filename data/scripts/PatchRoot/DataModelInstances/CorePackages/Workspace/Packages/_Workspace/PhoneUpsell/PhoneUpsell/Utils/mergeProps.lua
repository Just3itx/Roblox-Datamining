-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local Cryo = require(PhoneUpsellParent.Cryo)

local function mergeProps(arg1, arg2)
    return Cryo.Dictionary.join(arg1, arg2)
end

return mergeProps
