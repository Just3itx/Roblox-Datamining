-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local API_URL = require(scriptParentParent.API_URL)
local _networkingShareLinkTypes = require(scriptParentParent.networkingShareLinkTypes)

return function(arg1)
    local var1 = arg1.roduxNetworking.POST("get-metadata", function(arg2, arg3)
        return arg2(API_URL):path("sharelinks"):path("v1"):path("get-metadata"):body(
            {
                linkType = arg3.linkType,
                linkId = arg3.linkId
            }
        )
    end)

    if arg1.useMockedResponse then
        var1.Mock.clear()
        var1.Mock.reply(function()
            return {
                responseBody = { data = "{ \"universeId\": 123, \"placeId\": 456 }" }
            }
        end)
    end

    return var1
end
