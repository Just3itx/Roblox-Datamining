-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local API_URL = require(scriptParentParent.API_URL)
local _networkingShareLinkTypes = require(scriptParentParent.networkingShareLinkTypes)

return function(arg1)
    return (arg1.roduxNetworking.POST("resolve", function(arg2, arg3)
        return arg2(API_URL):path("deeplinks"):path("v2"):path("resolve"):body(
            {
                linkId = arg3.linkId,
                skipFilterCheck = arg3.skipFilterCheck
            }
        )
    end))
end
