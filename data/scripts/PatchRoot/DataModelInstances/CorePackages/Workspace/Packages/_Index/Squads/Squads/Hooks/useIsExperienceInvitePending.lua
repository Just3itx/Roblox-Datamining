-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local dependencies = require(Squads.dependencies)

local NetworkingSquads = dependencies.NetworkingSquads
local NetworkStatus = dependencies.RoduxNetworking.Enum.NetworkStatus
local useSelector = dependencies.Hooks.useSelector
local useSignalState = require(SquadsParent.SignalsReact).useSignalState

local Hooks = require(SquadsParent.SquadsCore.Hooks)
local useCurrentSquadId = Hooks.useCurrentSquadId
local useIsExperienceInviteRetryBlocked = Hooks.useIsExperienceInviteRetryBlocked

local GetSquadExperienceInviteStore = require(SquadsParent.SquadsCore.Stores).GetSquadExperienceInviteStore

local FFlagUseSignalsForSquadExperienceInviteStatus = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInviteStatus
local FFlagUseSignalsForSquadExperienceInvite = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInvite

local function getCurrentSquadId(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local squad = arg1.Squad and arg1.Squad.Squad
    return squad and squad.currentSquad and squad.currentSquad.squadId
end

local function selectHasCurrentSquadId(arg1): boolean
    return getCurrentSquadId(arg1) ~= nil
end

local function selectIsCreateExperienceInviteFetching(arg1): boolean
    local currentSquadId = getCurrentSquadId(arg1)
    return not (currentSquadId == nil)
        and NetworkingSquads.CreateExperienceInvite.getStatus(arg1, currentSquadId) == NetworkStatus.Fetching
end

local function selectHasInFlightOrExistingInvite(arg1): boolean
    local currentSquadId = getCurrentSquadId(arg1)
    return if currentSquadId then NetworkingSquads.CreateExperienceInvite.getStatus(arg1, currentSquadId) == NetworkStatus.Fetching
        or arg1.Squad.Squad.currentExperienceInvite ~= nil else false
end

local function useIsExperienceInvitePending()
    local var1 = useCurrentSquadId()
    local var2 = useIsExperienceInviteRetryBlocked(var1)

    if not FFlagUseSignalsForSquadExperienceInviteStatus then
        return useSelector(function(arg1): boolean
            local squad = arg1.Squad and arg1.Squad.Squad
            local squadId = squad and squad.currentSquad and squad.currentSquad.squadId

            if not squadId then
                return false
            end

            if squad and squad.currentExperienceInviteStatus then
                return true
            end

            local status = NetworkingSquads.CreateExperienceInvite.getStatus(arg1, squadId)
            local currentExperienceInvite = squad and squad.currentExperienceInvite

            return not not (status == NetworkStatus.Fetching or currentExperienceInvite)
        end) or var2
    end

    local var3 = useSelector(selectHasCurrentSquadId)
    local var4

    if FFlagUseSignalsForSquadExperienceInvite then
        local var5 = useSelector(selectIsCreateExperienceInviteFetching)

        local var6 = useSignalState(GetSquadExperienceInviteStore(false).getHasCurrentExperienceInvite)
        var4 = var5 or var6
    else
        var4 = useSelector(selectHasInFlightOrExistingInvite)
    end
    local var5 = useSignalState(GetSquadExperienceInviteStore(false).getIsExperienceInvitePending)

    if var3 then
        var2 = var5 or var4 or var2
    end

    return var2
end

return useIsExperienceInvitePending
