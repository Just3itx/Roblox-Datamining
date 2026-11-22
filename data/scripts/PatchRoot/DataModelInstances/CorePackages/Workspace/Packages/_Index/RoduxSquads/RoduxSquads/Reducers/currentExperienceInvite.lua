-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local Logger = require(RoduxSquads.Logger)
local RoduxSquadsParent = RoduxSquads.Parent
local Cryo = require(RoduxSquadsParent.Cryo)
local Rodux = require(RoduxSquadsParent.Rodux)
local CurrentExperienceInviteUpdated = require(RoduxSquads.Actions).CurrentExperienceInviteUpdated
local CurrentExperienceInviteDismissed = require(RoduxSquads.Actions).CurrentExperienceInviteDismissed
local CurrentExperienceInviteReceived = require(RoduxSquads.Actions).CurrentExperienceInviteReceived
local ExperienceInviteModel = require(RoduxSquads.Models).ExperienceInviteModel

local _RoduxSquadsTypes = require(script.Parent.Parent.RoduxSquadsTypes)

return function(arg1)
    local networkingSquads = arg1.NetworkingSquads

    local function func1(arg2, model)
        if arg2
            and arg2.notification.experienceInviteId == model.experienceInviteId
            and (arg2.model == nil or arg2.model.versionId < model.versionId)
        then
            return Cryo.Dictionary.join(arg2, { model = model })
        end

        return arg2
    end

    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[networkingSquads.CreateExperienceInvite.Succeeded.name] = function<T>(arg2: T, arg3): T
        local responseBody = arg3.responseBody
        Logger:debug("Create experience invite success. ExperienceInviteId: {}", responseBody.experienceInviteId)

        return arg2
    end

    tbl1[networkingSquads.GetExperienceInvite.Succeeded.name] = function(arg2, arg3)
        local responseBody = arg3.responseBody

        assert(responseBody, "Experience invite must exist.")
        return func1(arg2, ExperienceInviteModel.format(responseBody))
    end

    tbl1[networkingSquads.VoteForExperienceInvite.Succeeded.name] = function(arg2, arg3)
        local responseBody = arg3.responseBody
        Logger:debug("Vote experience invite success. ExperienceInviteId: {}", responseBody.experienceInviteId)
        return func1(arg2, ExperienceInviteModel.format(responseBody))
    end

    tbl1[CurrentExperienceInviteUpdated.name] = function(arg2, arg3)
        local experienceInvite = arg3.payload.experienceInvite
        assert(experienceInvite, "Experience invite must exist.")
        return func1(arg2, ExperienceInviteModel.format(experienceInvite))
    end

    tbl1[CurrentExperienceInviteReceived.name] = function(arg2, arg3)
        local experienceInviteId = arg3.payload.experienceInviteId

        if arg2 ~= nil and arg2.notification.experienceInviteId == experienceInviteId then
            return arg2
        end

        return {
            notification = {
                experienceInviteId = experienceInviteId,
                membershipEntityId = arg3.payload.membershipEntityId,
                notificationId = arg3.payload.notificationId,
                isInviter = arg3.payload.isInviter
            }
        }
    end

    tbl1[CurrentExperienceInviteDismissed.name] = function(arg2, arg3)
        return if arg2 and arg2.notification.notificationId == arg3.payload.notificationId then nil else arg2
    end

    return createReducer(nil, tbl1)
end
