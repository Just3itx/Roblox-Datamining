-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.GET("CheckMomentsEligibility", function(arg1, tbl2)
        return arg1(API_URL):path("content-captures-api"):path("v1"):path("check-moments-eligibility"):queryArgs(
            {
                contentType = tbl2.contentType,
                experienceId = tbl2.experienceId
            }
        )
    end)
end
