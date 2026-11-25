-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local Roact = require(RoactUtilsParent.Roact)

local function validateWithRefForwarding(arg1)
    arg1.forwardRef = arg1[Roact.Ref]
    arg1[Roact.Ref] = nil
    return arg1
end

return validateWithRefForwarding
