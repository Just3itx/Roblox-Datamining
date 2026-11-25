-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Cryo = require(SquadsCoreParent.Cryo)
local _RoduxSquads = require(SquadsCoreParent.RoduxSquads)
local Signals = require(SquadsCoreParent.Signals)
local createSessionScopedSignal = require(SquadsCoreParent.SignalsUtils).createSessionScopedSignal

local ExperienceInviteModel = require(SquadsCore.RoduxSquads).Models.ExperienceInviteModel

local function getAndUpdateState(arg1, model)
    if arg1
        and arg1.notification.experienceInviteId == model.experienceInviteId
        and (arg1.model == nil or arg1.model.versionId < model.versionId)
    then
        return Cryo.Dictionary.join(arg1, { model = model })
    end

    return arg1
end

return function()
    local getIsExperienceInvitePending, var2 = createSessionScopedSignal(false)

    local getCurrentExperienceInvite, var4 = createSessionScopedSignal(nil)

    local getHasCurrentExperienceInvite = Signals.createComputed(function(arg1): boolean
        return getCurrentExperienceInvite(arg1) ~= nil
    end)

    local function func1(arg1)
        assert(arg1, "Experience invite must exist.")
        local var5 = ExperienceInviteModel.format(arg1)
        var4(function(arg2)
            return getAndUpdateState(arg2, var5)
        end)
    end

    return {
        getIsExperienceInvitePending = getIsExperienceInvitePending,
        getCurrentExperienceInvite = getCurrentExperienceInvite,
        getHasCurrentExperienceInvite = getHasCurrentExperienceInvite,
        currentExperienceInviteStatusUpdated = function(bool1: boolean)
            var2(bool1)
        end,
        currentExperienceInviteReceived = function(experienceInviteId: string, membershipEntityId: string, notificationId: string, isInviter: boolean)
            var4(function(arg1)
                return if arg1 == nil or arg1.notification.experienceInviteId ~= experienceInviteId then {
                    notification = {
                        experienceInviteId = experienceInviteId,
                        membershipEntityId = membershipEntityId,
                        notificationId = notificationId,
                        isInviter = isInviter
                    }
                } else arg1
            end)
        end,
        currentExperienceInviteUpdated = func1,
        currentExperienceInviteDismissed = function(notificationId: string)
            var4(function(arg1)
                return if arg1 and arg1.notification.notificationId == notificationId then nil else arg1
            end)
        end,
        getExperienceInviteSucceeded = func1,
        voteForExperienceInviteSucceeded = func1,
        reset = function()
            var2(false)
            var4(nil)
        end
    }
end
