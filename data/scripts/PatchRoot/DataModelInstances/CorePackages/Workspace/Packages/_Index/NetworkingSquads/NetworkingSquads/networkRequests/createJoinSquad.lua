-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    local roduxNetworking = arg1.roduxNetworking

    local var1 = nil
    local var2 = roduxNetworking.POST("JoinSquad", function(arg2, arg3)
        if arg1.useMockedResponse then
            var1 = {
                responseBody = {
                    groupUp = {
                        groupUpId = arg3.squadId,
                        initiatorId = 3447631062,
                        createdAtTime = tostring(os.clock() * 1000),
                        updatedAtTime = tostring(os.clock() * 1000),
                        parentChannelId = arg3.parentChannelId,
                        members = {
                            { userId = 3447631062, rank = 0 },
                            { userId = 2591622000, rank = 1 },
                            { userId = 3447649029, rank = 2 },
                            { userId = 3447641701, rank = 3 },
                            { userId = 3447635964, rank = 4 },
                            { userId = 3447642362, rank = 5 }
                        }
                    }
                }
            }
        end

        return arg2(SQUAD_URL):path("group-up"):path("v1"):path("join"):body(
            {
                groupUpId = arg3.squadId,
                leaveExisting = arg3.leaveExisting,
                squadLocation = arg3.squadLocation
            }
        )
    end)

    if arg1.useMockedResponse then
        var2.Mock.clear()
        var2.Mock.reply(function()
            return var1
        end)
    end

    return var2
end
