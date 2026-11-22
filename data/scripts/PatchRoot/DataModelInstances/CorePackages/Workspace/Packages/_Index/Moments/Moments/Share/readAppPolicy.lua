-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local var1 = require(MomentsParent.PolicyProvider).GetPolicyImplementations.MemStorageService("app-policy")

return function()
    return var1.read()
end
