-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local leaveSquad = require(script.Parent.leaveSquad)

local Constants = require(SquadsCore.Common.Constants)
local logInExpCoplayTelemetry = require(SquadsCore.Analytics.logInExpCoplayTelemetry)
local SquadCoplayJoin = require(SquadsCore.Enums.SquadCoplayJoin)
local _SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)

local Promise = require(SquadsCoreParent.Promise)
local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = require(SquadsCoreParent.SharedFlags).FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

local function func1(action: string, nudgeId: string, callback: (...any) -> (...any), func2: (...any) -> (...any), squadLocation, partyAttemptId: string?, parentChannelId: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg1)
        return arg1:dispatch(
            NetworkingSquads.ActOnPartyNudge.API({
                action = action,
                nudgeId = nudgeId,
                leaveExisting = true,
                partyAttemptId = partyAttemptId,
                squadLocation = squadLocation,
                parentChannelId = parentChannelId
            })
        ):andThen(
            function(arg2)
                if action ~= Constants.ACCEPT_START_PARTY_REQUEST_ACTION and action ~= Constants.ACCEPT_PARTY_INVITE_ACTION then
                    return
                end

                local groupUpId = arg2.responseBody.groupUp.groupUpId
                local members = arg2.responseBody.groupUp.members

                if groupUpId and members then
                    local var1 = if action == Constants.ACCEPT_START_PARTY_REQUEST_ACTION then SquadCoplayJoin.SquadNudgeCreation else SquadCoplayJoin.SquadNudgeJoin
                    logInExpCoplayTelemetry(groupUpId, members, squadLocation, var1, func2)
                end
            end
        ):catch(
            function(_)
                if action == Constants.ACCEPT_START_PARTY_REQUEST_ACTION or action == Constants.ACCEPT_PARTY_INVITE_ACTION then
                    callback(arg1, { hideCancelButton = true, promptType = SquadPromptType.Error })
                end
            end
        )
    end
end

return function(action: string, nudgeId: string, bool1: boolean, callback: (...any) -> (...any), func2: (...any) -> (...any), squadLocation, bool2: boolean, partyAttemptId: string?, parentChannelId: string?)
    return function(arg1)
        local state = arg1:getState()
        local squadId = state.Squad and state.Squad.Squad and state.Squad.Squad.currentSquad and state.Squad.Squad.currentSquad.squadId

        if not squadId or squadId == "" or not bool1 then
            return arg1:dispatch((func1(action, nudgeId, callback, func2, squadLocation, partyAttemptId, parentChannelId)))
        end

        return Promise.new(function(arg2, arg3)
            arg1:dispatch(leaveSquad(SquadPromptType.JoinAnotherSquad, callback, function()
                local func3 = func1(action, nudgeId, callback, func2, squadLocation, partyAttemptId, parentChannelId)
                arg1:dispatch(func3):andThen(arg2):catch(arg3)
            end, squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or bool2))
        end)
    end
end
