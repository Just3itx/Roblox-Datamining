-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent

local SquadInviteeModel = require(script.Parent.SquadInviteeModel)
local SquadMemberModel = require(script.Parent.SquadMemberModel)
local SquadSelfPermissionsModel = require(script.Parent.SquadSelfPermissionsModel)

local Cryo = require(RoduxSquadsParent.Cryo)
local t = require(RoduxSquadsParent.t)

local FFlagEnableSquadRegroupExperimentation = require(RoduxSquadsParent.SharedFlags).FFlagEnableSquadRegroupExperimentation

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function tryGetSquadId(arg1)
    return arg1.groupUpId or arg1.squadId
end

function module.mock(arg1)
    arg1 = arg1 or {}

    local members = Cryo.List.map(arg1.members or {{ userId = 1234 }}, function(arg2)
        return SquadMemberModel.mock(arg2)
    end)

    local invitees = Cryo.List.map(arg1.invitees or {{
        userId = 2345,
        invitedAtTimestampMs = 3333333
    }}, function(arg2)
        return SquadInviteeModel.mock(arg2)
    end)

    local tbl1 = { canSeeRegroupPromptToast = false, canSeeRegroupJoinButton = false }

    return (module.new({
        squadId = tryGetSquadId(arg1) or "12345",
        initiatorId = arg1.initiatorId or 54321,
        createdAtTime = arg1.createdAtTime or "2024-07-19T21:02:47.777+00:00",
        updatedAtTime = arg1.updatedAtTime or "2024-07-19T21:02:47.777+00:00",
        deletedAtTime = arg1.deletedAtTime,
        parentChannelId = arg1.parentChannelId or "23456",
        members = members,
        invitees = invitees,
        selfPermissions = if FFlagEnableSquadRegroupExperimentation then arg1.selfPermissions or tbl1 else nil
    }))
end

function module.format(arg1)
    local members = Cryo.List.map(arg1.members, function(arg2)
        return SquadMemberModel.format(arg2)
    end)

    local invitees = Cryo.List.map(arg1.invitees, function(arg2)
        return SquadInviteeModel.format(arg2)
    end)

    return (module.new({
        createdAtTime = arg1.createdAtTime,
        deletedAtTime = arg1.deletedAtTime,
        initiatorId = arg1.initiatorId,
        invitees = invitees,
        members = members,
        parentChannelId = arg1.parentChannelId,
        squadId = tryGetSquadId(arg1),
        updatedAtTime = arg1.updatedAtTime,
        selfPermissions = if FFlagEnableSquadRegroupExperimentation then arg1.selfPermissions else nil
    }))
end

local strictInterface = t.strictInterface
local tbl1 = {
    createdAtTime = t.string,
    deletedAtTime = t.optional(t.string),
    initiatorId = t.number,
    invitees = t.array(SquadInviteeModel.isValid),
    members = t.array(SquadMemberModel.isValid),
    parentChannelId = t.string,
    squadId = t.string,
    updatedAtTime = t.string,
    selfPermissions = if FFlagEnableSquadRegroupExperimentation then t.optional(SquadSelfPermissionsModel.isValid) else t.none
}
module.isValid = strictInterface(tbl1)

return module
