-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local RoduxSquadsParent = RoduxSquads.Parent
local Cryo = require(RoduxSquadsParent.Cryo)
local Rodux = require(RoduxSquadsParent.Rodux)
local CurrentSquadUpdated = require(RoduxSquads.Actions).CurrentSquadUpdated
local SelfPermissionUpdated = require(RoduxSquads.Actions).SelfPermissionUpdated
local SquadModel = require(RoduxSquads.Models).SquadModel
local PersistStorage = require(RoduxSquads.Persists.PersistStorage)
local createPersistReducer = require(RoduxSquads.Persists.PersistReducer).createPersistReducer

local _RoduxSquadsTypes = require(script.Parent.Parent.RoduxSquadsTypes)

local FFlagEnableSquadRegroupExperimentation = require(RoduxSquadsParent.SharedFlags).FFlagEnableSquadRegroupExperimentation

return function(arg1)
    local networkingSquads = arg1.NetworkingSquads
    local function func1(arg2, arg3)
        if arg2 == nil or arg2.squadId ~= arg3.squadId then
            if arg3.deletedAtTime and arg3.deletedAtTime ~= "" then
                return arg2
            end

            if not arg2 or arg2.parentChannelId ~= arg3.parentChannelId then
                return arg3
            end

            if arg2.createdAtTime < arg3.createdAtTime then
                return arg3
            end
        else
            if arg3.deletedAtTime and arg3.deletedAtTime ~= "" then
                return nil
            end

            if arg2.updatedAtTime < arg3.updatedAtTime then
                return arg3
            end

            if arg2.updatedAtTime == arg3.updatedAtTime then
                if arg2.parentChannelId ~= arg3.parentChannelId then
                    return arg3
                end

                local var1 = Cryo.List.sort(Cryo.List.map(arg2.members, function(arg4)
                    return arg4.userId
                end))
                local var2 = Cryo.List.sort(Cryo.List.map(arg3.members, function(arg4)
                    return arg4.userId
                end))

                local var3 = Cryo.List.sort(Cryo.List.map(arg2.invitees, function(arg4): string
                    return tostring(arg4.userId) .. tostring(arg4.invitedAtTimestampMs)
                end))

                local var4 = Cryo.List.sort(Cryo.List.map(arg3.invitees, function(arg4): string
                    return tostring(arg4.userId) .. tostring(arg4.invitedAtTimestampMs)
                end))

                if not (Cryo.List.equals(var1, var2) and Cryo.List.equals(var3, var4)) then
                    return arg3
                end

                if FFlagEnableSquadRegroupExperimentation then
                    local selfPermissions = arg2.selfPermissions
                    local selfPermissions2 = arg3.selfPermissions
                    if selfPermissions == nil ~= (selfPermissions2 == nil) then
                        return arg3
                    end

                    if selfPermissions and selfPermissions2 and not Cryo.Dictionary.equals(selfPermissions, selfPermissions2) then
                        return arg3
                    end
                end
            end
        end

        return arg2
    end

    local var1 = createPersistReducer
    local var2 = Cryo.Dictionary.join({ storage = PersistStorage.new("currentSquadStore") }, arg1.currentSquad or {})
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[networkingSquads.CreateOrJoinSquad.Succeeded.name] = function(arg2, arg3)
        local groupUp = arg3.responseBody.groupUp
        return (func1(arg2, SquadModel.format(groupUp)))
    end

    tbl1[networkingSquads.GetSquadActive.Succeeded.name] = function(arg2, arg3)
        local groupUp = arg3.responseBody.groupUp

        if groupUp then
            return (func1(arg2, SquadModel.format(groupUp)))
        end
        return nil
    end

    tbl1[networkingSquads.GetSquadFromSquadId.Succeeded.name] = function(arg2, arg3)
        local groupUp = arg3.responseBody.groupUp
        local squadId = arg2 and arg2.squadId
        if groupUp and groupUp.groupUpId == squadId then
            return (func1(arg2, SquadModel.format(groupUp)))
        end
        return arg2
    end

    tbl1[networkingSquads.JoinSquad.Succeeded.name] = function(arg2, arg3)
        local groupUp = arg3.responseBody.groupUp
        return (func1(arg2, SquadModel.format(groupUp)))
    end

    tbl1[networkingSquads.LeaveSquad.Succeeded.name] = function(arg2, arg3)
        local groupUpId = arg3.postBody.groupUpId
        return if arg2 and arg2.squadId == groupUpId then nil else arg2
    end

    tbl1[networkingSquads.ActOnPartyNudge.Succeeded.name] = function(arg2, arg3)
        local groupUp = arg3.responseBody.groupUp
        if groupUp then
            return (func1(arg2, SquadModel.format(groupUp)))
        end
        return arg2
    end

    tbl1[CurrentSquadUpdated.name] = function(arg2, arg3)
        local squad = arg3.payload.squad
        if not squad then
            return nil
        end

        return (func1(arg2, SquadModel.format(squad)))
    end

    tbl1[SelfPermissionUpdated.name] = function(arg2, arg3)
        if not FFlagEnableSquadRegroupExperimentation then
            return arg2
        end

        if arg2 == nil then
            return arg2
        end

        local selfPermissions = arg3.payload and arg3.payload.selfPermissions
        if selfPermissions == nil then
            return arg2
        end
        local var3 = arg2.selfPermissions or {}
        local var4 = Cryo.Dictionary.join(var3, selfPermissions)
        return (Cryo.Dictionary.join(arg2, { selfPermissions = var4 }))
    end

    return var1(var2, createReducer(nil, tbl1))
end
