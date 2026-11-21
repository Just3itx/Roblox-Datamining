-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("RemoveReaction", function(arg1, tbl2)
        return arg1(API_URL):path("posts-api"):path("v1"):path("content-posts"):path("removeReaction"):body(tbl2)
    end)
end
