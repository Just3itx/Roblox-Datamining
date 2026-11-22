-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.GET("GetSelfSocialLinks", function(arg1, tbl2)
        return arg1(API_URL):path("v1"):path("promotion-channels"):queryArgs(
            {
                alwaysReturnUrls = tbl2.alwaysReturnUrls,
                filterLink = tbl2.filterLink
            }
        )
    end)
end
