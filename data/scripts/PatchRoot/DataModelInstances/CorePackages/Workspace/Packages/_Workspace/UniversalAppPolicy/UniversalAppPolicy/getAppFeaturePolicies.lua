-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalAppGetPolicy = require(script.Parent.UniversalAppGetPolicy)
local AppFeaturePolicies = require(script.Parent.AppFeaturePolicies)

return function()
    local var1 = UniversalAppGetPolicy.read() or {}
    return AppFeaturePolicies(var1)
end
