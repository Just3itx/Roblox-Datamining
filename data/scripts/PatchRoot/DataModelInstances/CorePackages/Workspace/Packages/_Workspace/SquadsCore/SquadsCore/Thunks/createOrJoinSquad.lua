-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local logInExpCoplayTelemetry = require(SquadsCore.Analytics.logInExpCoplayTelemetry)
local SquadCoplayJoin = require(SquadsCore.Enums.SquadCoplayJoin)
local _SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)

return function(parentChannelId: string, callback: (...any) -> (...any), func1: (...any) -> (...any), squadLocation, partyAttemptId: string?, onConfirm: ((...any) -> (...any))?, scheduledSquadId: string?)
    return function(arg1)
        return arg1:dispatch(
            NetworkingSquads.CreateOrJoinSquad.API({
                parentChannelId = parentChannelId,
                leaveExisting = true,
                squadLocation = squadLocation,
                partyAttemptId = partyAttemptId,
                scheduledSquadId = scheduledSquadId
            })
        ):andThen(
            function(arg2)
                local groupUpId = arg2.responseBody.groupUp.groupUpId
                local members = arg2.responseBody.groupUp.members

                if groupUpId and members then
                    logInExpCoplayTelemetry(groupUpId, members, squadLocation, SquadCoplayJoin.PartyJoin, func1)
                end
            end
        ):catch(
            function(_)
                callback(arg1, { hideCancelButton = true, promptType = SquadPromptType.Error, onConfirm = onConfirm })
            end
        )
    end
end
