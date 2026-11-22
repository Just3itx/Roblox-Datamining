-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local API_URL = require(scriptParentParent.API_URL)
local _networkingShareLinkTypes = require(scriptParentParent.networkingShareLinkTypes)

return function(arg1)
    local var1 = arg1.roduxNetworking.POST("resolve-link", function(arg2, arg3)
        return arg2(API_URL):path("sharelinks"):path("v1"):path("resolve-link"):body(
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
                responseBody = {
                    experienceInviteData = {
                        instanceId = "ABCDEF",
                        inviterId = 46430379,
                        placeId = 1818,
                        status = "Valid",
                        universeId = 13058
                    }
                }
            }
        end)
    end

    return var1
end
