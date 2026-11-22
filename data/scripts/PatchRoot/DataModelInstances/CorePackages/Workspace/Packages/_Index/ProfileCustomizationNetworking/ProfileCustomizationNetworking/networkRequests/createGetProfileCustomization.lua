-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("GetProfileCustomization", function(arg1, tbl2)
        local tbl3 = {
            profileEntities = { tbl2.profileEntity }
        }

        return arg1(API_URL):path("profile-platform-api"):path("v1"):path("profiles"):path("customization"):path("get"):body(tbl3)
    end)
end
