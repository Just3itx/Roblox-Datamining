-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SHARELINKS_URL = require(script.Parent.Parent.SHARELINKS_URL)
local _networkingShareLinkTypes = require(script.Parent.Parent.networkingShareLinkTypes)

return function(arg1)
    local var1 = arg1.roduxNetworking.POST({ Name = "resolve-link" }, function(arg2, arg3)
        return arg2(SHARELINKS_URL):path("v1"):path("resolve-link"):body({ linkType = arg3.linkType, linkId = arg3.linkId })
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
