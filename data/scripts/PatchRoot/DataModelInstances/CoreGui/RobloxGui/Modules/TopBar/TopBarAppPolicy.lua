-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PolicyProvider = require(CorePackages.Packages.PolicyProvider)

local FFlagShowGameAgeRating = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowGameAgeRating

local var1 = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")
local var2 = PolicyProvider.withGetPolicyImplementation(var1)

function var2.Mapper(arg1)
    return {
        showBadgeOver12 = not FFlagShowGameAgeRating and function()
            return arg1.ShowBadgeOver12 or false
        end or nil
    }
end

return var2
