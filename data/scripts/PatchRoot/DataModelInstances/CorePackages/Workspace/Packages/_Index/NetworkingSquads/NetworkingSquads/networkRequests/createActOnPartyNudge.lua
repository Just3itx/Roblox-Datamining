-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SQUAD_URL = require(script.Parent.Parent.SQUAD_URL)
local _networkingSquadTypes = require(script.Parent.Parent.networkingSquadTypes)

return function(arg1)
    return (arg1.roduxNetworking.POST("ActOnPartyNudge", function(arg2, arg3)
        local var1 = arg2(SQUAD_URL):path("group-up"):path("v1"):path("act-on-party-nudge")
        local tbl1 = {
            action = arg3.action,
            nudgeId = arg3.nudgeId,
            squadId = arg3.squadId,
            leaveExisting = arg3.leaveExisting,
            partyAttemptId = arg3.partyAttemptId,
            squadLocation = arg3.squadLocation,
            parentChannelId = arg3.parentChannelId,
            universeId = if game.GameId > 0 then game.GameId else nil,
            placeId = if game.PlaceId > 0 then game.PlaceId else nil,
            gameInstanceId = if game.JobId == "" then nil else game.JobId
        }
        return var1:body(tbl1)
    end))
end
