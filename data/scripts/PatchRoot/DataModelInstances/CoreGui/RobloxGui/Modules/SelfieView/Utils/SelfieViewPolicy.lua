-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PolicyProvider = require(CorePackages.Packages.PolicyProvider)

local PolicyImplementation = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")
local var2 = PolicyProvider.withGetPolicyImplementation(PolicyImplementation)

function var2.Mapper(arg1)
    return {
        eligibleForSelfieViewFeature = function()
            return arg1.EligibleForSelfieViewFeature or false
        end
    }
end

var2.PolicyImplementation = PolicyImplementation

return var2
