-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PREMIUM_FEATURES_URL = require(script.Parent.Parent.PREMIUM_FEATURES_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetUserPremiumMembershipStatus" }, function(arg2, arg3)
        return arg2(PREMIUM_FEATURES_URL):path("v1"):path("users"):id(arg3):path("validate-membership")
    end)
end
