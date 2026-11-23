-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("SetUserProfileSettings", function(arg1, tbl2)
        return arg1(API_URL):path("user-profile-api"):path("v1"):path("user"):path("profiles"):path("settings"):body(
            {
                userProfileSettings = {
                    isInExperienceNameEnabled = tbl2.isInExperienceNameEnabled
                }
            }
        )
    end)
end
