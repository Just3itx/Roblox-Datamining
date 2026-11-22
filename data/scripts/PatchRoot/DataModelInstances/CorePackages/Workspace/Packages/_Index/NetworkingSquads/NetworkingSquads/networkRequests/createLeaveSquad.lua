-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    local var1 = arg1.roduxNetworking.POST("LeaveSquad", function(arg2, arg3)
        return arg2(SQUAD_URL):path("group-up"):path("v1"):path("leave"):body({ groupUpId = arg3.squadId })
    end)

    if arg1.useMockedResponse then
        var1.Mock.clear()
        var1.Mock.reply(function()
            return {
                responseBody = {}
            }
        end)
    end

    return var1
end
