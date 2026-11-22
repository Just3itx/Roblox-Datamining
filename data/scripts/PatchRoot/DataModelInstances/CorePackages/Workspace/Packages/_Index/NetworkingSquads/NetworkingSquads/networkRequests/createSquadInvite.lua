-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    local roduxNetworking = arg1.roduxNetworking

    local var1 = nil
    local var2 = roduxNetworking.POST("SquadInvite", function(arg2, arg3)
        if arg1.useMockedResponse then
            var1 = {
                responseBody = {
                    channelUpgraded = false,
                    parentChannelId = arg3.parentChannelId,
                    results = {{
                        userId = 3447631062,
                        resultStatus = { resultType = "success", message = "message" }
                    }}
                }
            }
        end

        return arg2(SQUAD_URL):path("group-up"):path("v1"):path("invite"):body({
            groupUpId = arg3.squadId,
            invitedUserIds = arg3.invitedUserIds,
            parentChannelId = arg3.parentChannelId,
            isReparented = arg3.isReparented,
            requestId = HttpService:GenerateGUID()
        })
    end)

    if arg1.useMockedResponse then
        var2.Mock.clear()
        var2.Mock.reply(function()
            return var1
        end)
    end

    return var2
end
