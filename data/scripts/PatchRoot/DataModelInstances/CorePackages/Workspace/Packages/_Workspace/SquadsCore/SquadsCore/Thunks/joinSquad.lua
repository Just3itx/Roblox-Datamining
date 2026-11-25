-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local leaveSquad = require(script.Parent.leaveSquad)

local logInExpCoplayTelemetry = require(SquadsCore.Analytics.logInExpCoplayTelemetry)
local SquadCoplayJoin = require(SquadsCore.Enums.SquadCoplayJoin)
local _SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)

local Promise = require(SquadsCoreParent.Promise)
local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = require(SquadsCoreParent.SharedFlags).FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

local function func1(squadId: string, callback: (...any) -> (...any), func2: (...any) -> (...any), squadLocation) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg1)
        return arg1:dispatch(
            NetworkingSquads.JoinSquad.API({ squadId = squadId, leaveExisting = true, squadLocation = squadLocation })
        ):andThen(
            function(arg2)
                local groupUpId = arg2.responseBody.groupUp.groupUpId
                local members = arg2.responseBody.groupUp.members

                if groupUpId and members then
                    logInExpCoplayTelemetry(groupUpId, members, squadLocation, SquadCoplayJoin.PartyJoin, func2)
                end
            end
        ):catch(
            function(_)
                callback(arg1, { hideCancelButton = true, promptType = SquadPromptType.Error })
            end
        )
    end
end

return function(squadId: string, callback: (...any) -> (...any), func2: (...any) -> (...any), squadLocation, bool1: boolean)
    return function(arg1)
        local state = arg1:getState()
        local squadId2 = state.Squad and state.Squad.Squad and state.Squad.Squad.currentSquad and state.Squad.Squad.currentSquad.squadId

        if squadId2 == squadId then
            callback(arg1, { hideCancelButton = true, promptType = SquadPromptType.AlreadyJoined })

            return Promise.resolve({})
        elseif not squadId2 then
            return arg1:dispatch((func1(squadId, callback, func2, squadLocation)))
        else
            return arg1:dispatch(leaveSquad(SquadPromptType.JoinAnotherSquad, callback, function()
                local func3 = func1(squadId, callback, func2, squadLocation)
                arg1:dispatch(func3)
            end, squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or bool1))
        end
    end
end
