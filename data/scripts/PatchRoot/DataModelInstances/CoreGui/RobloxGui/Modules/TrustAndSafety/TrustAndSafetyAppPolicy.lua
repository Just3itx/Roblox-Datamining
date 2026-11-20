-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PolicyProvider = require(CorePackages.Packages.PolicyProvider)

local var1 = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")
local var2 = PolicyProvider.withGetPolicyImplementation(var1)

function var2.Mapper(_)
    return {}
end

return var2
