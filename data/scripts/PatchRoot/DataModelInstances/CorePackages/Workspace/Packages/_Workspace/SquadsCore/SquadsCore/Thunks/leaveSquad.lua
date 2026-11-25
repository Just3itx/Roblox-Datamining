-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Logger = require(SquadsCore.Logger)
local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local _SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local SquadRccEventManager = require(SquadsCore.ServiceManager.SquadRccEventManager)

local Promise = require(SquadsCoreParent.Promise)

local CurrentSquadUpdated = require(SquadsCore.RoduxSquads).Actions.CurrentSquadUpdated
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)

local GetExperienceInviteRetryAfterStore = require(SquadsCore.Stores.GetExperienceInviteRetryAfterStore)

return function(promptType, func1: (...any) -> (...any), callback: ((...any) -> (...any))?, inExperience: string, bool1: boolean)
    return function(arg1)
        local state = arg1:getState()
        local squadId = state.Squad and state.Squad.Squad and state.Squad.Squad.currentSquad and state.Squad.Squad.currentSquad.squadId

        if not squadId then
            return Promise.resolve()
        end

        local function onConfirm()
            if callback then
                callback()
            end

            if inExperience == SquadLocationEnum.InExperience then
                SquadRccEventManager:setLeaveSquadPendingAndFireEvent(true, bool1)
            end

            GetExperienceInviteRetryAfterStore(false).unblock(squadId)

            arg1:dispatch(CurrentSquadUpdated(nil))
            arg1:dispatch(NetworkingSquads.LeaveSquad.API({ squadId = squadId })):andThen(function()
                if inExperience == SquadLocationEnum.InExperience then
                    SquadRccEventManager:setLeaveSquadPendingAndFireEvent(false, bool1)
                end
            end):catch(function(arg2)
                Logger:error("Error occured with NetworkingSquads.LeaveSquad: {}", tostring(arg2))
            end)
        end

        if promptType then
            return func1(arg1, { onConfirm = onConfirm, promptType = promptType })
        end

        onConfirm()
        return Promise.resolve()
    end
end
