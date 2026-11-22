-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquads = script:FindFirstAncestor("RoduxSquads")
local RoduxSquadsParent = RoduxSquads.Parent

local t = require(RoduxSquadsParent.t)

local ExperienceInviteState = require(RoduxSquads.Enums.ExperienceInviteState)
local ExperienceInviteVoteType = require(RoduxSquads.Enums.ExperienceInviteVoteType)
local ExperienceInviteType = require(RoduxSquads.Enums.ExperienceInviteType)

local FFlagEnablePrivatePartyAcceptInvite = require(RoduxSquadsParent.SharedFlags).FFlagEnablePrivatePartyAcceptInvite

local function getSpotsTaken(votes): number -- Luacid: Inlined by compiler; 2 call sites recovered
    local num1 = 0
    for i = 1, #votes do
        if votes[i].voteType == ExperienceInviteVoteType.Accept then
            num1 += 1
        end
    end

    return num1
end

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    local votes = arg1.votes or {{
        userId = 456,
        voteIdentifier = "voteIdentifier",
        voteType = ExperienceInviteVoteType.Accept
    }}
    local spotsTaken = getSpotsTaken(votes)
    local module2 = module.new({
        createdAtTime = arg1.createdAtTime or "2024-07-19T21:02:47.777+00:00",
        experienceInviteId = arg1.experienceInviteId or "987",
        experienceDetail = arg1.experienceDetail or {
            placeId = 15308759682,
            gameInstanceId = "instanceId"
        },
        inviterId = arg1.inviterId or 123456,
        membershipEntityId = arg1.membershipEntityId or "54321",
        spotsTaken = spotsTaken,
        state = arg1.state or ExperienceInviteState.Active,
        totalSpots = arg1.totalSpots or 6,
        versionId = arg1.version or 1,
        votes = votes
    })

    if FFlagEnablePrivatePartyAcceptInvite then
        module2.inviteType = arg1.inviteType or ExperienceInviteType.PlayWithPartyInPublicServer
    end

    return module2
end

function module.format(arg1)
    local votes = arg1.votes
    local module2 = module.new({
        createdAtTime = arg1.createdAtTime,
        experienceDetail = arg1.experienceDetail,
        experienceInviteId = arg1.experienceInviteId,
        inviterId = arg1.inviterId,
        membershipEntityId = arg1.membershipEntityId,
        spotsTaken = getSpotsTaken(votes),
        state = arg1.state,
        totalSpots = arg1.totalSpots,
        versionId = arg1.versionId,
        votes = votes
    })

    if FFlagEnablePrivatePartyAcceptInvite then
        module2.inviteType = arg1.inviteType or ExperienceInviteType.PlayWithPartyInPublicServer
    end

    return module2
end

module.isValid = t.strictInterface({
    createdAtTime = t.string,
    experienceDetail = t.interface({ placeId = t.number, gameInstanceId = t.optional(t.string) }),
    experienceInviteId = t.string,
    inviterId = t.number,
    membershipEntityId = t.string,
    spotsTaken = t.number,
    state = t.string,
    totalSpots = t.number,
    versionId = t.number,
    votes = t.array(t.interface({ userId = t.number, voteIdentifier = t.optional(t.string), voteType = t.string })),
    inviteType = t.optional(
        t.union(
            t.literal(ExperienceInviteType.PlayWithPartyInPublicServer),
            t.literal(ExperienceInviteType.PlayWithPartyInPrivatePartyServer)
        )
    )
})

return module
