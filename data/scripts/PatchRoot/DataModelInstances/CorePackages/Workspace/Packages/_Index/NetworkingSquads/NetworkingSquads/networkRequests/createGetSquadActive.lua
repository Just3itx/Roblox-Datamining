-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    local roduxNetworking = arg1.roduxNetworking

    local var1 = nil
    local var2 = roduxNetworking.GET("GetSquadActive", function(arg2, arg3)
        if arg1.useMockedResponse then
            var1 = {
                responseBody = {
                    groupUp = arg3.mockedSquad
                }
            }
        end

        return arg2(SQUAD_URL):path("group-up"):path("v1"):path("active-status")
    end)

    if arg1.useMockedResponse then
        var2.Mock.clear()
        var2.Mock.reply(function()
            return var1
        end)
    end

    return var2
end
